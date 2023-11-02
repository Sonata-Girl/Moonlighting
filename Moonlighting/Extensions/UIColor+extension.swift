//
//  UIColor+extension.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import UIKit

extension UIColor {
    static func appYellowColor() -> UIColor {
        UIColor(red: 255 / 255,
                green: 204 / 255,
                blue: 0 / 255,
                alpha: 1)
    }
    
    static func appLightGrayColor() -> UIColor {
        .lightGray.withAlphaComponent(0.2)
    }
}
