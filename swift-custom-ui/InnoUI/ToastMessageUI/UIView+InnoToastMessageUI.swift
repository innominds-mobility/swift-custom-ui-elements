//
//  UIView+InnoToastMessageUI.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 16/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

// MARK: Toast Message UIview properties

/// Toast Default position
let toastPositionDefault  =   "bottom"
/// Toast Top position
let toastPositionTop      =   "top"
/// Toast Center position
let toastPositionCenter   =   "center"
/// Toast Horizontal margin
let toastHorizontalMargin: CGFloat  =   10.0
/// Toats Vertical Margin
let toastVerticalMargin: CGFloat  =   10.0
/// Toast Default duration time
let toastDefaultDuration  =   2.0
/// Toast fading duration time
let toastFadeDuration     =   0.2
/// Toast Message font size
let messageFontSize: CGFloat  = 19.0

// Toast message label settings
/// Toast view maximum width
let toastMaxWidth: CGFloat  = 0.8;  //80% of ParentView width
/// Toast view maximum height
let toastMaxHeight: CGFloat  = 0.8
/// Toast message maximum number of lines
let toastMaxMessageLines     = 0
// Toast shadow appearance
/// Toast shadow opacity value
let toastShadowOpacity: CGFloat   = 0.8
/// Toast shadow radius
let toastShadowRadius: CGFloat   = 6.0
/// Toast shadow offset
let toastShadowOffset: CGSize    = CGSize(width: CGFloat(4.0), height: CGFloat(4.0))

/// Toast view opacity
let toastOpacity: CGFloat   = 0.9
/// Toast view corner radius
let toastCornerRadius: CGFloat   = 8.0
/// Toast timer
var toastTimer: UnsafePointer<Timer>?
/// Toast view
var toastView: UnsafePointer<UIView>?
/// Toast hides on tap
let toastHidesOnTap       =   true
/// Toast display shadow
let toastDisplayShadow    =   true

// MARK: - Toast Message UIView extension
/*
 Extension for UIView. Get the toast message from app, 
 prepare the toast message label according to that message's width & height.
 Add that message label to the view with different background color.
 */
