//
//  UIColor+extension.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import UIKit

extension UIColor {
    static func appYellowColor() -> UIColor {
        UIColor(red: 247 / 255,
                green: 206 / 255,
                blue: 23 / 255,
                alpha: 1)
    }
    
    static func appLightGrayColor() -> UIColor {
        .lightGray.withAlphaComponent(0.2)
    }
}
