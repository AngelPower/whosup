//
//  CenterCellCollectionViewFlowLayout.swift
//  whosupdev
//
//  Created by Sophie Romanet on 27/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {

    
    var mostRecentOffset : CGPoint = CGPoint()
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if velocity.x == 0 {
            return mostRecentOffset
        }
        
        if let cv = self.collectionView {
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
                        continue
                    }
                    candidateAttributes = attributes
                    
                    /*if(candidateAttributes?.indexPath.row != nil){
                        print(candidateAttributes?.indexPath.row as Any)}*/
                    
                    if let roomCount = candidateAttributes?.indexPath.row {
                        
                        UserManager.sharedInstance.setIndexActive(_indexActive: String(describing: roomCount))
                        
                    }
                }
                
                // Beautification step , I don't know why it works!
                if(proposedContentOffset.x == -(cv.contentInset.left)) {
                    return proposedContentOffset
                }
                
                guard let _ = candidateAttributes else {
                    return mostRecentOffset
                }
                mostRecentOffset = CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
                return mostRecentOffset
                
            }
        }
        
        // fallback
        mostRecentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        return mostRecentOffset
    }
    
}
