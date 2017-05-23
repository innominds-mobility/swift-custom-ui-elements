//
//  ImageShapesViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

/// The purpose of this view controller is to provide a user interface for UIImageView as circular and UIImage as Square.
/// Go to Interface Builder for details.
/// The `ImageShapesViewController` class is a subclass of the `UIViewController`.
class ImageShapesViewController: UIViewController {
    // MARK: - IBOutlet Properties
    /// The imageview for the Circular image.
    @IBOutlet weak var circularImage: UIImageView!
    /// The imageview for square image
    @IBOutlet weak var squareImge: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        circularImage.cropImageCircular()
        /// Profile Image reference
        let profilImg = UIImage(named: "profileImg")
        /// UIImage with square shape
        let sqrImg = profilImg?.cropImageSquared()
        squareImge.image = sqrImg
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
