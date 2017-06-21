//
//  InnoCheckBoxButton.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 20/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

@IBDesignable public class InnoCheckBoxButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   @IBInspectable public var isChecked: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
   
    override public func draw(_ rect: CGRect) {
        if isChecked == true {
            self.setBackgroundImage(UIImage(named: "checkBoxMarked"), for: UIControlState.normal)
        } else {
            self.setBackgroundImage(UIImage(named: "checkBox"), for: UIControlState.normal)
        }
        self.setTitle("", for: .normal)
    }

}
