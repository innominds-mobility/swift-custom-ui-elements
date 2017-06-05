//
//  BottomBorderTextFieldViewController.swift
//  swift-custom-ui
//
//  Created by Aruna Kumari Yarra on 16/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI
import QuartzCore

class BottomBorderTextFieldViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var selectedTitleColor: UIColor!
    var selectedLineColor: UIColor!
    var titleColor: UIColor!
    var lineColor: UIColor!
    var cursorColor: UIColor!
    // MARK: Animation timing
    /// The value of the title appearing duration
    dynamic open var titleFadeInDuration: TimeInterval = 0.2
    /// The value of the title disappearing duration
    dynamic open var titleFadeOutDuration: TimeInterval = 0.3
    override func viewDidLoad() {
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        selectedLineColor = overcastBlueColor
        selectedTitleColor = overcastBlueColor
        titleColor = lightGreyColor
        lineColor = lightGreyColor
        cursorColor = overcastBlueColor
        textField.textColor = darkGreyColor
        customizeCustomTextField()
        // Set custom fonts for the title, placeholder and textfield labels
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
    }
    /// Draw bottom border to Textfield
    ///
    /// - Parameters:
    ///   - textField: TextField reference ot customize
    ///   - borderWidth: Border width
    ///   - borderColor: border color
    func customizeTextField(textField: UITextField, borderWidth: CGFloat, borderColor: UIColor) {
        let border: CALayer = CALayer()
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0, y: (textField.frame.size.height-borderWidth)),
                              size: CGSize(width: textField.frame.size.width, height: textField.frame.size.height))
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    func customizeCustomTextField() {
        textField.placeholder = "Name"
        titleLabel.text = "Enter your full name"
        textField.tintColor = cursorColor
        updateColors()
        updateTitleVisibility(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        updateColors()
        updateTitleVisibility(true)
        return true
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if (!textField.hasText && (newString?.characters.count)! > 0) || (newString?.characters.count)! == 0 {
            textField.text = string
            updateColors()
            updateTitleVisibility(true)
            return false
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateColors()
        updateTitleVisibility(true)
    }
    func updateColors () {
        if isTitleVisible() {
            titleLabel.textColor = selectedTitleColor
            customizeTextField(textField: textField, borderWidth: 1, borderColor: selectedLineColor)
        } else {
            titleLabel.textColor = titleColor
            customizeTextField(textField: textField, borderWidth: 1, borderColor: lineColor)
        }
    }
    func updateTitleVisibility(_ animated: Bool = false) {
        let alpha: CGFloat = isTitleVisible() ? 1.0 : 0.0
        let frame: CGRect = titleLabelRectForBounds(self.view.bounds, editing: isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
            let animationOptions: UIViewAnimationOptions = .curveEaseOut
            let duration = isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: nil)
        } else {
            updateBlock()
        }
    }
    func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    func titleHeight() -> CGFloat {
        return 30.0
    }
    /**
     Returns whether the title is being displayed on the control.
     - returns: True if the title is displayed on the control, false otherwise.
     */
    func isTitleVisible() -> Bool {
        return textField.hasText
    }
}
