//
//  MainVCPresenter.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import Foundation

// MARK: - View protocol

protocol MainViewProtocol: AnyObject {
    func jobsLoaded()
    func imageLoaded()
    func failure(error: Error)
}

// MARK: - Presenter protocol

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol,
         networkManager: NetworkServiceProtocol)
    var jobs: JobsModel { get set }
    var filteredJobs: JobsModel  { get set }
    func getJobs()
    func loadImage(jobModel: JobModel, indexItem: Int)
}

// MARK: - Presenter

final class MainViewControllerPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkManager: NetworkServiceProtocol?
    var jobs: JobsModel = []
    var filteredJobs: JobsModel = []
    
    required init(view: MainViewProtocol,
        networkManager: NetworkServiceProtocol
    ) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getJobs() {
        networkManager?.getJobsRequest { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let jobs):
                    self.jobs += jobs.models
                    self.view?.jobsLoaded()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }

    func loadImage(jobModel: JobModel, indexItem: Int) {
        guard let logoUrl = jobModel.logo else { return }
        networkManager?.loadImageData(from: logoUrl) { [weak self] result in
            guard let self,
                  let imageData = result else { return }
            DispatchQueue.main.async {
                self.jobs[indexItem].logoData = imageData
                self.view?.imageLoaded()
            }
        }
    }
}
