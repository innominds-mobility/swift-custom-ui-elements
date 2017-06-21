//
//  ButtonsViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 23/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

/// The purpose of this view controller is to provide a user interface
/// for showing transparent UIbutton.
/// Go to Interface Builder for details.
/// The `ButtonsViewController` class is a subclass of the `UIViewController`.
class ButtonsViewController: UIViewController {
     // MARK: - IBOutlet properties
    /// The button for Design button(transparent)
    @IBOutlet weak var designButton: UIButton!
    @IBOutlet weak var checkBoxButton: InnoCheckBoxButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Button Styles"
        designButton.setUpInnoDesign()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checkBoxClickAction(_ sender: Any) {
        if checkBoxButton.isChecked {
            checkBoxButton.isChecked = false
        } else {
            checkBoxButton.isChecked = true
        }
    }
}
