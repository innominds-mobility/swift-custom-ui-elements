//
//  ViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

/// The purpose of this view controller is to provide a user interface for Custom UI elements.
/// There's a matching scene in the *Main.storyboard* file, and in that scene there are Custom UI elements.
/// Go to Interface Builder for details.
/// The `ViewController` class is a subclass of the `UIViewController`.

class ViewController: UIViewController {
    // MARK: - IBOutlet Properties

    /// The textfield for the progress Value.
    @IBOutlet weak var progressValTextFld: UITextField!

    /// The view (subclass of progressBarView) for the progressViewBar.
    @IBOutlet weak var progressBarView: InnoProgressViewBar!

    /// The button for the show progress.
    @IBOutlet weak var showButton: InnoButton!

    /// The view (subclass of customProgressView) for the progressCircle.
    @IBOutlet weak var customProgressView: InnoProgressViewCircle!
    ///Refernce for currnet view
    var currentWindow: UIWindow?
       // MARK: - Default View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Progress View"

        /// Tap gesture recognizer for dismissing keyboard.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                    action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        currentWindow = UIApplication.shared.keyWindow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     // MARK: - Textfield delegate Methods
    /// UITextfield delegate method/
    ///
    /// - Parameter textField: The text field whose return button was pressed.
    /// - Returns: YES if the text field should implement its default behavior for the return button; otherwise, NO.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

     // MARK: Tap gesture handle Method

    /// Tap gesture handle Method.
    func dismissKeyboard() {
        view.endEditing(true)
    }

     // MARK: - IBAction Methods
    /// It triggers changing of progress value. Shows progress value in circle and bar.
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func showProgressButtonAction(_ sender: Any) {
        view.endEditing(true)
        if progressValTextFld.text != ""{
            progressBarView.progressValue = CGFloat(Float(progressValTextFld.text!)!)
            customProgressView.setNeedsDisplay()
            customProgressView.progress = CGFloat(Float(progressValTextFld.text!)!)/100 // Value should be in decimals
            // toast message with progress value
            currentWindow!.makeToast(message:
                "Progress value is \(progressValTextFld.text!)"
            )
        }
    }
    /// It triggers range selection view controller.
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func showRangeSliderButtonAction(_ sender: Any) {

        /// get reference for RangeSelectionViewController.
        if let rangeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "RangeSelectionViewController") as? RangeSelectionViewController {
            /// Check for navigation control and push to RangeSelectionViewController.
            if let navigator = navigationController {
                navigator.pushViewController(rangeVC, animated: true)
            }
        }

    }

    /// It triggers Radiant background view
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func gotoRadiantView(_ sender: UIButton) {
        if let radiantVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "RadiantBackgroundViewController") as? RadiantBackgroundViewController {
            if let navigator = navigationController {
                navigator.pushViewController(radiantVC, animated: true)
            }
        }
    }
    /// It triggers Custom Textfield
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func gotoCustomTextField(_ sender: UIButton) {
        if let customTxtFldVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "BottomBorderTextFieldViewController") as? BottomBorderTextFieldViewController {
            if let navigator = navigationController {
                navigator.pushViewController(customTxtFldVC, animated: true)
            }
        }
    }
    @IBAction func goToImageShapes(_ sender: Any) {
        if let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "ImageShapesViewController") as? ImageShapesViewController {
            if let navigator = navigationController {
                navigator.pushViewController(imageVC, animated: true)
            }
        }
    }
}
