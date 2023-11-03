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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        additionSubviews()
        setupLayout()
        configureSearchBar()
        setupDataSource()
        
        presenter?.getJobs()
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
    }
}

// MARK: - Configure Search bar

private extension MainViewController {
    func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func filterContentForSearchText(_ searchText: String) {
        guard let presenter = presenter else { return }
        presenter.filteredJobs = presenter.jobs.filter { jobModel in
            if isSearchBarEmpty {
                return false
            } else {
                return jobModel.employer.lowercased().contains(searchText.lowercased()) || jobModel.profession.lowercased().contains(searchText.lowercased())
            }
        }
        if isSearchBarEmpty {
            updateData(items: presenter.jobs, withAnimation: true)
        } else {
            updateData(items: presenter.filteredJobs, withAnimation: true)
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
            heightDimension: .absolute(105)
        )

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(105)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [layoutItem]
        )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        layoutSection.interGroupSpacing = 10
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - Collection DataSource setup

private extension MainViewController {
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, JobModel>(collectionView: jobsCollectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, item: JobModel) -> UICollectionViewCell? in
            guard let self,
                  let presenter = self.presenter else { return JobCell() }
            let jobs = self.isFiltering ?  presenter.filteredJobs : presenter.jobs
            let cell = jobsCollectionView.dequeueReusableCell(withReuseIdentifier: JobCell.identifier, for: indexPath) as? JobCell
            
            let item = jobs[indexPath.row]
            
            if item.logoData == nil {
                presenter.loadImage(jobModel: item, indexItem: indexPath.row)
            }
            cell?.configureCell(jobModel: item)
            return cell
        }
    }
    
    func updateData(items: JobsModel, withAnimation: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, JobModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

// MARK: - Loading data with network service

extension MainViewController: MainViewProtocol {
    func jobsLoaded() {
        guard let presenter = presenter else { return }
        updateData(items: presenter.jobs, withAnimation: true)
    }
    
    func imageLoaded(indexJob: Int) {
        guard 
            let jobs = presenter?.jobs,
            var updatedSnapshot = dataSource?.snapshot() 
        else { return }
        updatedSnapshot.reloadItems(jobs)
        dataSource?.apply(updatedSnapshot, animatingDifferences: true)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Constants

private enum Constants {
    static var halfOfPointAlpha: CGFloat = 0.5
    static var veryLightAlpha: CGFloat = 0.2
    
    static let gifViewRadius: CGFloat = 8
    static let spacingStackView: CGFloat = 5
}


