//
//  ImageItem.swift
//  Moonlighting
//
//  Created by Sonata Girl on 02.11.2023.
//

import UIKit

class ImageItem: Hashable {
    var image: UIImage!
    let url: URL!
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(image: UIImage, url: URL) {
        self.image = image
        self.url = url
    }
}
