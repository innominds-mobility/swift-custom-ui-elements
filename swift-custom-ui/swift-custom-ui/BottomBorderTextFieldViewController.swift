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

class BottomBorderTextFieldViewController: UIViewController {
    @IBOutlet weak var firstTextfld: UITextField!
    @IBOutlet weak var secondTxtfld: UITextField!
    override func viewDidLoad() {
        customizeTextField(textField: firstTextfld, borderWidth: 1, borderColor: UIColor.purple)
        customizeTextField(textField: secondTxtfld, borderWidth: 1, borderColor: UIColor.brown)
    }
    /**
     */
    func customizeTextField(textField: UITextField, borderWidth: CGFloat, borderColor: UIColor) {
        let border: CALayer = CALayer()
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0, y: (textField.frame.size.height-borderWidth)),
                              size: CGSize(width: textField.frame.size.width, height: textField.frame.size.height))
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
}
