//
//  ImageShapesViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

class ImageShapesViewController: UIViewController {

    @IBOutlet weak var circularImage: UIImageView!
    @IBOutlet weak var squareImge: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        circularImage.cropImageCircular()
        let profilImg = UIImage(named: "profileImg")
        let sqrImg = profilImg?.cropImageSquared()
        squareImge.image = sqrImg
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
