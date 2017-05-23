//
//  UIImage+InnoSquareImg.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import Foundation

// MARK: - Image crop to Square shapr UIImage extension
/*Extension for UIView. Get the toast message from app,
prepare the toast message label according to that message's width & height.
Add that message label to the view with different background color.
*/
extension UIImage {
    /// Crops image to square shape
    ///
    /// - Returns: UIimage with squared
    public func cropImageSquared() -> UIImage? {
        /// Image height
        var imageHeight = self.size.height
        /// Image width
        var imageWidth = self.size.width
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        } else {
            imageWidth = imageHeight
        }
        /// Size of image
        let size = CGSize(width: imageWidth, height: imageHeight)
        /// Actual image width
        let refWidth: CGFloat = CGFloat(self.cgImage!.width)
        /// Actual image height
        let refHeight: CGFloat = CGFloat(self.cgImage!.height)
        /// x coordinate for image
        let x = (refWidth - size.width) / 2
        /// y coordinate for image
        let y = (refHeight - size.height) / 2
        /// Required image rect
        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        /// Cropped image or reqired image
        if let imageRef = self.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: (self.imageOrientation))
        }
        return nil
    }

}
