//
//  ViewController.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import UIKit

private enum Section: Int {
    case main
}

final class MainViewController: UIViewController {
    
    // MARK: Properties
    var presenter: MainPresenterProtocol?
    private var dataSource: UICollectionViewDiffableDataSource<Section, JobModel>?
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: UI elements
    
    private var searchController: UISearchController = {
        let sc = UISearchController()
        sc.searchBar.placeholder = "Поиск"
        sc.searchBar.searchBarStyle = .minimal
        return sc
    }()
    
    private lazy var jobsCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            JobCell.self,
            forCellWithReuseIdentifier: JobCell.identifier
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appLightGrayColor()
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let reserveView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reserveButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.defaultReserveButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .appLightGrayColor()
        button.addTarget(nil,
                         action: #selector(reserveButtonPressed),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.isEnabled = false
        return button
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        additionSubviews()
        setupLayout()
        configureNavigationController()
        setupDataSource()
        
        presenter?.getJobs()
    }

    private func saveUserSettings() {
        guard let presenter else { return }
        presenter.saveSelectedCells(selectedCells: getReservedJobs())
    }
}

// MARK: - Configure view properties

private extension MainViewController {
    func configureView() {
        view.backgroundColor = .white
    }
}

// MARK: - Setup view

private extension MainViewController {
    func additionSubviews() {
        view.addSubview(jobsCollectionView)
        view.addSubview(reserveView)
        reserveView.addSubview(reserveButton)
    }
}

// MARK: - Setup layouts for UI

private extension MainViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jobsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            jobsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            jobsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reserveView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            reserveView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            reserveView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            reserveView.heightAnchor.constraint(equalToConstant: Constants.cellHeight)
        ])
        
        NSLayoutConstraint.activate([
            reserveButton.topAnchor.constraint(
                equalTo: reserveView.topAnchor,
                constant: Constants.indentFromSuperView
            ),
            reserveButton.leadingAnchor.constraint(
                equalTo: reserveView.leadingAnchor,
                constant: Constants.indentFromSuperView
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: reserveButton.trailingAnchor,
                constant: Constants.indentFromSuperView
            ),
            reserveButton.heightAnchor.constraint(equalTo: reserveView.heightAnchor, multiplier: 0.4)
        ])
    }
}

// MARK: - Configure navigation controller

private extension MainViewController {
    func configureNavigationController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func filterContentForSearchText(_ searchText: String) {
        guard let presenter else { return }
       
        presenter.filteredJobs = presenter.jobs.filter { jobModel in
            if isSearchBarEmpty {
                return false
            } else {
                return jobModel.employer.lowercased().contains(searchText.lowercased()) || jobModel.profession.lowercased().contains(searchText.lowercased())
            }
        }
        if isSearchBarEmpty {
            createDataSnapshot(items: presenter.jobs)
        } else {
            createDataSnapshot(items: presenter.filteredJobs)
        }
    }
}

// MARK: - Search methods

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        filterContentForSearchText(filter)
    }
}

// MARK: - Collection layout methods

private extension MainViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(Constants.cellHeight)
        )

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(Constants.cellHeight)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [layoutItem]
        )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(
            top: Constants.layoutSectionInset,
            leading: Constants.layoutSectionInset,
            bottom: Constants.cellHeight,
            trailing: Constants.layoutSectionInset
        )
        layoutSection.interGroupSpacing = Constants.layoutSectionInset
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - Collection DataSource setup

private extension MainViewController {
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, JobModel>(collectionView: jobsCollectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, item: JobModel) -> UICollectionViewCell? in
            guard let self,
                let presenter = self.presenter,
                let cell = jobsCollectionView.dequeueReusableCell(
                withReuseIdentifier: JobCell.identifier,
                for: indexPath
            ) as? JobCell else { return JobCell() }
            
            let jobs = self.isFiltering ? presenter.filteredJobs : presenter.jobs
            let item = jobs[indexPath.item]
            
            if item.logoData == nil {
                presenter.loadImage(
                    jobModel: item,
                    indexItem: indexPath.item
                )
            }
            cell.configureCell(jobModel: item)
            return cell
        }
    }
    
    func createDataSnapshot(items: JobsModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, JobModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(
            snapshot,
            animatingDifferences: false
        )
    }
    
    func updateDataSnapshot(withAnimation: Bool = false) {
        guard let presenter,
            var updatedSnapshot = dataSource?.snapshot() else { return }
        if isSearchBarEmpty {
            updatedSnapshot.reloadItems(presenter.jobs)
        } else {
            updatedSnapshot.reloadItems(presenter.filteredJobs)
        }
        self.dataSource?.apply(
            updatedSnapshot,
            animatingDifferences: withAnimation
        )
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter else { return }
        presenter.jobs[indexPath.item].isSelected.toggle()
        updateDataSnapshot()
        updateStateReserveButton()
        saveUserSettings()
    }
    
    private func updateStateReserveButton() {
        let reservedJobs = getReservedJobs()
        if reservedJobs.count == .zero {
            reserveButton.setTitle(
                Constants.defaultReserveButtonTitle,
                for: .normal
            )
            reserveButton.backgroundColor = .appLightGrayColor()
            reserveButton.isEnabled = false
        } else {
            var postFixTitle = ""
            let lastNumber = Int(String(reservedJobs.count.description.suffix(2))) ?? 0
            switch lastNumber {
                case 0 : postFixTitle = "подработок"
                case 1 : postFixTitle = "подработку"
                case 2...4 : postFixTitle = "подработки"
                case 5...19 : postFixTitle = "подработок"
                default: break
            }
            reserveButton.setTitle(
                "Забронировать \(reservedJobs.count) \(postFixTitle)",
                for: .normal
            )
            reserveButton.backgroundColor = .appYellowColor()
            reserveButton.isEnabled = true
        }
    }
    
    func getReservedJobs() -> JobsModel {
        guard let jobs = presenter?.jobs else { return JobsModel() }
        return jobs.filter { $0.isSelected }
    }
}

// MARK: - Loading data with network service

extension MainViewController: MainViewProtocol {
    func jobsLoaded() {
        guard let presenter else { return }
        createDataSnapshot( items: presenter.jobs)
        updateStateReserveButton()
    }
    
    func imageLoaded() {
        DispatchQueue.main.async {
            self.updateDataSnapshot()
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Handle actions methods

private extension MainViewController {
    
    @objc func reserveButtonPressed() {
        showSumSalaryAlert()
    }
    
    func showSumSalaryAlert() {
        let reservedJobs = getReservedJobs().map { $0.salary }.reduce( 0, + )
  
        let message = "Вы заработали \(String(format: "%.2f", reservedJobs)) рублей"
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Constants

private enum Constants {
    static var indentFromSuperView: CGFloat = 20
    static var layoutSectionInset: CGFloat = 10
    static let cellHeight: CGFloat = 105
    
    static var defaultReserveButtonTitle = "Выберите подработки"
}


