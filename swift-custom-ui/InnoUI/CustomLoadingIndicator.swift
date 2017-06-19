//
//  CustomLoadingIndicator.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 16/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this class is to provide Custom loading indicator.
/// The `CustomLoadingIndicator` class is a subclass of the `UIView`.
public class CustomLoadingIndicator: UIView {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    /// Animation layer.
    lazy fileprivate var innoAnimationLayer: CALayer = {
        return CALayer()
    }()
    /// Bool for layer animating.
    var isLayerAnimating: Bool = false
    /// Bool for hiding loading.
    var hidesWhenStopped: Bool = true
    /// Init method for indictor creation.
    ///
    /// - Parameter innoImage: Image that invokes this method.
    public init(innoImage: UIImage) {
        /// Frame for indicator
        let frame: CGRect = CGRect(x: 0.0, y: 0.0, width: innoImage.size.width, height: innoImage.size.height)
        super.init(frame: frame)
        innoAnimationLayer.frame = frame
        innoAnimationLayer.masksToBounds = true
        innoAnimationLayer.contents = innoImage.cgImage
        self.layer.addSublayer(innoAnimationLayer)
        
        addRotationForImageLayer(forLayer: innoAnimationLayer)
        pauseAnimationLayer(layer: innoAnimationLayer)
        self.isHidden = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adding rotation for image layer.
    ///
    /// - Parameter layer: The layer that invokes this method.
    func addRotationForImageLayer(forLayer layer: CALayer) {
        let layerRotation: CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        layerRotation.fillMode = kCAFillModeForwards
        layerRotation.isRemovedOnCompletion = false
        layerRotation.repeatCount = HUGE
        layerRotation.duration = 1.0
        layerRotation.fromValue = NSNumber(value: 0.0 as Float)
        layerRotation.toValue = NSNumber(value: 3.14 * 2.0 as Float)
        layer.add(layerRotation, forKey: "rotate")
    }
    
    /// Pause the animation for layer.
    ///
    /// - Parameter layer: The layer that invokes this method.
    func pauseAnimationLayer(layer: CALayer) {
        /// Pause time
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.timeOffset = pausedTime
        layer.speed = 0.0
        isLayerAnimating = false
    }
    
    /// Resume animation.
    ///
    /// - Parameter layer: The layer that invokes this method.
    func resumeAnimating(layer: CALayer) {
        /// Pause time.
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.beginTime = 0.0
        layer.timeOffset = 0.0
        /// Time since pause
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isLayerAnimating = true
    }
    
   /// Starting custom loading.
   public func startCustomLoading () {
        if isLayerAnimating {
            return
        }
        if hidesWhenStopped {
            self.isHidden = false
        }
        resumeAnimating(layer: innoAnimationLayer)
    }
    
   /// Stopping custom loading.
   public func stopCustomLoading () {
        if hidesWhenStopped {
            self.isHidden = true
        }
        pauseAnimationLayer(layer: innoAnimationLayer)
    }
}
