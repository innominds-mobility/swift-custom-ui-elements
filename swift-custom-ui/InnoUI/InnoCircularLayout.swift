//
//  InnoCircularLayout.swift
//  swift-custom-ui
//
//  Created by Deepthi Muramshetty on 23/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

@IBDesignable public class InnoCircularLayout: UICollectionViewLayout {
    private var centerForCircle: CGPoint!
    private var numberOfItems: Int!
    private var itemSize: CGSize!
    private var radiusOfCircle: CGFloat!
    
    override public func prepare() {
        super.prepare()
        
        guard let innoCollectionView = collectionView else { return }
        centerForCircle = CGPoint(x: innoCollectionView.bounds.midX, y: innoCollectionView.bounds.midY)
        let shortestAxisLength = min(innoCollectionView.bounds.width, innoCollectionView.bounds.height)
        itemSize = CGSize(width: shortestAxisLength * 0.1, height: shortestAxisLength * 0.1)
        radiusOfCircle = shortestAxisLength * 0.4
        numberOfItems = innoCollectionView.numberOfItems(inSection: 0)
    }
    
    override public var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
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
