//
//  ProfileViewController.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/4/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: IBOutlet
    @IBOutlet var imageViewProfile: UIImageView!
    @IBOutlet var viewInfos: UIView! //It's a center view with name age infos
    @IBOutlet var labelNameAge: UILabel!
    @IBOutlet var labelEmoji: UILabel!
    @IBOutlet var labelInstantJoined: UILabel!
    @IBOutlet var viewContainerSearch: UIView! //If is in my profile
    @IBOutlet var labelNumberOfFriends: UILabel!
    @IBOutlet var textFieldSearch: UITextField!
    @IBOutlet var viewContainerFriend: UIView! //If is in the other people profile
    @IBOutlet var buttonIsFriend: UIButton!
    @IBOutlet var buttonAddFriend: UIButton!
    @IBOutlet var collectionViewFriends: UICollectionView!{ didSet { //Set all cell of collectionview here for optim
        collectionViewFriends.register(FriendViewCell.nib, forCellWithReuseIdentifier: FriendViewCell.reuseIdentifier)
        }
    }
    
    // MARK: Global var
    var isMyProfile:Bool = false
    
    // MARK: Static var
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)
    fileprivate let itemsPerRow: CGFloat = 3

    
    // MARK: ViewController Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init view for the button add friend or search
        if isMyProfile{
            viewContainerSearch.isHidden = false
            viewContainerFriend.isHidden = true
        }else{
            viewContainerSearch.isHidden = true
            viewContainerFriend.isHidden = false
        }
        
        //Init delegate
        collectionViewFriends.delegate = self
        collectionViewFriends.dataSource = self
        
        //set shadow and rounded on view container
        viewInfos.layer.cornerRadius = 15.0
        viewInfos.layer.masksToBounds = false
        viewInfos.layer.shadowColor = UIColor.black.cgColor
        viewInfos.layer.shadowOpacity = 0.3
        viewInfos.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewInfos.layer.shadowRadius = 5
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: CollectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // TODO: set the real datasource from friend list for the current user
        return 35;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellTop: FriendViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendViewCell.reuseIdentifier, for: indexPath) as! FriendViewCell
        
            // TODO: set the current user here
            cellTop.configCell(user: User.init())
        
            cellTop.layoutIfNeeded()
            return cellTop
    }
    
    
    // MARK: button Action
    @IBAction func actionUnfriended(_ sender: Any) {
    }
    
    @IBAction func actionAddFriend(_ sender: Any) {
    }
    
    @IBAction func actionBack(_ sender: Any) {
       UserManager.sharedInstance.mainNavigationController.popViewController(animated: true)
    }
    
    @IBAction func actionEdit(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController : EditProfileViewController = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
       UserManager.sharedInstance.mainNavigationController.pushViewController(viewController, animated: true)
    }
}

//Use for 3 items per row
extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
