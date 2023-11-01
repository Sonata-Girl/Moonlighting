//
//  ViewController.swift
//  Moonlighting
//
//  Created by Sonata Girl on 30.10.2023.
//

import UIKit

private enum RecipeListSection: Int {
    case main
}

final class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private var jobList: [JobModel] = []
    private var filteredJobList: [JobModel] = []
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    // MARK: UI Elements
    
    private var searchController: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter employer/profession"
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
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        configureView()
    }
}

// MARK: - Setup view

private extension MainViewController {
    func setupHierarchy() {
        view.addSubview(searchController.searchBar)
        view.addSubview(jobsCollectionView)
    }
}

// MARK: - Setup layouts for UIElements

private extension MainViewController {
    func setupLayout() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jobsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            jobsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: jobsCollectionView.trailingAnchor,constant: 10)
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
        filteredJobList = jobList.filter { jobModel in
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
            heightDimension: .fractionalHeight(1)
        )
    
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [layoutItem]
        )
        layoutGroup.interItemSpacing = .fixed(5)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        layoutSection.interGroupSpacing = 5
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - CollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
}

// MARK: - CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
           return filteredJobList.count
         }
           
         return jobList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        jobsCollectionView.dequeueReusableCell(withReuseIdentifier: JobCell.identifier, for: indexPath)
    }
}

// MARK: - Constants

private enum Constants {
    static var halfOfPointAlpha: CGFloat = 0.5
    static var veryLightAlpha: CGFloat = 0.2
    
    static let gifViewRadius: CGFloat = 8
    static let spacingStackView: CGFloat = 5
}


