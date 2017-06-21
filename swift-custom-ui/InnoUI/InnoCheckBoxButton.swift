//
//  InnoCheckBoxButton.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 20/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

/// The purpose of this class is to provide check box button.
/// The `InnoCheckBoxButton` class is a subclass of the `UIButton`.
@IBDesignable public class InnoCheckBoxButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   /// Bool for check box selection.
   @IBInspectable public var isChecked: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
   
    /// Performing custom drawing for check box.
    ///
    /// - Parameter rect: The portion of the view’s bounds that needs to be updated.
    override public func draw(_ rect: CGRect) {
        if isChecked == true {
            self.setBackgroundImage(UIImage(named: "checkBoxMarked"), for: UIControlState.normal)
        } else {
            self.setBackgroundImage(UIImage(named: "checkBox"), for: UIControlState.normal)
        }
        self.setTitle("", for: .normal)
    }

}
