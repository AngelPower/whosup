//
//  SwipingCarouselFlowLayout.swift
//  Swiping Cards
//
//  Created by Pablo Paciello on 8/20/15.
//  Copyright (c) 2015 Pablo Paciello. All rights reserved.
//

import UIKit
import RealmSwift

public class SwipingCarouselFlowLayout:  UICollectionViewFlowLayout {
    
    // Mark: Constants 
    fileprivate struct Constants {
        static let zoomFactor: CGFloat = 0.3
        static let itemWidth: CGFloat = 262       //Width of the Cell.
        static let itemHeight: CGFloat = 699      //Height of the Cell.
        static let minLineSpacing: CGFloat = 5.0
    }
    
    public var activeDistance: CGFloat = 100
    
    
    override public func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
        scrollDirection = .horizontal

        minimumLineSpacing = Constants.minLineSpacing
        //These numbers will depend on the size of your cards you have set in the CardsViewFlowConstants.
        //60 - will let the first and last card of the CollectionView to be centered.
        //100 - will avoid the double rows in the CollectionView
        sectionInset = UIEdgeInsetsMake(100.0, 60.0, 100, 60.0)
    }

 
    // Here is where the magic happens
    // Add zooming to the Layout Attributes.
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        var visibleRect = CGRect()
        visibleRect.origin = collectionView!.contentOffset
        visibleRect.size = collectionView!.bounds.size
        var candidateAttributes : UICollectionViewLayoutAttributes?
        
        
        
        
        for itemAttributes in array! {
            //let newAttributes: UICollectionViewLayoutAttributes = itemAttributes
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            if itemAttributesCopy.frame.intersects(rect) {
                let distance = visibleRect.midX - itemAttributes.center.x
                let normalizedDistance = distance / activeDistance
                if (abs(distance)) < activeDistance {
                    let zoom = 1 + Constants.zoomFactor*(1 - abs(normalizedDistance))
                    itemAttributesCopy.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
                    itemAttributesCopy.zIndex = 9
                    //itemAttributesCopy.frame = CGRect(x: 0, y: 200, width: 350, height: 250)
                    candidateAttributes = itemAttributes
                    
                    if let roomCount = candidateAttributes?.indexPath.row {
                  
                        let realm = try! Realm()
                        
                        let profilliste = realm.objects(ProfilsListe.self)
                        UserManager.sharedInstance.setIndexActive(_indexActive: String(describing: roomCount))
                        UserManager.sharedInstance.setMoodsSelects(_moodsselects: profilliste[Int(UserManager.sharedInstance.getIndexActive())!].name)
                        
                        
                        
                    }
                }
            }
            attributesCopy.append(itemAttributesCopy)
            
            
            
            
        }
        return attributesCopy
    }
    
    //Focus the zoom in the middle Card.
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var offsetAdjustment:CGFloat = CGFloat(MAXFLOAT)
        let horizontalCenter = proposedContentOffset.x + (collectionView!.bounds.width / 2.0) + 15
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0.0, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height)
        
        if let array = super.layoutAttributesForElements(in: targetRect) {
            for layoutAttributes in array {
                let itemHorizontalCenter: CGFloat = layoutAttributes.center.x
                if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment)) {
                    offsetAdjustment = itemHorizontalCenter - horizontalCenter
                }
            }
        }
        
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    // Invalidate the Layout when the user is scrolling
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
