//
//  Bulder.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import UIKit

// MARK: - Builder protocol

protocol Builder {
    static func createMainViewController() -> UIViewController
}

// MARK: - Module builder

final class ModuleBuilder: Builder {
    static func createMainViewController() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkService()
        let presenter = MainViewControllerPresenter(
            view: view,
            networkManager: networkManager
        )
        view.presenter = presenter
        return view
    }
}
