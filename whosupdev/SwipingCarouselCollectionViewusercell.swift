//
//  SwipingCarouselCollectionViewCell.swift
//  Swiping Cards
//
//  Created by Pablo Paciello on 10/26/16.
//  Copyright © 2016 Pablo Paciello. All rights reserved.
//

import UIKit
import RealmSwift

open class SwipingCarouselCollectionViewusercell: UICollectionViewCell {
    
    public weak var delegate: SwipingCarouselDelegate?
    public var deleteOnSwipeUp = false
    public var deleteOnSwipeDown = true

    public var canvas : UIView = UIView()
    public var views : UIView = UIView()
    public var firstviews : UIView = UIView()
    public var ViewSeconde : UIView = UIView()
    public var SecondCollection: UIView = UIView()
    
    let LblTitle = UILabel()
    let LblTxt1 = UILabel()
    let LblTxt2 = UILabel()
    let Btnon = UIButton()
    let imgprofil = UIImageView()
    let imgMoood = UIImageView()
    
    let Lbname = UILabel()
    let ImgBtn = UIButton(type: UIButtonType.custom) as UIButton
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var seconds = 180
    var secondssoiree = 180
    var timersoiree = Timer()
    var timersport = Timer()
    var timergame = Timer()
    var timerfood = Timer()
    var timerchill = Timer()
    var timerautre = Timer()
    
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        // Add Gesture to Cell
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
    }
 
    // MARK: Gestures Handling
    fileprivate struct Constants {
        static let SwipeDistanceToTakeAction: CGFloat  = UIScreen.main.bounds.size.height / 5 //Distance required for the cell to go off the screen.
        static let SwipeImageAnimationDuration: TimeInterval = 0.30 //Duration of the Animation when Swiping Up/Down.
        static let CenterImageAnimationDuration: TimeInterval = 0.20 //Duration of the Animation when image gets back to original postion.
    }
    
    fileprivate var swipeDistanceOnY = CGFloat() //Distance of the swipe over "y" axis.
    fileprivate var originalPoint = CGPoint()
    
    @objc fileprivate func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        
        swipeDistanceOnY = sender.translation(in: self).y //Get the distance of the Swipe on "y" axis.
        
        switch sender.state {
        case .began:
          
            let screenSize: CGRect = UIScreen.main.bounds
            self.views.frame = CGRect(x: 0, y: 0, width: 375, height: screenSize.height)
            self.views.layer.zPosition = 3
            originalPoint = self.center //Get the center of the Cell.
        case .changed:
            //Move the cell to the Y point while gesturing.
            self.center = CGPoint(x: originalPoint.x, y: originalPoint.y + swipeDistanceOnY)
        case .ended:
            //Take action after the Swipe gesture ends.
            afterSwipeAction()
            
        default:
            break
        }
    }
    
    fileprivate func afterSwipeAction() {
        
        
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
            /*UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
                self.center = self.originalPoint
            })*/
            if swipeDistanceOnY > Constants.SwipeDistanceToTakeAction {
                
                downAction()
            } else if swipeDistanceOnY < -Constants.SwipeDistanceToTakeAction {
                
                upAction()
            } else {
                UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
                    self.center = self.originalPoint
                })
            }

        }
    }
    
   fileprivate func upAction() {
    
    
    
        /* The maxUpperPoint will depend on deleteOnSwipeUp variable.
           Under default behavior, 'false', the cell will go back to the original position.
           If it's set to 'true' the cell will go down off the screen to be able to delete it throught its delegate. */
        let maxUpperPoint: CGPoint = deleteOnSwipeUp ? CGPoint(x: originalPoint.x, y: 2 * frame.minY) : self.originalPoint
        UIView.animate(withDuration: Constants.SwipeImageAnimationDuration, animations: { () -> Void in
            self.center = maxUpperPoint //Move the cell to the maxUpperPoint.
            self.superview?.isUserInteractionEnabled = false //Deactivate the user interaction in the Superview (In this case will be in the collection view). To avoid scrolling during the animation.
            }, completion: { (completion) -> Void in
                self.superview?.isUserInteractionEnabled = true // Re-activate the user interaction.
                self.delegate?.cellSwipedUp(self) //Delegate the SwipeUp action and send the view with it.
        })
        self.views.frame.size = CGSize(width: 375, height: 240)
    
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
                self.delegate?.cellSwipedDown(self) //Delegate the SwipeDown action and send the view with it.
        })
    
        self.actionView()
    
    }
    
    
 
    
    func actionView() {
        
        print("fdsqfdsqfdsqfdsq")
      
        // TODO: set the content matching on the viewController
       /* let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : MatchingActivateMoodViewController = storyboard.instantiateViewController(withIdentifier: "MatchingActivateMoodViewController") as! MatchingActivateMoodViewController
        UserManager.sharedInstance.mainNavigationController.present(viewController, animated: true)*/
        
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchingActivateMoodViewController") as? MatchingActivateMoodViewController {
            UserManager.sharedInstance.mainNavigationController.present(viewController, animated: true)
        }
        
        
        self.views.frame.size = CGSize(width: 375, height: 240)
        
        self.views.layer.zPosition = 1
        // let colours2 : [String] = ["jj"]
        UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
            print("animation")
            self.center = self.originalPoint
        })
        
        /*print( "/****************** \(UserManager.sharedInstance.getMoodsSelects())*******************/")
        LblTitle.text = "Passer en mood soirée?"
        LblTitle.frame = CGRect(x: 23, y: 34, width: 348, height:31)
        LblTitle.textColor = .white
        LblTitle.font = LblTitle.font.withSize(25)
        LblTitle.shadowOffset = CGSize(width: 5, height: 5)
        LblTitle.textAlignment = NSTextAlignment.center
        
        LblTxt1.text = "Tes amis seront notifiés que tu es chaud pour une soirée"
        LblTxt1.frame = CGRect(x: 14, y: 75, width: 348, height:65)
        LblTxt1.textColor = .white
        LblTxt1.numberOfLines = 3;
        LblTxt1.font = LblTitle.font.withSize(18)
        LblTxt1.textAlignment = NSTextAlignment.center
        LblTxt1.textColor = UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0)
        
        LblTxt2.text = "Les personnes autour de toi pourront te liker pour faire une soirée avec toi."
        LblTxt2.frame = CGRect(x: 14, y: 120, width: 348, height:65)
        LblTxt2.textColor = .white
        LblTxt2.numberOfLines = 3;
        LblTxt2.font = LblTitle.font.withSize(18)
        LblTxt2.textAlignment = NSTextAlignment.center
        LblTxt2.textColor = UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0)
        
        let image = UIImage(named: "yeah") as UIImage?
        ImgBtn.frame = CGRect(x: 65, y: 190, width: 246, height: 47)
        ImgBtn.setImage(image, for: .normal)
        ImgBtn.addTarget(self, action: #selector(ActiveMood(button:)), for: .touchUpInside)
        
        Btnon.frame = CGRect(x: 65, y: 235, width: 246, height: 47)
        Btnon.setTitle("Finalement non",for: .normal)
        Btnon.setTitleColor(UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0), for: .normal)
        Btnon.titleLabel?.font =  Btnon.titleLabel?.font.withSize(18)
        Btnon.titleLabel?.textAlignment = .center
        
         Btnon.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        let imgView = UIImage(named: "jj") as UIImage?
        imgprofil.image = imgView
        imgprofil.frame = CGRect(x: 116, y: 280, width: 143, height:140)
        imgprofil.setBorder(5, color: .white)
        imgprofil.layer.cornerRadius = 70
        imgprofil.clipsToBounds = true
        imgprofil.layer.zPosition = 5
        
        let nameMood = UserManager.sharedInstance.getMoodsSelects()
        let imgView1 = UIImage(named: nameMood) as UIImage?
        imgMoood.image = imgView1
        imgMoood.frame = CGRect(x: 62, y: 345, width: 260, height:249)
        
        Lbname.text = nameMood
        Lbname.frame = CGRect(x: 77, y: 570, width: 220, height:31)
        Lbname.textColor = .white
        Lbname.font = LblTitle.font.withSize(32)
        Lbname.shadowOffset = CGSize(width: 5, height: 5)
        Lbname.textAlignment = NSTextAlignment.center
        
        if(UserManager.sharedInstance.getMoodsSelects() == "soiree".localized){
            SetImgsBulles( _img: MoodsManager.sharedInstance.getMoodsSoiree(), view: blurView)
        }
        if(UserManager.sharedInstance.getMoodsSelects() == "sport".localized){
            SetImgsBulles( _img: MoodsManager.sharedInstance.getMoodSport(), view: blurView)
            
        }
        if(UserManager.sharedInstance.getMoodsSelects() == "food".localized){
            SetImgsBulles( _img: MoodsManager.sharedInstance.getMoodsfood() , view: blurView)
            
        }
        if(UserManager.sharedInstance.getMoodsSelects() == "game".localized){
            SetImgsBulles( _img: MoodsManager.sharedInstance.getMoodsGame() , view: blurView)
            
        }
        if(UserManager.sharedInstance.getMoodsSelects() == "autres".localized){
            SetImgsBulles( _img: MoodsManager.sharedInstance.getMoodAutres() , view: blurView)
            
        }
        if(UserManager.sharedInstance.getMoodsSelects() == "chill".localized){
            SetImgsBulles( _img: MoodsManager.sharedInstance.getMoodChill() , view: blurView)
            
        }
        
        Btnon.layer.zPosition = 10
        blurView.addSubview(Btnon)
        
        blurView.addSubview(LblTitle)
        blurView.addSubview(LblTxt1)
        blurView.addSubview(LblTxt2)
        blurView.addSubview(ImgBtn)
        
        blurView.addSubview(imgprofil)
        blurView.addSubview(imgMoood)
        blurView.addSubview(Lbname)
        
        
        blurView.frame = self.views.bounds
        self.bringSubview(toFront: Btnon)
        self.views.insertSubview(blurView, at: 5)*/
        
        
     
    }
    
    
    func pressButton(button: UIButton) {
        
        print("ok")
        //let colours2 : [String] = ["jj"]
        //self.firstviews.isUserInteractionEnabled = true
        self.views.frame.size = CGSize(width: 375, height: 240)
        self.views.layer.zPosition = 1
        
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
        self.views.frame.size = CGSize(width: 375, height: 240)
      
        self.views.layer.zPosition = 1
        // let colours2 : [String] = ["jj"]
        UIView.animate(withDuration: Constants.CenterImageAnimationDuration, animations: {
            print("animation")
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
        
        
        let realm = try! Realm()
        
        
        try! realm.write {
            for mood in realm.objects(Moods.self).filter("mood == %@", UserManager.sharedInstance.getMoodsSelects()) {
                
                if(mood.statut == "activate") {
                    
                    mood.statut = "noactive"
                    SocketIOManager.sharedInstance.MoodOver(completionHandler: { (mood) -> Void in
                        DispatchQueue.main.async { () -> Void in
                            // var Mood = [String]()
                            //print(mood!)
                            
                            
                            
                        }})
                    
                    let realm = try! Realm()
                    //  let profilliste = realm.objects(ProfilsListe.self)
                    let idsoiree = realm.objects(Moods.self).filter("mood == %@", "SOIREE").first?.statut
                    let idsport = realm.objects(Moods.self).filter("mood == %@", "SPORT").first?.statut
                    let idfood = realm.objects(Moods.self).filter("mood == %@", "FOOD").first?.statut
                    let idgame = realm.objects(Moods.self).filter("mood == %@", "GAME").first?.statut
                    let idother = realm.objects(Moods.self).filter("mood == %@", "OTHER").first?.statut
                    let idchill = realm.objects(Moods.self).filter("mood == %@", "CHILL").first?.statut
                    
                    if(idsoiree  == "activate"){
              
                        
                        ViewSeconde.backgroundColor = UIColor(red:0.58, green:0.15, blue:0.85, alpha:1.0)
                        
                    }
                    else if(idsport == "activate"){
                        
                        
                        ViewSeconde.backgroundColor = UIColor(red:1.00, green:0.24, blue:0.42, alpha:1.0)
                    }
                    else if(idfood == "activate"){
                        ViewSeconde.backgroundColor = UIColor(red:0.06, green:0.93, blue:0.82, alpha:1.0)
                    }
                    else if(idgame  == "activate"){
                        ViewSeconde.backgroundColor = UIColor(red:0.26, green:0.29, blue:0.98, alpha:1.0)
                    }
                    else if(idother  == "activate"){
                        ViewSeconde.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.11, alpha:1.0)
                    }
                    else if(idchill  == "activate"){
                        ViewSeconde.backgroundColor = UIColor(red:0.44, green:0.80, blue:0.99, alpha:1.0)
                    }
                    else {
                        ViewSeconde.backgroundColor = UIColor.white
                        
                        
                    }
                    
                    
                    print( UserManager.sharedInstance.getMoodsSelects())
                    
                    if(UserManager.sharedInstance.getMoodsSelects() == "soiree".localized){
                        timersoiree.invalidate()
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "sport".localized){
                   timersport.invalidate()
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "food".localized){
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "game".localized){
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "autres".localized){
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "chill".localized){
                    }

             
                }
                    
                else if( mood.statut == "noactive"){
                    
                    //Mark: activation mood
                    SocketIOManager.sharedInstance.MoodChange(completionHandler: { (mood) -> Void in
                        DispatchQueue.main.async { () -> Void in
                            //var Mood = [String]()
                            //print(mood!)
                            
                            
                            
                        }})
                    mood.statut = "activate"
                    
                    
                    print( UserManager.sharedInstance.getMoodsSelects())
                    
                    if(UserManager.sharedInstance.getMoodsSelects() == "soiree".localized){
                        timersoiree = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimerSoiree)), userInfo: nil, repeats: true)
                        
                        ViewSeconde.backgroundColor = UIColor(red:0.58, green:0.15, blue:0.85, alpha:1.0)
                        
                        
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "sport".localized){
                        timersport = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimerSport)), userInfo: nil, repeats: true)
                        
                        
                        ViewSeconde.backgroundColor = UIColor(red:1.00, green:0.24, blue:0.42, alpha:1.0)
                     }
                    if(UserManager.sharedInstance.getMoodsSelects() == "food".localized){
                        ViewSeconde.backgroundColor = UIColor(red:0.06, green:0.93, blue:0.82, alpha:1.0)
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "game".localized){
                        ViewSeconde.backgroundColor = UIColor(red:0.26, green:0.29, blue:0.98, alpha:1.0)
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "autres".localized){
                        ViewSeconde.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.11, alpha:1.0)
                    }
                    if(UserManager.sharedInstance.getMoodsSelects() == "chill".localized){
                        ViewSeconde.backgroundColor = UIColor(red:0.44, green:0.80, blue:0.99, alpha:1.0)
                    }
                    
                }
            }
        }
        
        
        let myview = self.views as? UICollectionView
        myview?.reloadData()
        let mysecondeview = self.firstviews as? UICollectionView
        mysecondeview?.reloadData()
    }
    
    
    
    
    func updateTimerSoiree() {
        
        if seconds < 1 {
            
            timersoiree.invalidate()
            let realm = try! Realm()
            
            
            try! realm.write {
                for mood in realm.objects(Moods.self).filter("mood == %@", "soiree".localized) {
                    mood.statut = "noactive"
                    
                }
                
            }
 
            let mysecondeview = self.firstviews as? UICollectionView
            mysecondeview?.reloadData()
            
            //Send alert to indicate "time's up!"
        } else {
            
            seconds -= 1
            TimerManager.sharedInstance.setTimerSoiree(_timer: timeString(time: TimeInterval(seconds)))
         
            //print(timeString(time: TimeInterval(seconds)))
            // self.LblTimersoiree.isHidden = false
            // print( timeString(time: TimeInterval(seconds)))
            // LblTimersoiree.text = timeString(time: TimeInterval(seconds))
            
            print("/**********************  Gettimersoire  *************************************/")
            
            print(TimerManager.sharedInstance.getTimerSoiree())
            print("/***********************************************************/")
            print("/***********************************************************/")
            
            
        }
    }
    
    
    
    func updateTimerSport() {
        
        if secondssoiree < 1 {
            
            timersport.invalidate()
            let realm = try! Realm()
            
            
            try! realm.write {
                for mood in realm.objects(Moods.self).filter("mood == %@", "sport".localized) {
                    mood.statut = "noactive"
                    
                }
                
        secondssoiree = 180
                
            }
            
            let mysecondeview = self.firstviews as? UICollectionView
            mysecondeview?.reloadData()
            
            //Send alert to indicate "time's up!"
        } else {
            
            secondssoiree -= 1
            TimerManager.sharedInstance.setTimerSport(_timer: timeString(time: TimeInterval(secondssoiree)))
            print("/************************* Gettimersport *********************************/")
            
            print(TimerManager.sharedInstance.getTimerSport())
            print("/***********************************************************/")
            print("/***********************************************************/")
            
            
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }

    
    
    func SetImgsBulles( _img: [String], view: UIVisualEffectView)
    {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let ImgBulle1 = UIImageView(frame: outerView.bounds)
        let ImgBulle2 = UIImageView(frame: outerView.bounds)
        let ImgBulle3 = UIImageView(frame: outerView.bounds)
        let ImgBulle4 = UIImageView(frame: outerView.bounds)
        let ImgBulleplus = UIImageView(frame: outerView.bounds)
        let LblPlus = UILabel(frame: outerView.bounds)
        
        
        if(_img.count > 0) {
            
            
            ImgBulle4.clipsToBounds = true
            ImgBulle4.layer.cornerRadius = 20
            ImgBulle4.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[0])"), placeholderImage: UIImage(named: "placeholder.png"))
            ImgBulle4.isHidden = false
            ImgBulle4.frame = CGRect(x: 92, y: 609, width: 40, height:40)
            
        }else{ImgBulle4.isHidden = true}
        
        if(_img.count > 1) {
            ImgBulle3.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[1])"), placeholderImage: UIImage(named: "placeholder.png"))
            ImgBulle3.frame = CGRect(x: 129, y: 609, width: 40, height:40)
            
            ImgBulle3.isHidden = false
            ImgBulle3.layer.cornerRadius = 20
            ImgBulle3.clipsToBounds = true
            ImgBulle3.layer.zPosition = 5
            
        }else{ImgBulle3.isHidden = true}
        
        if(_img.count > 2) {
            
            ImgBulle2.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[2])"), placeholderImage: UIImage(named: "placeholder.png"))
            ImgBulle2.frame = CGRect(x: 166, y: 609, width: 40, height:40)
            ImgBulle2.isHidden = false
            ImgBulle2.layer.cornerRadius = 20
            ImgBulle2.clipsToBounds = true
            ImgBulle2.layer.zPosition = 5
            
            
        }else{ImgBulle2.isHidden = true}
        
        if(_img.count > 3) {
            
            ImgBulle1.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[3])"), placeholderImage: UIImage(named: "placeholder.png"))
            ImgBulle1.frame = CGRect(x: 203, y: 609, width: 40, height:40)
            ImgBulle1.isHidden = false
            ImgBulle1.layer.cornerRadius = 20
            ImgBulle1.clipsToBounds = true
            
            ImgBulle1.isHidden = false
        }else{ImgBulle1.isHidden = true}
        
        
        
        //ImgBullesPlus.image = _img
        LblPlus.text = "+\(_img.count-4)"
        ImgBulleplus.frame = CGRect(x: 243, y: 609, width: 40, height:40)
        let imgView = UIImage(named: "pixels") as UIImage?
        ImgBulleplus.image = imgView
        ImgBulleplus.isHidden = false
        ImgBulleplus.layer.cornerRadius = 20
        ImgBulleplus.clipsToBounds = true
        
        LblPlus.frame = CGRect(x: 250, y: 609, width: 143, height:140)
        
        if (_img.count-4 <= 0) {
            
            ImgBulleplus.isHidden = true
            LblPlus.isHidden = true
            
        }else {
            
            ImgBulleplus.isHidden = false
            LblPlus.isHidden = false
        }
        
        view.addSubview(ImgBulle1)
        view.addSubview(ImgBulle2)
        view.addSubview(ImgBulle3)
        view.addSubview(ImgBulle4)
        view.addSubview(ImgBulleplus)
        view.addSubview(LblPlus)
        
    }
    

    
    public func initView (canvas : UIView, collectionViews : UICollectionView, firstcollection: UICollectionView, viewseconde: UIView) {
        
        self.canvas = canvas
        self.views = collectionViews
        self.firstviews = firstcollection
        self.ViewSeconde = viewseconde
        
    }
}
