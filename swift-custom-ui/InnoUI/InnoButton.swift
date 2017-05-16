//
//  InnoButton.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

@IBDesignable public class InnoButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
