//
//  ViewController.swift
//  KDDragAndDropCollectionViews
//
//  Created by Michael Michailidis on 10/04/2015.
//  Copyright (c) 2015 Karmadust. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
import RealmSwift


class InstantsLioViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SwipeCarouselDelegate {
    
    @IBOutlet weak var topCollectionView: UICollectionView!{
        didSet {
            topCollectionView.register(MyProfileViewCell.nib, forCellWithReuseIdentifier: MyProfileViewCell.reuseIdentifier)
        }
    }
    @IBOutlet var bottomCollectionView: UICollectionView!{
        didSet {
            bottomCollectionView.register(MoodViewCell.nib, forCellWithReuseIdentifier: MoodViewCell.reuseIdentifier)
            bottomCollectionView.register(InstantViewCell.nib, forCellWithReuseIdentifier: InstantViewCell.reuseIdentifier)
            bottomCollectionView.register(ProfileViewCell.nib, forCellWithReuseIdentifier: ProfileViewCell.reuseIdentifier)
        }
    }

    
    @IBOutlet var buttonCloseMood: UIButton!
    @IBOutlet weak var buttonNotif: UIButton!
    @IBOutlet weak var textFieldHashtag: UITextField!
    
    var savedDataForBottomCollection:NSMutableArray = NSMutableArray()
    var dataForBottomCollection:NSMutableArray = NSMutableArray()
    var selectedCardIndex:NSInteger = 0
    // MARK: Static var
    fileprivate let sectionInsetsTop = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    fileprivate let sectionInsetsBottom = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 15.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 1
  
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self

        //Add an Instants
   
        
        self.MajDataForBottomCollection()
        self.callSocket()
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Appel de socket mis à jour des données
    
    
    func callSocket() {
        
        SocketIOManager.sharedInstance.getmajConnectedUser(viewcollection: self.bottomCollectionView)
        SocketIOManager.sharedInstance.GetMajInstant(completionHandler: { (instantmaj) -> Void in
            DispatchQueue.main.async { () -> Void in
            RequestServer.sharedInstance.GetInstant() { (json) in
                DispatchQueue.main.async { () -> Void in
                    self.MajDataForBottomCollection()
                    self.bottomCollectionView.reloadData()
             }
                }
             }})
        
        SocketIOManager.sharedInstance.getuserMatched()
        
    }
    
    //MARK: Mis a jour dataForBottomCollection
    func MajDataForBottomCollection () {
        
        dataForBottomCollection.removeAllObjects()
        
        let realm = try! Realm()
        let InstantsLists = realm.objects(Instant.self)
        print(InstantsLists)
    
        for InstantItem in InstantsLists {
            dataForBottomCollection.add(InstantItem)
        }
    
        //Add static mood
        let party = Moods()
        party.m_id = 1
        party.mood = "SOIREE"
    
        let sport = Moods()
        sport.m_id = 2
        sport.mood = "SPORT"
    
        let food = Moods()
        food.m_id = 3
        food.mood = "FOOD"
    
        let game = Moods()
        game.m_id = 4
        game.mood = "GAME"
    
        let other = Moods()
        other.m_id = 5
        other.mood = "OTHER"
    
        let chill = Moods()
        chill.m_id = 6
        chill.mood = "CHILL"
    
        dataForBottomCollection.add(party)
        dataForBottomCollection.add(sport)
        dataForBottomCollection.add(food)
        dataForBottomCollection.add(game)
        dataForBottomCollection.add(other)
        dataForBottomCollection.add(chill)
      
        

    }
    
    
    // MARK: Conform to the SwipingCarousel Delegate
    func cellSwipedUp(_ cell: UICollectionViewCell) {
        
    }
    
    func cellSwipedDown(_ cell: UICollectionViewCell) {
        
        //Test if instants or mood for the matching screen
         let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if dataForBottomCollection[selectedCardIndex] is Instant{
            
            let viewController : MatchingJoinInstantViewController = storyboard.instantiateViewController(withIdentifier: "MatchingJoinInstantViewController") as! MatchingJoinInstantViewController
            let instantSelec = dataForBottomCollection[selectedCardIndex] as! Instant
            viewController.hashtag = instantSelec.hashtag
            viewController.id_instant = instantSelec._id
            viewController.url_picture = instantSelec.picture
            viewController.mood = instantSelec.mood
            UserManager.sharedInstance.mainNavigationController.present(viewController, animated: true)
        }else{
            let viewController : MatchingActivateMoodViewController = storyboard.instantiateViewController(withIdentifier: "MatchingActivateMoodViewController") as! MatchingActivateMoodViewController
            let moodSelec = dataForBottomCollection[selectedCardIndex] as! Moods
            viewController.nameMoods = moodSelec.mood
            UserManager.sharedInstance.mainNavigationController.present(viewController, animated: true)
        }
    }
    
