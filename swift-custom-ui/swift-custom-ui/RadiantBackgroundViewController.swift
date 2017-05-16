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
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Passing only 2 parameters
//        insertGradiantLayer(color1: UIColor.yellow, color2: UIColor.green)
        
        // Passing 4 parameters, We can pass n number of parameters in order.
        insertGradiantLayer(color1: UIColor.yellow, color2: UIColor.red, colors: UIColor.green, UIColor.orange )
    }
    
    /**
     Variable number of Parameters, but minimum 2 parameters required to display radiant background.
     */
    func insertGradiantLayer(color1 : UIColor, color2 : UIColor, colors: UIColor...) {
        // 1
        gradientLayer.frame = self.view.bounds
        
        // 2
        var colorsArray = [CGColor]()
        colorsArray.append(color1.cgColor)
        colorsArray.append(color2.cgColor)
        for color in colors {
            colorsArray.append(color.cgColor)
        }
        gradientLayer.colors = colorsArray
        // 3
        self.view.layer.insertSublayer(gradientLayer, at: 0);
    }
}
