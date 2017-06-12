//
//  LoadingIndicatorViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

class LoadingIndicatorViewController: UIViewController {

    @IBOutlet weak var startButtn: UIButton!
    var isStart: Bool = true
    var isStartView: Bool = true
    @IBOutlet weak var loadViewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButtn.setTitle("Start Loading", for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
    @IBAction func startStopLoadingViewAction(_ sender: Any) {
        self.stopLoadingView()
        self.stopLoadingIndicator()
        if isStartView {
            isStartView = false
            loadViewButton.setTitle("Stop LoadingView", for: .normal)
             self.startLoadingView(loadTitle: "Hello loading...")
        } else {
            isStartView = true
            loadViewButton.setTitle("Start LoadingView", for: .normal)
            self.stopLoadingView()
        }
    }
}
