//
//  InnoProgressView.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit



@IBDesignable public class InnoProgressView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable public var progress: CGFloat = 0.0
    @IBInspectable public var progressColor: UIColor = UIColor.orange
    @IBInspectable public var progressDefaultColor: UIColor = UIColor.lightGray
    @IBInspectable public var progressWidth:CGFloat = 0.0
    
    override public func draw(_ rect: CGRect) {
        // Add ARCs
        self.addArcForProgress(progressVal: 1.0, strokeColor: self.progressDefaultColor)
        self.addArcForProgress(progressVal: self.progress, strokeColor: self.progressColor)
    }
    // Drawing a circle with  Bezier path
    
   public func addArcForProgress(progressVal:CGFloat, strokeColor:UIColor) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
    
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = self.progressWidth//10
        let startAngle: CGFloat = 3 * 3.14/2// 3* π / 4
        let endAngle: CGFloat = startAngle + CGFloat(2 * 3.14 * progressVal)//π / 4
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        strokeColor.setStroke()
        path.stroke()
    }

}
