//
//  HomeViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 23/05/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

/// The purpose of this view controller is to provide a user interface for Custom UI elements.
/// There's a matching scene in the *Main.storyboard* file, and in that scene there are Custom UI elements.
/// Go to Interface Builder for details.
/// The `HomeViewController` class is a subclass of the `UIViewController`.
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - IBOutlet Properties
    /// The tableview for the custom elements list.
    @IBOutlet weak var elementsListTableView: UITableView!
    /// Data model: These strings will be the data for the table view cells
    let elementsList: [String] = ["Rounded and corner type button", "Progress view circle & bar",
            "Range selection slider", "Toast message UI", "Custom collection views",
            "UIImage with circular and squared",
            "Radiant background", "Custom Textfield", "Transparent Button", "Loading Indicator",
            "Custom Loading Indicator"]
    /// cell reuse id (cells that scroll out of view can be reused)
    let cellReUseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift Custom UI Elements"
        elementsListTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReUseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Tableview data source methods
   /// Asks the data source to return the number of sections in the table view.
    ///
   /// - Parameters:
    ///   - tableView: An object representing the table view requesting this information.
   ///   - section: section in tableview
   /// - Returns: The number of sections in tableView. The default value is 1.
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsList.count
    }

    /// Asks the data source for a cell to insert in a particular location of the table view.
    ///
    /// - Parameters:
    ///   - tableView: A table-view object requesting the cell.
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: An object inheriting from UITableViewCell that 
    /// the table view can use for the specified row. An assertion is raised if you return nil.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// create a new cell if needed or reuse an old one
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellReUseIdentifier) as UITableViewCell!
        cell.textLabel?.text = elementsList[indexPath.row]
        return cell
    }
    //
    /// Tells the delegate that the specified row is now selected.
    ///
    /// - Parameters:
    ///   - tableView: A table-view object informing the delegate about the new row selection.
    ///   - indexPath: An index path locating the new selected row in tableView.
    // swiftlint:disable:next cyclomatic_complexity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0: if let buttonVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "ProgressViewController") as? ProgressViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(buttonVC, animated: true) }
            }
        case 1: if let progressVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "ProgressViewController") as? ProgressViewController {
                if let navigator = navigationController { navigator.pushViewController(progressVC, animated: true) }
            }
        case 2: if let rangeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "RangeSelectionViewController") as? RangeSelectionViewController {
                if let navigator = navigationController { navigator.pushViewController(rangeVC, animated: true) }
            }
        case 3: if let toastVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "ProgressViewController") as? ProgressViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(toastVC, animated: true) }
            }
        case 4: break
        case 5: if let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "ImageShapesViewController") as? ImageShapesViewController {
                if let navigator = navigationController { navigator.pushViewController(imageVC, animated: true) }
            }
        case 6: if let radiantVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "RadiantBackgroundViewController") as? RadiantBackgroundViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(radiantVC, animated: true) }
            }
        case 7:
            if let customTxtFldVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "CustomTextfieldViewController") as? CustomTextfieldViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(customTxtFldVC, animated: true) }
            }
        case 8: if let customButnVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
                "ButtonsViewController") as? ButtonsViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(customButnVC, animated: true) }
            }
        case 9: if let loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "LoadingIndicatorViewController") as? LoadingIndicatorViewController {
            if let navigator = navigationController { navigator.pushViewController(loadingVC, animated: true) }
            }
        case 10:self.customeLoadViewController()
        default:
            break
        }
    }
    func customeLoadViewController() {
        if let custLoadVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "CustomLoadingIndicatorVC") as? CustomLoadingIndicatorVC {
            if let navigator = navigationController { navigator.pushViewController(custLoadVC, animated: true) }
        }
    }

}
