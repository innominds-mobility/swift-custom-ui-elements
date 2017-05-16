//
//  InnoRangeSelectionSlider.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 12/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: Class: Drawing for Range selection slider Track layer

/**
 This class draws rectangle for track layer on a bezier path and fills color to it. 
 curvaceousness defines the cornerradius for track layer.
 And changes the selected tarck/range with a different color i.e trackHighlightTintColor
 */

class RangeSelectionSliderTrackLayer: CALayer {
    weak var rangeSlider: InnoRangeSelectionSlider?
    override func draw(in contex: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
            // Track layer
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            contex.addPath(path.cgPath)

            // Fill the track
            contex.setFillColor(slider.trackTintColor.cgColor)
            contex.addPath(path.cgPath)
            contex.fillPath()

            // Fill the highlighted range
            contex.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValPosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
            let upperValPosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            let rect = CGRect(x: lowerValPosition, y: 0.0,
                              width: upperValPosition - lowerValPosition,
                              height: bounds.height)
            contex.fill(rect)

    }

}

// MARK: Class: Drawing for Range Indicator layer

/**
 This class draws rectangle 
 [In the form of circle or square] for track indicator layer on a bezier path and fills color to it.
 curvaceousness defines the cornerradius for indicator layer. 
 And changes indicator color when it is highlighted.
 */

class RangeSliderIndicatorLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: InnoRangeSelectionSlider?
    var strokeColor: UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineWidth: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else {
         return
        }
            let indicatorFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = indicatorFrame.height * slider.curvaceousness / 2.0
            let indicatorPath = UIBezierPath(roundedRect: indicatorFrame, cornerRadius: cornerRadius)

            // Fill indicator

            ctx.setFillColor(slider.indicatorTintColor.cgColor)
            ctx.addPath(indicatorPath.cgPath)
            ctx.fillPath()

            // Outline indicator
            ctx.setStrokeColor(strokeColor.cgColor)
            ctx.setLineWidth(lineWidth)
            ctx.addPath(indicatorPath.cgPath)
            ctx.strokePath()

            if highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(indicatorPath.cgPath)
                ctx.fillPath()
            }
    }
}

// MARK: Class: Range Selection Slider

/**
 This class combines track layer and indicators layer to form a selection slider for selecting a range.
 Defines different properties to change the UI dynamically.
 */

@IBDesignable public class InnoRangeSelectionSlider: UIControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable public var minValue: Double = 0.0 {
        didSet {
            updateRangeSliderLayerFrames()
        }
    }

    @IBInspectable public var maxValue: Double = 1.0 {
        didSet {
            updateRangeSliderLayerFrames()
        }
    }

    @IBInspectable public var lowerValue: Double = 0.3 {
        didSet {
            if lowerValue < minValue {
                lowerValue = minValue
            }
            updateRangeSliderLayerFrames()
        }
    }

    @IBInspectable public var upperValue: Double = 0.9 {
        didSet {
            if upperValue > maxValue {
                upperValue = maxValue
            }
            updateRangeSliderLayerFrames()
        }
    }
    var gapBetweenIndicators: Double {
        return 0.5 * Double(indicatorWidth) * (maxValue - minValue) / Double(bounds.width)
    }

    @IBInspectable public var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    @IBInspectable public var
    trackHighlightTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    @IBInspectable public var indicatorTintColor: UIColor = UIColor.white {
        didSet {
            lowerIndicatorLayer.setNeedsDisplay()
            upperIndicatorLayer.setNeedsDisplay()
        }
    }
    // To change curve/cornerradius for indicator.
    @IBInspectable public var curvaceousness: CGFloat = 1.0 {
        didSet {
            if curvaceousness < 0.0 { //Forms square shape, with corner radius
                curvaceousness = 0.0
            }

            if curvaceousness > 1.0 {// Circle
                curvaceousness = 1.0
            }
            trackLayer.setNeedsDisplay() // Changing the track with corner radius
            lowerIndicatorLayer.setNeedsDisplay() // Changing the indicator with corner radius
            upperIndicatorLayer.setNeedsDisplay() // Changing the indicator with corner radius
        }
    }

    fileprivate var previusLocPoint = CGPoint()
    fileprivate let trackLayer = RangeSelectionSliderTrackLayer()
    fileprivate let lowerIndicatorLayer = RangeSliderIndicatorLayer()
    fileprivate let upperIndicatorLayer = RangeSliderIndicatorLayer()

   fileprivate var indicatorWidth: CGFloat {
        return CGFloat(bounds.height)
    }

    override public var frame: CGRect {
        didSet {
            updateRangeSliderLayerFrames()
        }
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializeLayers()

        }

    required public init(coder: NSCoder) {
        super.init(coder: coder)!
        initializeLayers()
    }

    fileprivate func initializeLayers() {
        lowerIndicatorLayer.rangeSlider = self
        upperIndicatorLayer.rangeSlider = self
        trackLayer.rangeSlider = self

        layer.backgroundColor = UIColor.clear.cgColor

        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        lowerIndicatorLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerIndicatorLayer)

        upperIndicatorLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperIndicatorLayer)
    }
    override public func layoutSublayers(of ofLayer: CALayer) {
        super.layoutSublayers(of:layer)
        updateRangeSliderLayerFrames()
    }

    // MARK: Updating the UI for Range slider 

    func updateRangeSliderLayerFrames() {

        CATransaction.begin()
        CATransaction.setDisableActions(true)

        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()

        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))

        lowerIndicatorLayer.frame = CGRect(x: lowerThumbCenter - indicatorWidth / 2.0,
                                           y: 0.0,
                                           width: indicatorWidth,
                                           height: indicatorWidth)
        lowerIndicatorLayer.setNeedsDisplay()

        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperIndicatorLayer.frame = CGRect(x: upperThumbCenter - indicatorWidth / 2.0,
                                           y: 0.0,
                                           width: indicatorWidth,
                                           height: indicatorWidth)
        upperIndicatorLayer.setNeedsDisplay()

        CATransaction.commit()
    }

    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - indicatorWidth) * (value - minValue) /
            (maxValue - minValue) + Double(indicatorWidth / 2.0)
    }

    //UIControl provides several methods for tracking touches

    // MARK: UIControl "beginTracking" method for starting the movement

    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previusLocPoint = touch.location(in: self)

        // Hit test the Indicator layers
        if lowerIndicatorLayer.frame.contains(previusLocPoint) {
            lowerIndicatorLayer.highlighted = true
        } else if upperIndicatorLayer.frame.contains(previusLocPoint) {
            upperIndicatorLayer.highlighted = true
        }

        return lowerIndicatorLayer.highlighted || upperIndicatorLayer.highlighted
    }

    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

     // MARK: UIControl "continueTracking" method to continue movement

    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // Determine how much the user has dragged the indicator
        let deltaLocation = Double(location.x - previusLocPoint.x)
        let deltaValue = (maxValue - minValue) * deltaLocation / Double(bounds.width - indicatorWidth)

        previusLocPoint = location

        // Update the values of indicators
        if lowerIndicatorLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue,
                                    toLowerValue: minValue,
                                    upperValue: upperValue - gapBetweenIndicators)
        } else if upperIndicatorLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue,
                                    toLowerValue: lowerValue+gapBetweenIndicators,
                                    upperValue:maxValue)
        }

        sendActions(for: .valueChanged)
        return true
    }

    // MARK: UIControl "endTracking" method to end touch/movement

    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerIndicatorLayer.highlighted = false
        upperIndicatorLayer.highlighted = false
    }

}
