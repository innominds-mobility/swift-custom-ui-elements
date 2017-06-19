//
//  CustomLoadingIndicatorVC.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 16/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI
/// The purpose of this view controller is to provide a user interface
/// for showing custom loading indicator.
class CustomLoadingIndicatorVC: UIViewController {

    /// The Button for First button
    @IBOutlet weak var firstButton: UIButton!
    /// The Button for Second button
    @IBOutlet weak var secondButton: UIButton!
    /// Bool for first loading start
    var isFirstStart: Bool = true
    /// Bool for second loading start
    var isSecStart: Bool = true
    /// Custom indicator object
    lazy fileprivate var customIndicator: CustomLoadingIndicator = {
        /// Image of loading indicator
        let image: UIImage = UIImage(named: "ColorSpinner")!
        return CustomLoadingIndicator(innoImage: image)
    }()
    /// Custom indicator object
    lazy fileprivate var secondIndi: CustomLoadingIndicator = {
        /// Image for loading indicator
        let secImage: UIImage = UIImage(named: "spinner1")!
        return CustomLoadingIndicator(innoImage: secImage)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(customIndicator)
        self.view.addSubview(secondIndi)
        self.title = "Custom Loading Indicator"
        firstButton.layer.cornerRadius = firstButton.frame.size.height/2
        secondButton.layer.cornerRadius = secondButton.frame.size.height/2
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// CGpoint for loading indicator
        let firstPoint = CGPoint(x:firstButton.frame.origin.x+firstButton.frame.size.width/2,
                                 y:firstButton.frame.origin.y+firstButton.frame.size.height+80)
        customIndicator.center = firstPoint
        /// CGpoint for loading indicator
        let sPoint = CGPoint(x: secondButton.frame.origin.x+secondButton.frame.size.width/2,
                             y :secondButton.frame.origin.y+secondButton.frame.size.height+80)
        secondIndi.center = sPoint//self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// It triggers start and stop for Loading indicator.
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func firstButtonAction(_ sender: Any) {
        if isFirstStart {
            customIndicator.startCustomLoading()
            firstButton.setTitle("Stop Loading", for: UIControlState.normal)
            isFirstStart = false
        } else {
            isFirstStart = true
            customIndicator.stopCustomLoading()
            firstButton.setTitle("Start Loading", for: UIControlState.normal)
        }
    }
    /// It triggers start and stop for Loading indicator.
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func secondButtonAction(_ sender: Any) {
        if isSecStart {
            isSecStart = false
            secondIndi.startCustomLoading()
            secondButton.setTitle("Stop Loading", for: UIControlState.normal)
        } else {
            secondIndi.stopCustomLoading()
            isSecStart = true
            secondButton.setTitle("Start Loading", for: UIControlState.normal)
        }
    }
}
