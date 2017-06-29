//
//  CustomCollecitonViewController.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 22/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this view controller is to provide a user interface
/// for showing custom collection view.
class CustomCollecitonViewController: UIViewController, UICollectionViewDataSource {

    /// Collection view IBOutlet.
    @IBOutlet weak var custCollectionView: UICollectionView!
    /// collection view Cell identifier.
    let cellId = "CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        custCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        custCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    /// Cell for collection view.
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                  for: indexPath as IndexPath) as UICollectionViewCell
    cell.backgroundColor = UIColor.red
    return cell
    }
}
