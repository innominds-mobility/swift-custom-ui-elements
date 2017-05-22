//
//  UIImageView+InnoImage.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import Foundation

public extension UIImageView {
    public func cropImageCircular() {
        self.layer.cornerRadius = bounds.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }

}
