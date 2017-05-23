//
//  UIImageView+InnoImage.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import Foundation

// MARK: - Image in circle UIImageView extension
public extension UIImageView {
    /// Crop image to circle
    public func cropImageCircular() {
        self.layer.cornerRadius = bounds.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }

}
