//
//  RangeSelectionViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 12/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI


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
    /**
     It triggers capturing of range values and shows in label.
     
     */

    @IBAction func innoRangeSelectionSliderValueChanged(_ sender: Any) {
        self.getRangeSelectionText()
    }
    //MARK:

    // Method to show the value of range slider values
    
    func getRangeSelectionText() {
        let lowVal = Int(rangeSlider.lowerValue)
        let highVal = Int(rangeSlider.upperValue)
        self.selectedValLbl.text = "Selected Range: \(lowVal) to \(highVal)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
