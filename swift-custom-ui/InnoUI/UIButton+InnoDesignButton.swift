//
//  UIButton+InnoDesignButton.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 23/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import Foundation

// MARK: - Button as Rounded with transparent backgrounds, UIButton extension
extension UIButton {
    /// Set up Transparent button
    public func setUpInnoDesign() {
        /// Button title color
        let buttonTitleColor: UIColor = self.titleColor(for: UIControlState.normal)!
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2.0
        self.layer.borderColor = buttonTitleColor.cgColor//UIColor.black.cgColor
        self.layer.cornerRadius = 10.0
        self.layer.shadowRadius =  2.0
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOpacity =  0.2
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(buttonTitleColor.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        /// Color Image
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.clipsToBounds = true
        self.setBackgroundImage(colorImage, for: UIControlState.highlighted)
        self.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        self.setTitleColor(UIColor.white, for: UIControlState.selected)
    }
}
