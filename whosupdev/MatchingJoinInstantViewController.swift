//
//  MatchingJoinInstant.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/6/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

class MatchingJoinInstantViewController: UIViewController{
    
    
    // MARK: IBOutlet var
    @IBOutlet var viewInstantContainer: UIView!
    @IBOutlet var labelFriends: UILabel!
    @IBOutlet var imageViewMood: UIImageView!
    @IBOutlet var imageViewProfile: UIImageView!
    @IBOutlet var buttonYeah: UIButton!
    @IBOutlet weak var LblHashtag: UILabel!
    @IBOutlet var view1people: UIView!
    @IBOutlet var imageView1people: UIImageView!
    var id_instant:String = String()
    var url_picture:String = String()
    var hashtag:String = String()
    var mood:String = String()
    // MARK: ViewController life circle
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        imageViewProfile.setNeedsLayout()
        imageViewProfile.layoutIfNeeded()
        viewInstantContainer.setNeedsLayout()
        viewInstantContainer.layoutIfNeeded()

        // Gestion du label peoples
        let instantId = InstantsManager()
        let mynamearray = instantId.initMembers(_id: id_instant)
        
        if (mynamearray.count != 0){
            for i in 0...mynamearray.count - 1
            {
                if(mynamearray.count < 3 ) {
                    if(labelFriends.text == ""){
                        labelFriends.text = mynamearray[i]
                    }
                    else{ labelFriends.text = labelFriends.text! + ", " + mynamearray[i]}
                }else { labelFriends.text = labelFriends.text! + " et " + String(mynamearray.count - 3) + " autres"}
            }
        }
   
        imageView1people.sd_setImage(with: URL(string: "URLserver".localized + url_picture), placeholderImage: UIImage(named: "placeholder.png"))
        LblHashtag.text = "#" + hashtag
      
        //Keep this code lines after the layoutIfNeeded
        //Set the shadow on Container friend
        viewInstantContainer.layer.masksToBounds = false
        viewInstantContainer.layer.shadowColor = UIColor.black.cgColor
        viewInstantContainer.layer.shadowOpacity = 0.3
        viewInstantContainer.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewInstantContainer.layer.shadowRadius = 5
        viewInstantContainer.layer.borderWidth = 10
        viewInstantContainer.layer.masksToBounds = false
        viewInstantContainer.layer.borderColor = UIColor.white.cgColor
        viewInstantContainer.layer.cornerRadius = 15
        viewInstantContainer.clipsToBounds = true
        
        //rounded circle imageview
        imageViewProfile.layer.borderWidth = 10
        imageViewProfile.layer.masksToBounds = false
        imageViewProfile.layer.borderColor = UIColor.white.cgColor
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.clipsToBounds = true
        imageViewProfile.image = User.sharedInstance.getmediumPhoto()
        
        //Radius buttonYeah
        buttonYeah.layer.masksToBounds = false
        buttonYeah.layer.cornerRadius = 15
        buttonYeah.clipsToBounds = true
        
        if mood.isEqual("SOIREE"){
            imageViewMood.image = UIImage(named: "ic_party")
            imageView1people.layer.borderColor = UIColorFromRGB(rgbValue: 0xA10BAE,alpha:1.0).cgColor
        }else if mood.isEqual("SPORT"){
            imageViewMood.image = UIImage(named: "ic_sport")
            imageView1people.layer.borderColor = UIColorFromRGB(rgbValue: 0xFE3061,alpha:1.0).cgColor
        }else if mood.isEqual("FOOD"){
            imageViewMood.image = UIImage(named: "ic_food")
            imageView1people.layer.borderColor = UIColorFromRGB(rgbValue: 0x01ECD0,alpha:1.0).cgColor
        }else if mood.isEqual("CHILL"){
            imageViewMood.image = UIImage(named: "ic_chill")
            imageView1people.layer.borderColor = UIColorFromRGB(rgbValue: 0x75C1FF,alpha:1.0).cgColor
        }else if mood.isEqual("OTHER"){
            imageViewMood.image = UIImage(named: "ic_other")
            imageView1people.layer.borderColor = UIColorFromRGB(rgbValue: 0xF3B700,alpha:1.0).cgColor
        }else if mood.isEqual("GAME"){
            imageViewMood.image = UIImage(named: "ic_game")
            imageView1people.layer.borderColor = UIColorFromRGB(rgbValue: 0x4F3BDE, alpha:1.0).cgColor
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
    
    // MARK: Button Action
    @IBAction func actionYeah(_ sender: Any) {
        
        SocketIOManager.sharedInstance.GetinstantJoined(instantid: id_instant)
          self.dismiss(animated: true)
    }
    
    @IBAction func actionFinallyNo(_ sender: Any) {
       self.dismiss(animated: true)
    }
}
