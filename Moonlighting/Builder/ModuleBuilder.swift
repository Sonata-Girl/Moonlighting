//
//  Bulder.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import UIKit

protocol Builder {
    static func createMainViewController() -> UIViewController
}

final class Builder: Builder
