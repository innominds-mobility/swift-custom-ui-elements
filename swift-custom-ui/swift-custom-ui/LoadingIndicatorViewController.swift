//
//  LoadingIndicatorViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

/// The purpose of this view controller is to provide a user interface
/// for showing loading/ activity indicator.
class LoadingIndicatorViewController: UIViewController {

    /// The button to start loading.
    @IBOutlet weak var startButtn: UIButton!
    /// The button to start loading view.
    @IBOutlet weak var loadViewButton: UIButton!
    /// Bool for activity loading.
    var isStart: Bool = true
    /// Bool for loading view.
    var isStartView: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        startButtn.setTitle("Start Loading", for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// It triggers start and stop for Loading indicator.
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func startStopLoadingButtonAction(_ sender: Any) {
        self.stopLoadingIndicator()
        self.stopLoadingView()
        if isStart {
            isStart = false
            startButtn.setTitle("Stop Loading", for: .normal)
            self.startLoadingIndicator(style: UIActivityIndicatorViewStyle.gray, location:view.center)
        } else {
            isStart = true
            startButtn.setTitle("Start Loading", for: .normal)
            self.stopLoadingIndicator()
        }
    }
    /// It triggers start and stop for Loading view.
    ///
    /// - Parameter sender: The button that invokes this IBAction method.
    @IBAction func startStopLoadingViewAction(_ sender: Any) {
        self.stopLoadingView()
        self.stopLoadingIndicator()
        if isStartView {
            isStartView = false
            loadViewButton.setTitle("Stop LoadingView", for: .normal)
             self.startLoadingView(loadTitle: "Hello loading..")
        } else {
            isStartView = true
            loadViewButton.setTitle("Start LoadingView", for: .normal)
            self.stopLoadingView()
        }
    }
}
