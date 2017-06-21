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
/// for showing transparent UIbutton and check box.
/// Go to Interface Builder for details.
/// The `ButtonsViewController` class is a subclass of the `UIViewController`.
class ButtonsViewController: UIViewController {
     // MARK: - IBOutlet properties.
    /// The button for Design button(transparent).
    @IBOutlet weak var designButton: UIButton!
    /// The InnoCheckBoxButton for check box.
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
    /// It triggers the check box selection.
    ///
    /// - Parameter sender: The button that invokes this IBOutlet action.
    @IBAction func checkBoxClickAction(_ sender: Any) {
        if checkBoxButton.isChecked {
            checkBoxButton.isChecked = false
        } else {
            checkBoxButton.isChecked = true
        }
    }
}
