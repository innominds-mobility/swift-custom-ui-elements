//
//  InnoProgressViewBar.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 10/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

@IBDesignable public class InnoProgressViewBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable public var progressValue: CGFloat = 0.0{
        didSet{
            self.drawProgressBarLayer(incremented: progressValue)
        }
    }
    @IBInspectable public var barCornerRadius: CGFloat = 0.0{
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = barCornerRadius
        }
    }
    @IBInspectable public var barColor: UIColor = UIColor.clear
    @IBInspectable public var progressColor: UIColor = UIColor.green
    
    override public func draw(_ rect: CGRect) {
        // Add ARCs
        self.drawDefaultBarLayer()
        self.drawProgressBarLayer(incremented: self.progressValue)
    }
    
    var borderLayer : CAShapeLayer = CAShapeLayer()
    let progressBarLayer : CAShapeLayer = CAShapeLayer()
    
    // MARK: Drawing default bar layer method
    
    /**
     This method draws default rectangle bar layer on a bezier path and fills default color to it. This layer is added as a sublayer for self.
     */
    
    func drawDefaultBarLayer(){
        
        let bezierPath = UIBezierPath(roundedRect:bounds, cornerRadius: self.barCornerRadius)
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        borderLayer.fillColor = self.barColor.cgColor
        borderLayer.strokeEnd = 0
        self.layer.addSublayer(borderLayer)
    }
    
    // MARK: Drawing Progress Bar layer Method
    /**
     
     This method draws/redraws progress bar layer on bezier path and fills progress color to it. This layer is added as a sublayer for 'borderLayer'. For every change in progress value, this method is called.
     */

    func drawProgressBarLayer(incremented : CGFloat){
        
//        print("incrementingg val.........",incremented)
        if incremented*(bounds.width-10)/100 <= bounds.width - 10{
            progressBarLayer.removeFromSuperlayer()
            let bezierPathProgessBar = UIBezierPath(roundedRect: CGRect(x:5,y: 5, width:incremented*(bounds.width-10)/100,height:bounds.height - 10) , cornerRadius: self.barCornerRadius)
            bezierPathProgessBar.close()
            progressBarLayer.path = bezierPathProgessBar.cgPath
            progressBarLayer.fillColor = self.progressColor.cgColor
            borderLayer.addSublayer(progressBarLayer)
            
        }
        
    }
}
