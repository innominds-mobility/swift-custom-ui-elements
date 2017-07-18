//
//  InnoAnimatedRippleButton.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 12/07/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this class is to provide animation effects(ripples) for UIbutton. 
/// The `InnoAnimatedRippleButton` class is a subclass of the `UIButton`.
@IBDesignable public class InnoAnimatedRippleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    /// UIColor for ripples.
    @IBInspectable open var ripplesColor: UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            ripplesView.backgroundColor = ripplesColor
        }
    }
    /// Ripple percent in float.
    @IBInspectable open var ripplesPercent: Float = 0.8 {
        didSet {
            setupRippleView()
        }
    }
    /// Background color for ripples.
    @IBInspectable open var ripplesBackgroundColor: UIColor = UIColor(white: 0.95, alpha: 1) {
        didSet {
            ripplesBackgroundView.backgroundColor = ripplesBackgroundColor
        }
    }
    /// Bool for Ripple over bounds.
    @IBInspectable open var rippleOverBounds: Bool = false
    /// Shadow ripple radius.
    @IBInspectable open var shadowRippleRadius: Float = 1
    /// Bool for Track touch location.
    @IBInspectable open var trackTouchLocation: Bool = false
    /// Touch animation time.
    @IBInspectable open var touchUpAnimationTime: Double = 0.6
    /// Bool for enabling shadow ripples.
    @IBInspectable open var shadowRippleEnable: Bool = true
    /// Ripples View.
    let ripplesView = UIView()
    /// Ripples background view.
    let ripplesBackgroundView = UIView()
    
    /// Temp shadow radius.
    fileprivate var tempShadowRadius: CGFloat = 0
    /// Temp shadow opacity.
    fileprivate var tempShadowOpacity: Float = 0
    /// CGPoint for touch center location.
    fileprivate var touchCenterLocation: CGPoint?
    
    /// Create shape layer for ripples.
    fileprivate var ripplesMask: CAShapeLayer? {
//       get {
            if !rippleOverBounds {
                /// Shape layer for ripples.
                let maskLayer = CAShapeLayer()
                maskLayer.path = UIBezierPath(roundedRect: bounds,
                                              cornerRadius: layer.cornerRadius).cgPath
                return maskLayer
            } else {
                return nil
            }
//        }
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /// Design ripple view on UIButton.
    fileprivate func setup() {
        setupRippleView()
        ripplesBackgroundView.backgroundColor = ripplesBackgroundColor
        ripplesBackgroundView.frame = bounds
        ripplesBackgroundView.addSubview(ripplesView)
        ripplesBackgroundView.alpha = 0
        addSubview(ripplesBackgroundView)
        layer.shadowRadius = 0
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
    }
    
    /// Set up ripple view.
    fileprivate func setupRippleView() {
        /// Size of ripple view.
        let size: CGFloat = bounds.width * CGFloat(ripplesPercent)
        /// x- coordinate for ripple view.
        let x: CGFloat = (bounds.width/2) - (size/2)
        /// y- coordinate for ripple view.
        let y: CGFloat = (bounds.height/2) - (size/2)
        /// Corner radius for ripple view.
        let corner: CGFloat = size/2
        
        ripplesView.backgroundColor = ripplesColor
        ripplesView.frame = CGRect(x: x, y: y, width: size, height: size)
        ripplesView.layer.cornerRadius = corner
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if trackTouchLocation {
            touchCenterLocation = touch.location(in: self)
        } else {
            touchCenterLocation = nil
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            self.ripplesBackgroundView.alpha = 1
        }, completion: nil)
        
        ripplesView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.7, delay: 0, options:
            [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.allowUserInteraction],
                       animations: {
                        self.ripplesView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        if shadowRippleEnable {
            tempShadowRadius = layer.shadowRadius
            tempShadowOpacity = layer.shadowOpacity
            
            /// Shadow radius basic animation.
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = shadowRippleRadius
            
            /// Shadow opacity basic animation.
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = 1
            
            /// Animation group.
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.7
            groupAnim.fillMode = kCAFillModeForwards
            groupAnim.isRemovedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            
            layer.add(groupAnim, forKey:"shadow")
        }
        return super.beginTracking(touch, with: event)
    }
    
    override open func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        animateToNormal()
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        animateToNormal()
    }
    
    /// Animate to Normal.
    fileprivate func animateToNormal() {
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            self.ripplesBackgroundView.alpha = 1
        }, completion: {(_: Bool) -> Void in
            UIView.animate(withDuration: self.touchUpAnimationTime, delay: 0,
                           options: UIViewAnimationOptions.allowUserInteraction, animations: {
                self.ripplesBackgroundView.alpha = 0
            }, completion: nil)
        })
        UIView.animate(withDuration: 0.7, delay: 0,
                       options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction],
                       animations: {
                        self.ripplesView.transform = CGAffineTransform.identity
                        
                        /// Shadow radius animation.
                        let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
                        shadowAnim.toValue = self.tempShadowRadius
                        /// Shadow opacity animation.
                        let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
                        opacityAnim.toValue = self.tempShadowOpacity
                        
                        /// Animation Group.
                        let groupAnim = CAAnimationGroup()
                        groupAnim.duration = 0.7
                        groupAnim.fillMode = kCAFillModeForwards
                        groupAnim.isRemovedOnCompletion = false
                        groupAnim.animations = [shadowAnim, opacityAnim]
                        
                        self.layer.add(groupAnim, forKey:"shadowBack")
        }, completion: nil)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        setupRippleView()
        if let knownTouchCenterLocation = touchCenterLocation {
            ripplesView.center = knownTouchCenterLocation
        }
        
        ripplesBackgroundView.layer.frame = bounds
        ripplesBackgroundView.layer.mask = ripplesMask
    }
}
