//
//  InnoProgressView.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

/// The purpose of this class is to provide custom view for showing progress in a circle.
/// The `InnoProgressViewCircle` class is a subclass of the `UIView`.
@IBDesignable public class InnoProgressViewCircle: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    /// IBInspectable for Progress color of InnoProgressViewCircle
    @IBInspectable public var progressColor: UIColor = UIColor.orange {
        didSet {
            setNeedsDisplay()
        }
    }
    /// IBInspectable for Progress default color of InnoProgressViewCircle
    @IBInspectable public var progressDefaultColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    /// IBInspectable for Progress width of InnoProgressViewCircle
    @IBInspectable public var progressWidth: CGFloat = 0.0
    /// IBInspectable for Progress value of InnoProgressViewCircle
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet {
            self.drawProgressCircleViewLayer(progressVal:progress, strokeColor: self.progressColor)
        }
    }
    /// Performing custom drawing for progress circle
    ///
    /// - Parameter rect: The portion of the view’s bounds that needs to be updated
    override public func draw(_ rect: CGRect) {
        // Add ARCs
        self.drawDefaultCircleLayer()
        self.drawProgressCircleViewLayer(progressVal: self.progress, strokeColor: self.progressColor)
    }
    /// Shape layer for default circle
    var defaultCircleLayer: CAShapeLayer = CAShapeLayer()
    /// Shape layer for progress circle
    let progressCircleLayer: CAShapeLayer = CAShapeLayer()

    // MARK: Drawing default circle layer method
    /// This method draws default circle layer on a bezier path and adds a stroke color to it.
    func drawDefaultCircleLayer() {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = self.progressWidth
        let startAngle: CGFloat = 3 * 3.14/2// 3* π / 4
        let endAngle: CGFloat = startAngle + CGFloat(2 * 3.14 * 1.0)//π / 4
        let defaultPath = UIBezierPath(arcCenter: center,
                                        radius: radius/2 - arcWidth/2,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        defaultPath.lineWidth = arcWidth
        self.progressDefaultColor.setStroke()
        defaultPath.stroke()
        defaultPath.close()

        defaultCircleLayer.path = defaultPath.cgPath
        defaultCircleLayer.fillColor = UIColor.clear.cgColor
        defaultCircleLayer.strokeEnd = 0
        self.layer.addSublayer(defaultCircleLayer)
    }
    // MARK: Drawing Progress circle layer Method
    /// This method draws/redraws progress circle layer on bezier path and adds a stroke color to it.
    /// This layer is added as a sublayer for 'defaultCircleLayer'.
    /// For every change in progress value, this method is called.
    ///
    /// - Parameters:
    ///   - progressVal: Progress value for circle
    ///   - strokeColor: color of circle
    func drawProgressCircleViewLayer(progressVal: CGFloat, strokeColor: UIColor) {

        progressCircleLayer.removeFromSuperlayer()
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = self.progressWidth
        let startAngle: CGFloat = 3 * 3.14/2// 3* π / 4
        let endAngle: CGFloat = startAngle + CGFloat(2 * 3.14 * progressVal)//π / 4
        let pCirclePath = UIBezierPath(arcCenter: center,
                                       radius: radius/2 - arcWidth/2,
                                       startAngle: startAngle,
                                       endAngle: endAngle,
                                       clockwise: true)
        pCirclePath.lineWidth = arcWidth
        strokeColor.setStroke()
        pCirclePath.stroke()
        pCirclePath.close()
        progressCircleLayer.path = pCirclePath.cgPath
        progressCircleLayer.fillColor = UIColor.clear.cgColor
        defaultCircleLayer.addSublayer(progressCircleLayer)

    }

}
