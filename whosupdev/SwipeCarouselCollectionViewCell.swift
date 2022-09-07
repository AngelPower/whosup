//
//  SwipingCarouselCollectionViewCell.swift
//  Swiping Cards
//
//  Created by Pablo Paciello on 10/26/16.
//  Copyright © 2016 Pablo Paciello. All rights reserved.
//

import UIKit

//Protocol to inform that cell is being swiped up or down.
public protocol SwipeCarouselDelegate : class {
    func cellSwipedUp(_ cell: UICollectionViewCell)
    func cellSwipedDown(_ cell: UICollectionViewCell)
    func onSwiping(_ cell: UICollectionViewCell, Yposition: CGFloat)
    func beginSwipe(_ cell: UICollectionViewCell)

}

open class SwipeCarouselCollectionViewCell: UICollectionViewCell {
    
    public weak var delegate: SwipeCarouselDelegate?
    public var deleteOnSwipeUp = false
    public var deleteOnSwipeDown = false
    fileprivate var cellManager: SwipeCarouselCellManager!
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        //Init the Cell Manager
        cellManager = SwipeCarouselCellManager(withCell: self)
        // Add Gesture to Cell
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))        
    }
    
    @objc fileprivate func handlePanGesture(_ sender: UIPanGestureRecognizer) {        
        cellManager.handlePanGesture(sender)
    }    
}
