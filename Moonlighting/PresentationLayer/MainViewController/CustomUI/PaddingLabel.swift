//
//  CustomLabel.swift
//  Moonlighting
//
//  Created by Sonata Girl on 02.11.2023.
//

import UIKit

// MARK: - Custom label with insets

 class PaddingLabel: UILabel {
    
    private var insets = UIEdgeInsets()
    
    required init(insets: UIEdgeInsets) {
        super.init(frame: CGRect.zero)
        self.insets = insets
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
    }
}
