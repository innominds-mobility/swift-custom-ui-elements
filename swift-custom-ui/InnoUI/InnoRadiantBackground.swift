//
//  InnoRadiantBackground.swift
//  swift-custom-ui
//
//  Created by Aruna Kumari Yarra on 18/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this class is to provide Radiant background.
/// The `InnoRadiantBackground` class is a subclass of the `UIView`.
@IBDesignable public class InnoRadiantBackground: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    let gradientLayer = CAGradientLayer()
    
    /// Performing custom drawing for Progress bar.
    ///
    /// - Parameter rect: The portion of the view’s bounds that needs to be updated.
    override public func draw(_ rect: CGRect) {
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    // MARK: Inspectable properties
    /// Start color
    @IBInspectable public var color1: UIColor = UIColor.red {
        didSet {
            setupView()
        }
    }
    /// End color
    @IBInspectable public var color2: UIColor = UIColor.yellow {
        didSet {
            setupView()
        }
    }
    /// Raidant position
    @IBInspectable var isHorizontal: Bool = false {
        didSet {
            setupView()
        }
    }
    // MARK: Internal functions
    /// Set the view properties to display Radiant background
    private func setupView() {
        let colorsArray: Array = [color1.cgColor, color2.cgColor]
//        colorsArray.append(colors as! CGColor)
        gradientLayer.colors = colorsArray
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        if isHorizontal {
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        } else {
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        self.setNeedsDisplay()
    }
}
