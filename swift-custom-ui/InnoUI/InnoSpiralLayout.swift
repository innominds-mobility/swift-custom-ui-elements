//
//  InnoSpiralLayout.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 03/07/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this class is to provide Spiral layout for collection view.
/// The `InnoSpiralLayout` class is a subclass of the `UICollectionViewLayout`.
@IBDesignable public class InnoSpiralLayout: UICollectionViewLayout {
    /// Center point for layout.
    private var centerForSpiral: CGPoint!
    /// Number of items.
    private var numberOfItems: Int!
    /// Item size.
    private var itemSize: CGSize!
    /// Radius of Spiral.
    private var radiusOfSpiral: CGFloat!
    /// Start angle for spiral.
    private var startAngle: CGFloat = 3 * .pi/2
    /// End angle for spiral.
    private var endAngle: CGFloat = 0
    override public func prepare() {
        super.prepare()
   
        guard let innoSpCollectionView = collectionView else { return }
        centerForSpiral = CGPoint(x: innoSpCollectionView.bounds.width/2, y: innoSpCollectionView.bounds.width/2)

        let shortestAxisLength = min(innoSpCollectionView.bounds.width, innoSpCollectionView.bounds.height)
        itemSize = CGSize(width: shortestAxisLength * 0.1, height: shortestAxisLength * 0.1)
        radiusOfSpiral = innoSpCollectionView.bounds.width/90
        numberOfItems = innoSpCollectionView.numberOfItems(inSection: 0)
    }
    
    override public var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        /// Layout Attributes.
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        /// Angle to determine item position.

        if indexPath.row == 0 {// For initialising values.
            startAngle = 3 * .pi/2
            endAngle = 0
            radiusOfSpiral = (collectionView?.bounds.width)!/90
        }
            startAngle = endAngle
            switch startAngle {
            case 0, 2 * .pi:
                attributes.center = CGPoint(x: centerForSpiral.x - radiusOfSpiral/2, y: centerForSpiral.y)
                endAngle = .pi/2
            case 1 * .pi :
                attributes.center = CGPoint(x: centerForSpiral.x + radiusOfSpiral/2, y: centerForSpiral.y)
                endAngle = 3 * .pi/2
            case .pi/2:
                attributes.center = CGPoint(x: centerForSpiral.x, y: centerForSpiral.y - radiusOfSpiral/2)
                endAngle = .pi
            case 3 * .pi/2:
                attributes.center = CGPoint(x: centerForSpiral.x, y: centerForSpiral.y + radiusOfSpiral/2)
                endAngle = 2 * .pi
            default:
                attributes.center = CGPoint(x:(collectionView?.bounds.width)!/3, y: (collectionView?.bounds.height)!/3)
            }
        
        if indexPath.row == 0 {
            radiusOfSpiral =  2 * itemSize.width + radiusOfSpiral
        } else { radiusOfSpiral = itemSize.width + radiusOfSpiral }//1.5 * radiusOfSpiral
         attributes.size = itemSize
        return attributes
    }
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (0 ..< collectionView!.numberOfItems(inSection: 0)).flatMap {item -> UICollectionViewLayoutAttributes? in
            self.layoutAttributesForItem(at: IndexPath(item: item, section: 0))
        }
    }
    
}
