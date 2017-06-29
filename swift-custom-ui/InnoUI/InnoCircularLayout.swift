//
//  InnoCircularLayout.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 23/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit
/// The purpose of this class is to provide Circular layout for collection view.
/// The `InnoCircularLayout` class is a subclass of the `UICollectionViewLayout`.
@IBDesignable public class InnoCircularLayout: UICollectionViewLayout {
    /// Center point for layout.
    private var centerForCircle: CGPoint!
    /// Number of items.
    private var numberOfItems: Int!
    /// Item size.
    private var itemSize: CGSize!
    /// Radius of circle.
    private var radiusOfCircle: CGFloat!
    
    override public func prepare() {
        super.prepare()
        
        /// Collection view.
        guard let innoCollectionView = collectionView else { return }
        centerForCircle = CGPoint(x: innoCollectionView.bounds.midX, y: innoCollectionView.bounds.midY)
        /// Shortest axis.
        let shortestAxisLength = min(innoCollectionView.bounds.width, innoCollectionView.bounds.height)
        itemSize = CGSize(width: shortestAxisLength * 0.1, height: shortestAxisLength * 0.1)
        radiusOfCircle = shortestAxisLength * 0.4
        numberOfItems = innoCollectionView.numberOfItems(inSection: 0)
    }
    
    /// Determines collectionview item size.
    override public var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        /// Layout Attributes.
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        /// Angle to determine item position.
        let angle = 2 * .pi * CGFloat(indexPath.item) / CGFloat(numberOfItems)
        
        attributes.center = CGPoint(x: centerForCircle.x + radiusOfCircle * cos(angle),
                                    y: centerForCircle.y + radiusOfCircle * sin(angle))
        attributes.size = itemSize
        
        return attributes
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (0 ..< collectionView!.numberOfItems(inSection: 0)).flatMap {item -> UICollectionViewLayoutAttributes? in
            self.layoutAttributesForItem(at: IndexPath(item: item, section: 0))
        }
    }
}
