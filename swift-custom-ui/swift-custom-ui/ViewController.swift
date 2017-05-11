//
//  ViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI


class ViewController: UIViewController {

    @IBOutlet weak var progressValTextFld: UITextField!
    
    @IBOutlet weak var progressBarView: InnoProgressViewBar!
    @IBOutlet weak var showButton: InnoButton!
    @IBOutlet weak var customProgressView: InnoProgressViewCircle!
    
    @IBAction func showProgressButtonAction(_ sender: Any) {
        view.endEditing(true)
        if progressValTextFld.text != ""{
            progressBarView.progressValue = CGFloat(Float(progressValTextFld.text!)!)//80
            customProgressView.setNeedsDisplay()
            customProgressView.progress = CGFloat(Float(progressValTextFld.text!)!)/100 // Value should be in decimals
            
        }        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }

}

