//
//  InnoProgressViewBar.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 10/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this class is to provide custom view for showing progress in a bar.
/// The `InnoProgressViewBar` class is a subclass of the `UIView`.
@IBDesignable public class InnoProgressViewBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    /// IBInspectable for Progress of InnoProgressViewBar
    @IBInspectable public var progressValue: CGFloat = 0.0 {
        didSet {
            self.drawProgressBarLayer(incremented: progressValue)
        }
    }
    /// IBInspectable for Bar corner radius of InnoProgressViewBar
    @IBInspectable public var barCornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = barCornerRadius
        }
    }
    /// IBInspectable for Bar color of InnoProgressViewBar
    @IBInspectable public var barColor: UIColor = UIColor.clear
    /// IBInspectable for Progress color of InnoProgressViewBar
    @IBInspectable public var progressColor: UIColor = UIColor.green

    /// Performing custom drawing for Progress bar
    ///
    /// - Parameter rect: The portion of the view’s bounds that needs to be updated
    override public func draw(_ rect: CGRect) {
        // Add ARCs
        self.drawDefaultBarLayer()
        self.drawProgressBarLayer(incremented: self.progressValue)
    }

    /// Shape layer for Progress default bar
    var borderLayer: CAShapeLayer = CAShapeLayer()
    /// Shape layer for Progress bar
    let progressBarLayer: CAShapeLayer = CAShapeLayer()

    // MARK: Drawing default bar layer method
    /// This method draws default rectangle bar layer on a bezier path and fills default color to it.
    /// This layer is added as a sublayer for self.
    func drawDefaultBarLayer() {

        let bezierPath = UIBezierPath(roundedRect:bounds, cornerRadius: self.barCornerRadius)
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        borderLayer.fillColor = self.barColor.cgColor
        borderLayer.strokeEnd = 0
        self.layer.addSublayer(borderLayer)
    }

    // MARK: Drawing Progress Bar layer Method
    /// This method draws/redraws progress bar layer on bezier path and fills progress color to it.
    /// This layer is added as a sublayer for 'borderLayer'.
    /// For every change in progress value, this method is called.
    ///
    /// - Parameter incremented: Progress value
    func drawProgressBarLayer(incremented: CGFloat) {
        if incremented*(bounds.width-10)/100 <= bounds.width - 10 {
            progressBarLayer.removeFromSuperlayer()
            let bezierPathProgessBar = UIBezierPath(roundedRect: CGRect(x:5, y: 5,
                                                                    width:incremented*(bounds.width-10)/100,
                                                                        height:bounds.height - 10),
                                                    cornerRadius: self.barCornerRadius)
            bezierPathProgessBar.close()
            progressBarLayer.path = bezierPathProgessBar.cgPath
            progressBarLayer.fillColor = self.progressColor.cgColor
            borderLayer.addSublayer(progressBarLayer)

        }

    }
}
