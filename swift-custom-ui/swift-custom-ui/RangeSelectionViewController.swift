//
//  RangeSelectionViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 12/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

/// The purpose of this view controller is to provide a user interface for Range selection UI element.
/// There's a matching scene in the *Main.storyboard* file, and in that scene there is Rnage selection object. 
/// Go to Interface Builder for details.
/// The `RangeSelectionViewController` class is a subclass of the `UIViewController`.
class RangeSelectionViewController: UIViewController {
    // MARK: - IBOutlet Properties

    /// The InnoRangeSelectionSlider for the Range selection.
    @IBOutlet weak var rangeSlider: InnoRangeSelectionSlider!

    /// The UiLabel for showing Selected value
    @IBOutlet weak var selectedValLbl: UILabel!

    // MARK: - Default View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Range Slider"
        self.getRangeSelectionText()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction Methods

    /// It triggers capturing of range values and shows in label.
    ///
    /// - Parameter sender: The text field whose return button was pressed.
    @IBAction func innoRangeSelectionSliderValueChanged(_ sender: Any) {
        self.getRangeSelectionText()
    }
    // MARK: 

    /// Method to show the value of range slider values
    func getRangeSelectionText() {
        let lowVal = Int(rangeSlider.lowerValue)
        let highVal = Int(rangeSlider.upperValue)
        self.selectedValLbl.text = "Selected Range: \(lowVal) to \(highVal)"
    }
}
