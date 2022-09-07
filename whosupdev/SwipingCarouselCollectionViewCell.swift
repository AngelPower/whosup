//
//  SwipingCarouselCollectionViewCell.swift
//  Swiping Cards
//
//  Created by Sophie Romanet.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import RealmSwift

//Protocol to inform that cell is being swiped up or down.
public protocol SwipingCarouselDelegate : class {
    func cellSwipedUp(_ cell: UICollectionViewCell)
    func cellSwipedDown(_ cell: UICollectionViewCell)
}

open class SwipingCarouselCollectionViewCell: UICollectionViewCell {
    
    public weak var delegate: SwipingCarouselDelegate?
    public var deleteOnSwipeUp = true
    public var deleteOnSwipeDown = false
    public var canvas : UIView = UIView()
    public var views : UIView = UIView()
    public var firstviews : UIView = UIView()
    
    let LblTitle = UILabel()
    let LblTxt1 = UILabel()
    let LblTxt2 = UILabel()
    let Btnon = UIButton()
    let imgprofil = UIImageView()
    let imgMoood = UIImageView()
    let Lbname = UILabel()
    let ImgBtn = UIButton(type: UIButtonType.custom) as UIButton
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
   public required init(coder: NSCoder) {
        super.init(coder: coder)!
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delaysTouchesBegan = true
        panGesture.delaysTouchesEnded = true
        panGesture.maximumNumberOfTouches = 2
       
        // Add Gesture to Cell
        self.contentView.addGestureRecognizer(panGesture)
    }
 
  
    // MARK: Gestures Handling
    fileprivate struct Constants {
        static let SwipeDistanceToTakeAction: CGFloat  = UIScreen.main.bounds.size.height / 5
        //Distance required for the cell to go off the screen.
        static let SwipeImageAnimationDuration: TimeInterval = 1 //Duration of the Animation when Swiping Up/Down.
        static let CenterImageAnimationDuration: TimeInterval = 0 //Duration of the Animation when image gets back to original postion.
    }
    
    fileprivate var swipeDistanceOnY = CGFloat() //Distance of the swipe over "y" axis.
    fileprivate var originalPoint = CGPoint()
    
    @objc fileprivate func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        
      // self.contentView.addSubview(self)
        swipeDistanceOnY = sender.translation(in: self).y //Get the distance of the Swipe on "y" axis.
        
