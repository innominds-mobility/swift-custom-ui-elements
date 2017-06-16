//
//  CustomLoadingIndicatorVC.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 16/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

class CustomLoadingIndicatorVC: UIViewController {

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    var isFirstStart: Bool = true
    var isSecStart: Bool = true
    lazy fileprivate var customIndicator: CustomLoadingIndicator = {
        let image: UIImage = UIImage(named: "ColorSpinner")!
        return CustomLoadingIndicator(innoImage: image)
    }()
    lazy fileprivate var secondIndi: CustomLoadingIndicator = {
        let secImage: UIImage = UIImage(named: "spinner1")!
        return CustomLoadingIndicator(innoImage: secImage)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(customIndicator)
        let firstPoint = CGPoint(x:firstButton.frame.origin.x+firstButton.frame.size.width/2,
                                 y:firstButton.frame.origin.y+firstButton.frame.size.height+80)
        customIndicator.center = firstPoint//self.view.center
        self.view.addSubview(secondIndi)
        let sPoint = CGPoint(x: secondButton.frame.origin.x+secondButton.frame.size.width/2,
                             y :secondButton.frame.origin.y+secondButton.frame.size.height+80)
        secondIndi.center = sPoint//self.view.center
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
