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
        
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    // MARK: UI Elements
    
    private var searchController: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Поиск"
        sb.searchBar.searchBarStyle = .minimal
        return sb
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        configureView()
        configureSearchBar()
        
        presenter?.getJobs()
    }
}

// MARK: - Setup view

private extension MainViewController {
    func setupHierarchy() {
        view.addSubview(jobsCollectionView)
    }
}

// MARK: - Setup layouts for UIElements

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

// MARK: - Configure view properties

private extension MainViewController {
    func configureView() {
        view.backgroundColor = .white
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
        jobsCollectionView.reloadData()
    }
}

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

private extension MainViewController {
    func setupDataSource() {
        jobsCollectionView.dataSource =
        UICollectionViewDiffableDataSource<Section, ImageItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ImageItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: ImageItem)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ImageItem> { (cell, indexPath, item) in
            var content = UIListContentConfiguration.cell()
            content.directionalLayoutMargins = .zero
            content.axesPreservingSuperviewLayoutMargins = []
            content.image = item.image
            
            ImageCache.publicCache.load(url: item.url as NSURL, item: item) { (fetchedItem, image) in
                if let img = image, img != fetchedItem.image {
                    var updatedSnapshot = jobsCollectionView.dataSource.snapshot()
                    if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
                        let item = self.imageObjects[datasourceIndex]
                        item.image = img
                        updatedSnapshot.reloadItems([item])
                        self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                    }
                }
            }
            cell.contentConfiguration = content
        }
       
    }
}

// MARK: - CollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
}

// MARK: - Loading data with network service

extension MainViewController: MainViewProtocol {
    func jobsLoaded() {
        jobsCollectionView.reloadData()
    }
    
    func imageLoaded(indexJob: Int) {
        let indexPath = IndexPath(item: indexJob, section: 0)
        jobsCollectionView.reloadItems(at: [indexPath])
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return presenter?.filteredJobs.count ?? 0
        }
        return presenter?.jobs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let jobs = isFiltering ?  presenter?.filteredJobs : presenter?.jobs,
              let cell = jobsCollectionView.dequeueReusableCell(withReuseIdentifier: JobCell.identifier, for: indexPath) as? JobCell else { return JobCell() }
        
        let item = jobs[indexPath.row]
        
        if item.logoData == nil {
            presenter?.loadImage(jobModel: item, indexItem: indexPath.row)
        }
        cell.configureCell(jobModel: item)
        return cell
    }
}

// MARK: - Constants

private enum Constants {
    static var halfOfPointAlpha: CGFloat = 0.5
    static var veryLightAlpha: CGFloat = 0.2
    
    static let gifViewRadius: CGFloat = 8
    static let spacingStackView: CGFloat = 5
}


