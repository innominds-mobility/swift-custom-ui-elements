//
//  UIViewController+InnoLoadingIndicator.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 09/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import Foundation

// MARK: - UIViewController extension for animating loading indicator.
extension UIViewController {
    /// Loading indicator tag.
    var innoLoadingIndicatorTag: Int { return 999990 }
    /// Loading view tag.
    var innoViewTag: Int { return 999991}
    /// Start of loading indicator.
    ///
    /// - Parameters:
    ///   - style: UIActivityIndicatorViewStyle.
    ///   - location: location for indicator.
    public func startLoadingIndicator(
        style: UIActivityIndicatorViewStyle = .gray,
        location: CGPoint? = nil) {
        //Set the position - defaults to `center` if no`location`
        //argument is provided
        
        /// Loaction
        let loc = location ?? self.view.center
        //Ensure the UI is updated from the main thread
        //in case this method is called from a closure
        DispatchQueue.main.async(execute: {
            //Create the activity indicator
            /// Loading indicator
            let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            //Add the tag so we can find the view in order to remove it later
            loadingIndicator.tag = self.innoLoadingIndicatorTag
            //Set the location
            loadingIndicator.center = loc
            loadingIndicator.hidesWhenStopped = true
            //Start animating and add the view
            loadingIndicator.startAnimating()
            self.view.addSubview(loadingIndicator)
        })
    }
    
   /// Stop loading indicator.
   public func stopLoadingIndicator() {
        
        //Again, we need to ensure the UI is updated from the main thread!
        DispatchQueue.main.async(execute: {
            //Here we find the `UIActivityIndicatorView` and remove it from the view
            /// Loading indicator for stoping.
            if let loadingIndicator = self.view.subviews.filter ({ $0.tag == self.innoLoadingIndicatorTag}).first
                as? UIActivityIndicatorView {
                loadingIndicator.stopAnimating()
                loadingIndicator.removeFromSuperview()
            }
        })
    }
    
    /// Start of loading indicator view.
    ///
    /// - Parameter loadTitle: Title for loading
    public func startLoadingView(loadTitle: String? = nil) {
        //Set the position - defaults to `center` if no`location`
        //argument is provided
       /// ActivityIndicatorViewStyle.
       let style: UIActivityIndicatorViewStyle = .white
        /// Location point.
        let loc = self.view.center
        /// Title name
        let titleName = (loadTitle ?? "").isEmpty ? "Loading..." : loadTitle!
        
        //Ensure the UI is updated from the main thread
        //in case this method is called from a closure
        DispatchQueue.main.async(execute: {
        
            //Create the activity indicator
            /// Activity indicator
            let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            loadingIndicator.tag = self.innoLoadingIndicatorTag
            //Set the location
            loadingIndicator.center = loc
            loadingIndicator.hidesWhenStopped = true
            //Start animating and add the view
            loadingIndicator.startAnimating()
            /// Loading view
            let loadView = UIView()
            loadView.tag = self.innoViewTag
            loadView.frame = CGRect(x:50,
                                    y:self.view.center.y-40, width:self.view.frame.size.width-100, height:100)
            loadView.layer.masksToBounds = true
            loadView.layer.cornerRadius = 6
            loadView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(loadView)
            self.view.addSubview(loadingIndicator)
            self.view.bringSubview(toFront: loadingIndicator)
            /// Title label.
            let titelLabel = UILabel()
            titelLabel.frame = CGRect(x:3, y:loadView.frame.size.height-40,
                                      width:loadView.frame.size.width-6, height:40)
            titelLabel.numberOfLines = 0
            titelLabel.text = titleName
            titelLabel.textAlignment = .center
            titelLabel.textColor = UIColor.white
            loadView.addSubview(titelLabel)
        })
    }
    /// Stop loading view.
    public func stopLoadingView() {
        //Again, we need to ensure the UI is updated from the main thread!
        DispatchQueue.main.async(execute: {
            //Here we find the `UIActivityIndicatorView` and remove it from the view
            if let loadingIndicator = self.view.subviews.filter ({ $0.tag == self.innoLoadingIndicatorTag}).first
                as? UIActivityIndicatorView {
                loadingIndicator.stopAnimating()
                loadingIndicator.removeFromSuperview()
            }
            if let loadView = self.view.subviews.filter({$0.tag == self.innoViewTag}).first {
                loadView.removeFromSuperview()
            }
        })
    }
}
