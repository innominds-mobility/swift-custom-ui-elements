//
//  RadiantBackgroundViewController.swift
//  swift-custom-ui
//
//  Created by Aruna Kumari Yarra on 16/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import QuartzCore
import InnoUI

class RadiantBackgroundViewController: UIViewController {
    /// InnoRadiantBackground ref to change colors
    @IBOutlet weak var radiantView: InnoRadiantBackground!
    // MARK: - Default View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        radiantView.color1 = UIColor.yellow
        radiantView.color2 = UIColor.blue
    }
}