        switch sender.state {
        case .began:
         
             originalPoint = self.center //Get the center of the Cell.
        case .changed:
            self.center = CGPoint(x: originalPoint.x, y: originalPoint.y + swipeDistanceOnY)
        case .ended:
            //Take action after the Swipe gesture ends.
            afterSwipeAction()
        default:
            break
        }
    }
    
    fileprivate func afterSwipeAction() {
        //self.contentView.frame = CGRect(x: 0, y: 6.55, width: 270, height: 342)
      
        //First, we check if the swiped cell is the one in the middle of screen by cheking its size. If the cell is one of the sides, we send it back to its original position.
        if (self.frame.size.height > self.bounds.size.height) {
            
            //If the cell is the one at the center (biggest one), we proceed to check wheather or not the distance of the gesture is enough to move the cell off the screen (up or down).
            if swipeDistanceOnY > Constants.SwipeDistanceToTakeAction {
                downAction()
            } else if swipeDistanceOnY < -Constants.SwipeDistanceToTakeAction {
                
                upAction()
            } else {
                UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
                    self.center = self.originalPoint
                })
                
            }
        } else {

            UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
                self.center = self.originalPoint
            })
         
       
        }
    }
    
    
    
   fileprivate func upAction() {
    
    
    /* The maxUpperPoint will depend on deleteOnSwipeUp variable.
     Under default behavior, 'false', the cell will go back to the original position.
     If it's set to 'true' the cell will go down off the screen to be able to delete it throught its delegate. */
    let maxUpperPoint: CGPoint = deleteOnSwipeUp ? CGPoint(x: originalPoint.x, y: 2 * frame.minY - 10000) : self.originalPoint
    UIView.animate(withDuration: Constants.SwipeImageAnimationDuration, animations: { () -> Void in
        self.center = maxUpperPoint //Move the cell to the maxUpperPoint.
        self.superview?.isUserInteractionEnabled = false //Deactivate the user interaction in the Superview (In this case will be in the collection view). To avoid scrolling during the animation.
    }, completion: { (completion) -> Void in
        self.superview?.isUserInteractionEnabled = true // Re-activate the user interaction.
       // print(self.superview)
        self.delegate?.cellSwipedUp(self)
    })
    
    self.actionView()
   
    
    }
    
    func actionView() {
        
        // TODO: set the content matching on the viewController 
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : MatchingJoinInstantViewController = storyboard.instantiateViewController(withIdentifier: "MatchingJoinInstantViewController") as! MatchingJoinInstantViewController
        UserManager.sharedInstance.mainNavigationController.present(viewController, animated: true)
        
        /*LblTitle.text = "Dire oui à tous le monde pour faire un instant soirée!"
        LblTitle.frame = CGRect(x: 23, y: 432, width: 348, height:100)
        LblTitle.textColor = .white
        LblTxt1.numberOfLines = 2;
        LblTitle.font = LblTitle.font.withSize(25)
        LblTitle.shadowOffset = CGSize(width: 5, height: 5)
        LblTitle.textAlignment = NSTextAlignment.center
        
        LblTxt1.text = "Tu es super chaud? Peut importe qui te rejoins tu es sûr(e) de trouver des amis motivés!  "
        LblTxt1.frame = CGRect(x: 14, y: 504, width: 348, height:65)
        LblTxt1.textColor = .white
        LblTxt1.numberOfLines = 3;
        LblTxt1.font = LblTitle.font.withSize(18)
        LblTxt1.textAlignment = NSTextAlignment.center
        LblTxt1.textColor = UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0)
         let image = UIImage(named: "yeah") as UIImage?
        ImgBtn.frame = CGRect(x: 65, y: 564, width: 246, height: 47)
        ImgBtn.setImage(image, for: .normal)
        ImgBtn.addTarget(self, action: #selector(ActiveMood(button:)), for: .touchUpInside)
        
        Btnon.frame = CGRect(x: 65, y: 621, width: 246, height: 47)
        Btnon.setTitle("Finalement non",for: .normal)
        Btnon.setTitleColor(UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0), for: .normal)
        Btnon.titleLabel?.font =  Btnon.titleLabel?.font.withSize(18)
        Btnon.titleLabel?.textAlignment = .center
        
        // Btnon.addTarget(otherVC, action: Selector("pressButton"), for: .touchUpInside)
        
         Btnon.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        // Add constraints
        
         // Add the button to the stack        //Btnon.addTarget(self, action: Selector(("btnTouched:")), for:.touchUpInside)
        
        let imgView = UIImage(named: "jj") as UIImage?
        imgprofil.image = imgView
        imgprofil.frame = CGRect(x: 116, y: 93, width: 143, height:140)
        imgprofil.setBorder(5, color: .white)
        imgprofil.layer.cornerRadius = 70
        imgprofil.clipsToBounds = true
        
        
        let nameMood = UserManager.sharedInstance.getMoodsSelects()
        let imgView1 = UIImage(named: nameMood) as UIImage?
        imgMoood.image = imgView1
        imgMoood.frame = CGRect(x: 62, y: 192, width: 260, height:249)
        imgMoood.layer.zPosition = 5
     
        
        Btnon.layer.zPosition = 10
        blurView.addSubview(Btnon)
        
        blurView.addSubview(LblTitle)
        blurView.addSubview(LblTxt1)
        // blurView.addSubview(LblTxt2)
        blurView.addSubview(ImgBtn)
        
        blurView.addSubview(imgprofil)
        blurView.addSubview(imgMoood)
        // blurView.addSubview(Lbname)
        
        
        blurView.frame = self.views.bounds
        // blurView.isUserInteractionEnabled = true
        
        self.bringSubview(toFront: Btnon)
        self.views.insertSubview(blurView, at: 5)*/
    
           }

    
      
   fileprivate func downAction() {
        /* The maxDownPoint will depend on deleteOnSwipeDown variable.
           Under default behavior, 'false', the cell will go back to the original position.
           If it's set to 'true' the cell will go down off the screen to be able to delete it throught its delegate. */
        let maxDownPoint: CGPoint = deleteOnSwipeDown ? CGPoint(x: originalPoint.x, y: 2 * frame.maxY) : self.originalPoint
        UIView.animate(withDuration: Constants.SwipeImageAnimationDuration, animations: { () -> Void in
            self.center = maxDownPoint //Move the cell to the maxDownPoint.
            self.superview?.isUserInteractionEnabled = false //Deactivate the user interaction in the Superview (In this case will be in the collection view). To avoid scrolling during the animation.
            }, completion: { (completion) -> Void in
                self.superview?.isUserInteractionEnabled = true // Re-activate the user interaction.
              
        })
    
    
    }
    
    //Mark: Swipping profil
    
    func pressButton(button: UIButton) {
        
        print("ok")
        UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
            self.center = self.originalPoint
        })
        
        
        LblTitle.removeFromSuperview()
        LblTxt1.removeFromSuperview()
        LblTxt2.removeFromSuperview()
        ImgBtn.removeFromSuperview()
        
        imgprofil.removeFromSuperview()
        imgMoood.removeFromSuperview()
        Lbname.removeFromSuperview()
        Btnon.removeFromSuperview()
        blurView.removeFromSuperview()
        let myview = self.views as? UICollectionView
        myview?.reloadData()
        
        
    }
    
    func ActiveMood (button: UIButton) {
        
        print("pressed!")
        //self.firstviews.isUserInteractionEnabled = true
        //self.views.frame = CGRect(x: 0, y: 0, width: 375, height: 240)
        //self.views.layer.zPosition = 1
        // let colours2 : [String] = ["jj"]
        UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
            self.center = self.originalPoint
        })
        
        LblTitle.removeFromSuperview()
        LblTxt1.removeFromSuperview()
        LblTxt2.removeFromSuperview()
        ImgBtn.removeFromSuperview()
        Btnon.removeFromSuperview()
        imgprofil.removeFromSuperview()
        imgMoood.removeFromSuperview()
        Lbname.removeFromSuperview()
        
        blurView.removeFromSuperview()
        

        
        if (UserManager.sharedInstance.getMoodsSelects() == "soiree".localized) {
            if (UserManager.sharedInstance.getMoodSoireePublicSelects() == "noactive") {
                UserManager.sharedInstance.setMoodSoireePublicSelects(_moodsoireeselects: "activate")
                SocketIOManager.sharedInstance.PublicMatch(completionHandler: { (mood) -> Void in
                    DispatchQueue.main.async { () -> Void in

                        
                    }})
            }
      
        
        }
        if (UserManager.sharedInstance.getMoodsSelects() == "game".localized) {
            if (UserManager.sharedInstance.getMoodGameSelects() == "noactive") {
                UserManager.sharedInstance.setMoodGamePublicSelects(_moodgameseselects: "activate")
                SocketIOManager.sharedInstance.PublicMatch(completionHandler: { (mood) -> Void in
                    DispatchQueue.main.async { () -> Void in
                        
                        
                    }})
            
            }
     
        }
        if (UserManager.sharedInstance.getMoodsSelects() == "food".localized) {
            if (UserManager.sharedInstance.getMoodFoodPublicSelects() == "noactive") {
                UserManager.sharedInstance.setMoodFoodPublicSelects(_moodfoodseselects: "activate")
                SocketIOManager.sharedInstance.PublicMatch(completionHandler: { (mood) -> Void in
                    DispatchQueue.main.async { () -> Void in
                        
                        
                    }})
            }
      
            
        }
        if (UserManager.sharedInstance.getMoodsSelects() == "sport".localized) {
            if (UserManager.sharedInstance.getMoodSportPublicSelects() == "noactive") {
                UserManager.sharedInstance.setMoodSportPublicSelects(_moodsportseselects: "activate")
                SocketIOManager.sharedInstance.PublicMatch(completionHandler: { (mood) -> Void in
                    DispatchQueue.main.async { () -> Void in
                        
                        
                    }})
            }
          
            
        }
        if (UserManager.sharedInstance.getMoodsSelects() == "autres".localized) {
            if (UserManager.sharedInstance.getMoodAutrePublicSelects() == "noactive") {
                UserManager.sharedInstance.setMoodAutrePublicSelects(_moodautreseselects: "activate")
                SocketIOManager.sharedInstance.PublicMatch(completionHandler: { (mood) -> Void in
                    DispatchQueue.main.async { () -> Void in
                        
                        
                    }})
            }
       
        }
        if (UserManager.sharedInstance.getMoodsSelects() == "chill".localized) {
            if (UserManager.sharedInstance.getMoodChillPublicSelects() == "noactive") {
                UserManager.sharedInstance.setMoodChillPublicSelects(_moodchillseselects: "activate")
                SocketIOManager.sharedInstance.PublicMatch(completionHandler: { (mood) -> Void in
                    DispatchQueue.main.async { () -> Void in
                        
                        
                    }})
            }
        
            
        }
        

        let myview = self.views as? UICollectionView
        myview?.reloadData()
       
    }
    
    
    
    
    
    
    public func initView (canvas : UIView, collectionViews : UICollectionView, firstcollection: UICollectionView) {
    
        self.canvas = canvas
        self.views = collectionViews
        self.firstviews = firstcollection
        
    }
    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
       print("gesturecodnguiosq")
    
        return false
        
    }
    

    
}