    func onSwiping(_ cell: UICollectionViewCell, Yposition: CGFloat){
        //NSLog("OnSwiping")
    }
    
    
    func beginSwipe(_ cell: UICollectionViewCell){
        
        //Change size for the cell overlay the cards instants/moods
        let screenSize: CGRect = UIScreen.main.bounds
        topCollectionView.frame = CGRect(x: 0, y: topCollectionView.frame.origin.y, width: screenSize.width, height: screenSize.height)
        topCollectionView.layer.zPosition = 3
    }

    // MARK : UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topCollectionView{
            return 1;
        }else{
            return dataForBottomCollection.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.topCollectionView {
            if let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
                
                viewController.isMyProfile = true
                UserManager.sharedInstance.mainNavigationController.pushViewController(viewController, animated: true)
            }
        }else{
            if dataForBottomCollection[selectedCardIndex] is Moods{
                //Save instant and mood data
                savedDataForBottomCollection = dataForBottomCollection
                
                //TODO Set background color
                bottomCollectionView.backgroundColor =  UIColorFromRGB(rgbValue: 0x4F3BDE,alpha:1.0)
                
                //Display close button
                buttonCloseMood.isHidden = false
                
                //DATATEST
                //TODO: add people from instant here
                dataForBottomCollection = NSMutableArray()
                dataForBottomCollection.add(User())
                dataForBottomCollection.add(User())
                dataForBottomCollection.add(User())
                dataForBottomCollection.add(User())
                dataForBottomCollection.add(User())
                
                bottomCollectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollectionView{
            let cellTop: MyProfileViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyProfileViewCell.reuseIdentifier, for: indexPath) as! MyProfileViewCell
        
            // TODO: set the current user here
            cellTop.configCell()
            
            cellTop.delegate = self
            cellTop.deleteOnSwipeDown = true
        
            cellTop.layoutIfNeeded()
            return cellTop
        }else{
           
            if dataForBottomCollection[indexPath.row] is Moods {
                let cellBottom: MoodViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodViewCell.reuseIdentifier, for: indexPath) as! MoodViewCell
                cellBottom.configCell(mood: dataForBottomCollection[indexPath.row] as! Moods)
                cellBottom.layoutIfNeeded()
                return cellBottom

            }else if dataForBottomCollection[indexPath.row] is Instant {
                let cellBottom: InstantViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: InstantViewCell.reuseIdentifier, for: indexPath) as! InstantViewCell
                cellBottom.configCell(instant: dataForBottomCollection[indexPath.row] as! Instant)
                cellBottom.layoutIfNeeded()
                return cellBottom
            }else{
                let cellBottom: ProfileViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileViewCell.reuseIdentifier, for: indexPath) as! ProfileViewCell
                
                cellBottom.configCell()
                cellBottom.layoutIfNeeded()
                return cellBottom
            }
        }
    }
    
    func scrollToNearestVisibleCollectionViewCell() {
        
        let visibleCenterPositionOfScrollView = Float(bottomCollectionView.contentOffset.x + (self.bottomCollectionView!.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<bottomCollectionView.visibleCells.count {
            let cell = bottomCollectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = bottomCollectionView.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.bottomCollectionView!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        
        self.selectedCardIndex = closestCellIndex
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
    }
    

    
    
    
    
    //MARK: Button action
    
    @IBAction func actionCloseMood(_ sender: Any) {
        buttonCloseMood.isHidden = true
        bottomCollectionView.backgroundColor = UIColor.clear
        dataForBottomCollection = savedDataForBottomCollection
        bottomCollectionView.reloadData()
    }
    
}


extension InstantsLioViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        if collectionView == topCollectionView {
            let paddingSpace = sectionInsetsTop.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: topCollectionView.frame.size.height)
        }else{
            let paddingSpace = sectionInsetsBottom.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem-40, height: bottomCollectionView.frame.size.height - sectionInsetsBottom.bottom)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == topCollectionView {
            return sectionInsetsTop
        }else{
            return sectionInsetsBottom
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topCollectionView {
            return sectionInsetsTop.left
        }else{
            return sectionInsetsBottom.left
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

}



