//
//  CustomCollecitonViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
import InnoUI

/// The purpose of this view controller is to provide a user interface
/// for showing custom collection view.
class CustomCollecitonViewController: UIViewController, UICollectionViewDataSource {

    /// Collection view IBOutlet.
    @IBOutlet weak var custCollectionView: UICollectionView!
    /// collection view Cell identifier.
    let cellId = "CellID"
    /// Count for cell label.
    var count: Int = 0
    /// Number of cells.
    let noOfCells: Int = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        custCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        custCollectionView.dataSource = self
        self.title = "Colleciton View Layouts"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// It triggers changing of collection view layout i.e circular or spiral.
    ///
    /// - Parameter sender: The segment control that invokes this IBAction.
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            custCollectionView.setCollectionViewLayout(layout, animated: false)
            custCollectionView.reloadData()
        } else if (sender as AnyObject).selectedSegmentIndex == 1 {
            custCollectionView.setCollectionViewLayout(InnoCircularLayout(), animated: false)
            custCollectionView.reloadData()
        } else {
            custCollectionView.setCollectionViewLayout(InnoSpiralLayout(), animated: false)
            custCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return noOfCells
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    /// Cell for collection view.
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                  for: indexPath as IndexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.red
        if let textLbl = cell.viewWithTag(10) as? UILabel {
            textLbl.removeFromSuperview()
        }
        /// Cell text label.
        let textLbl: UILabel = UILabel()
        textLbl.textAlignment = .center
        textLbl.frame = CGRect(x: 0, y: 5, width: 40, height: 20)
        if count < noOfCells {
            count += 1
        } else {
            count = 1
        }
        textLbl.text = "\(count)"
        textLbl.tag = 10
        cell.addSubview(textLbl)

    return cell
    }
}
