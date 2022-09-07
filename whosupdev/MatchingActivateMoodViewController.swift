//
//  MatchingActivateMoodViewController.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/6/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class MatchingActivateMoodViewController: UIViewController {

    
    
    @IBOutlet var imageViewProfile: UIImageView!
    @IBOutlet var imageViewMood: UIImageView!
    @IBOutlet var labelMood: UILabel!
    
    @IBOutlet var imageViewCircle1: UIImageView!
    @IBOutlet var imageViewCircle2: UIImageView!
    @IBOutlet var imageViewCircle3: UIImageView!
    @IBOutlet var imageViewCircle4: UIImageView!
    @IBOutlet var viewCircle5: UIView!
    @IBOutlet var labelMore: UILabel!
    @IBOutlet var buttonYeah: UIButton!
    var nameMoods:String = String()
    var MoodsParticipants: [String] = [String]()
    let m_moodmanager = MoodsManager()
    // MARK: View Controller Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Activate autolayout modification
        imageViewProfile.setNeedsLayout()
        imageViewProfile.layoutIfNeeded()
        imageViewCircle1.setNeedsLayout()
        imageViewCircle1.layoutIfNeeded()
        imageViewCircle2.setNeedsLayout()
        imageViewCircle2.layoutIfNeeded()
        imageViewCircle3.setNeedsLayout()
        imageViewCircle3.layoutIfNeeded()
        imageViewCircle4.setNeedsLayout()
        imageViewCircle4.layoutIfNeeded()
        viewCircle5.setNeedsLayout()
        viewCircle5.layoutIfNeeded()
        
        //image mood
        imageViewMood.image = UIImage(named: nameMoods)
        labelMood.text = nameMoods
        
        //Keep this code lines after the layoutIfNeeded
        //Set the shadow on Rounded profile image
        //rounded circle imageview
        imageViewProfile.layer.borderWidth = 4
        imageViewProfile.layer.masksToBounds = false
        imageViewProfile.layer.borderColor = UIColor.white.cgColor
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.clipsToBounds = true
        imageViewProfile.layer.shadowColor = UIColor.black.cgColor
        imageViewProfile.layer.shadowOpacity = 0.3
        imageViewProfile.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageViewProfile.layer.shadowRadius = 5
        imageViewProfile.image = User.sharedInstance.getmediumPhoto()
        
        //récupération des vignettes profiles
        
        if nameMoods.isEqual("SOIREE"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodsoiree()
        }else if nameMoods.isEqual("SPORT"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodsport()
        }else if nameMoods.isEqual("FOOD"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodfood()
        }else if nameMoods.isEqual("CHILL"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodchill()
        }else if nameMoods.isEqual("OTHER"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodautres()
        }else if nameMoods.isEqual("GAME"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodgame()
        }
        
        
        
        if(self.MoodsParticipants.count > 0) {
        imageViewCircle1.layer.borderWidth = 4
        imageViewCircle1.layer.masksToBounds = false
        imageViewCircle1.layer.borderColor = UIColor.white.cgColor
        imageViewCircle1.layer.cornerRadius = imageViewCircle1.frame.size.width/2
        imageViewCircle1.clipsToBounds = true
        imageViewCircle1.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[0]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
            imageViewCircle1.isHidden = true
        }
        
        if(self.MoodsParticipants.count > 1) {
        imageViewCircle2.layer.borderWidth = 4
        imageViewCircle2.layer.masksToBounds = false
        imageViewCircle2.layer.borderColor = UIColor.white.cgColor
        imageViewCircle2.layer.cornerRadius = imageViewCircle2.frame.size.width/2
        imageViewCircle2.clipsToBounds = true
        imageViewCircle2.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[1]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
            imageViewCircle2.isHidden = true
        }
        
        if(self.MoodsParticipants.count > 2) {
        imageViewCircle3.layer.borderWidth = 4
        imageViewCircle3.layer.masksToBounds = false
        imageViewCircle3.layer.borderColor = UIColor.white.cgColor
        imageViewCircle3.layer.cornerRadius = imageViewCircle3.frame.size.width/2
        imageViewCircle3.clipsToBounds = true
        imageViewCircle3.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[2]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
            imageViewCircle3.isHidden = true
        }
        
        if(self.MoodsParticipants.count > 3) {
        imageViewCircle4.layer.borderWidth = 4
        imageViewCircle4.layer.masksToBounds = false
        imageViewCircle4.layer.borderColor = UIColor.white.cgColor
        imageViewCircle4.layer.cornerRadius = imageViewCircle4.frame.size.width/2
        imageViewCircle4.clipsToBounds = true
        imageViewCircle4.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[3]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
            imageViewCircle4.isHidden = true
        }
        
         if(self.MoodsParticipants.count > 4) {
        viewCircle5.layer.borderWidth = 4
        viewCircle5.layer.masksToBounds = false
        viewCircle5.layer.borderColor = UIColor.white.cgColor
        viewCircle5.layer.cornerRadius = viewCircle5.frame.size.width/2
        viewCircle5.clipsToBounds = true
        labelMore.text = "+\(self.MoodsParticipants.count-4)"
         }else {
            viewCircle5.isHidden = true
        }
        
        //Radius buttonYeah
        buttonYeah.layer.masksToBounds = false
        buttonYeah.layer.cornerRadius = 15
        buttonYeah.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
    @IBAction func actionYeah(_ sender: Any) {
        
        SocketIOManager.sharedInstance.GetupdateConnectedUser(moodsActivate: nameMoods, hachtagCreate: "")
        self.dismiss(animated: true)

    }
    
    @IBAction func actionFinallyNo(_ sender: Any) {
        self.dismiss(animated: true)
    }


}