public extension UIView {
    // Making the toast message
    /// Making a toast view
    ///
    /// - Parameter msg: Message to be displayed in toast
    func makeToast(message msg: String) {
        let toast = self.viewForMessage(msg)
        showToast(toast: toast!, duration: toastDefaultDuration, position: toastPositionDefault as AnyObject)
    }
    // Showing the Toast message.
    fileprivate func showToast(toast: UIView, duration: Double, position: AnyObject) {
        toast.center = centerPointForPosition(position, toast: toast)
        toast.alpha = 0.0
         // Tap gesture is added for toast message, on tap of it toast will be hidden
        if toastHidesOnTap {
            let tapRecognizer = UITapGestureRecognizer(target: toast, action: #selector(UIView.handleToastTapped(_:)))
            toast.addGestureRecognizer(tapRecognizer)
            toast.isUserInteractionEnabled = true
            toast.isExclusiveTouch = true
        }

        addSubview(toast)
        objc_setAssociatedObject(self, &toastView, toast, .OBJC_ASSOCIATION_RETAIN)
        //On completion timer is fired, after certain duration toast will be hidden
        UIView.animate(withDuration: toastFadeDuration,
                       delay: 0.0, options: ([.curveEaseOut, .allowUserInteraction]),
                       animations: {
                        toast.alpha = 1.0
        },
                       completion: { (_: Bool) in
                        let timer = Timer.scheduledTimer(timeInterval: duration,
                                        target: self, selector: #selector(UIView.toastTimerDidFinish(_:)),
                                        userInfo: toast, repeats: false)
                        objc_setAssociatedObject(toast, &toastTimer, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }
    //Hiding the toast message
    func hideToast(toast: UIView) {
        hideToast(toast: toast, force: false)
    }

    func hideToast(toast: UIView, force: Bool) {
        let completeClosure = { (finish: Bool) -> Void in
            toast.removeFromSuperview()
            objc_setAssociatedObject(self, &toastTimer, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        if force {
            completeClosure(true)
        } else {
            UIView.animate(withDuration: toastFadeDuration,
                           delay: 0.0,
                           options: ([.curveEaseIn, .beginFromCurrentState]),
                           animations: {
                            toast.alpha = 0.0
            },
                           completion:completeClosure)
        }
    }
     // Timer finish handle method
    func toastTimerDidFinish(_ timer: Timer) {
        hideToast(toast: (timer.userInfo as? UIView)!)
    }
    // Tap gesture handle method
    func handleToastTapped(_ recognizer: UITapGestureRecognizer) {
        let timer = objc_getAssociatedObject(self, &toastTimer) as? Timer!
        timer?.invalidate()
        hideToast(toast: recognizer.view!)
    }
    // This function decides where to display the Toast message i.e top or center or bottom
    fileprivate func centerPointForPosition(_ position: AnyObject, toast: UIView) -> CGPoint {
        if position is String {
            let toastSize = toast.bounds.size
            let viewSize  = self.bounds.size
            if position.lowercased == toastPositionTop {
                return CGPoint(x: viewSize.width/2, y: toastSize.height/2 + toastVerticalMargin)
            } else if position.lowercased == toastPositionDefault {
                return CGPoint(x: viewSize.width/2, y: viewSize.height - toastSize.height/2 - toastVerticalMargin)
            } else if position.lowercased == toastPositionCenter {
                return CGPoint(x: viewSize.width/2, y: viewSize.height/2)
            }
        } else if position is NSValue {
            return position.cgPointValue
        }
        print("Warning! Invalid position for toast.")
        return self.centerPointForPosition(toastPositionDefault as AnyObject, toast: toast)
    }
    /* 
     Creating the view for Toast. A shadow is created for the toast view.
     Message label dimensions are calculated dynamically based on given toast message.
     */
    fileprivate func viewForMessage(_ msg: String?) -> UIView? {
        if msg == nil { return nil }
        var msgLabel: UILabel? ; let wrapperToastView = UIView()
        wrapperToastView.autoresizingMask = ([.flexibleLeftMargin,
                            .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin])
        wrapperToastView.layer.cornerRadius = toastCornerRadius
        wrapperToastView.backgroundColor = UIColor.black.withAlphaComponent(toastOpacity)
        if toastDisplayShadow {
            wrapperToastView.layer.shadowColor = UIColor.black.cgColor
            wrapperToastView.layer.shadowOpacity = Float(toastShadowOpacity)
            wrapperToastView.layer.shadowRadius = toastShadowRadius
            wrapperToastView.layer.shadowOffset = toastShadowOffset
        }
        if msg != nil {
            msgLabel = UILabel()
            msgLabel!.numberOfLines = toastMaxMessageLines
            msgLabel!.font = UIFont(name: "Optima-Regular", size: messageFontSize) //Any font
            msgLabel!.lineBreakMode = .byWordWrapping
            msgLabel!.textAlignment = .center
            msgLabel!.textColor = UIColor.white
            msgLabel!.backgroundColor = UIColor.clear
            msgLabel!.alpha = 1.0
            msgLabel!.text = msg
            let maxSizeMessage = CGSize(width: (self.bounds.size.width * toastMaxWidth),
                                        height: self.bounds.size.height * toastMaxHeight)
            let expectedHeight = msg!.toastStringHeightWithFontSize(messageFontSize, width: maxSizeMessage.width)
            msgLabel!.frame = CGRect(x: 0.0, y: 0.0, width: maxSizeMessage.width, height: expectedHeight)
        }
        var msgWidth: CGFloat, msgHeight: CGFloat, msgTop: CGFloat, msgLeft: CGFloat
        if msgLabel != nil {
            msgWidth = msgLabel!.bounds.size.width;msgHeight = msgLabel!.bounds.size.height
            msgTop = toastVerticalMargin ;msgLeft = toastHorizontalMargin
        } else {
            msgWidth = 0.0; msgHeight = 0.0; msgTop = 0.0; msgLeft = 0.0
        }
        let largerWidth = max(0, msgWidth); let largerLeft  = max(0, msgLeft)
        let wrapperWidth  = max(toastHorizontalMargin * 2,
                                largerLeft + largerWidth + toastHorizontalMargin) // set wrapper view's frame
        let wrapperHeight = max(msgTop + msgHeight + toastVerticalMargin, toastVerticalMargin * 2)
        wrapperToastView.frame = CGRect(x: 0.0, y: 0.0, width: wrapperWidth, height: wrapperHeight)
        // add subviews
        if msgLabel != nil {
            msgLabel!.frame = CGRect(x: msgLeft, y: msgTop, width: msgWidth, height: msgHeight)
            wrapperToastView.addSubview(msgLabel!)
        }
        return wrapperToastView
    }
}

/*
    Extension for String, Getting height for toast message dynamically. 
Need to provide font name and size for the toast message to calculate the height.
 */
public extension String {
    func toastStringHeightWithFontSize(_ fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont(name: "Optima-Regular", size: messageFontSize)// Use any Font like "Helvetica"
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName: font!,
                          NSParagraphStyleAttributeName: paragraphStyle.copy()]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
}
