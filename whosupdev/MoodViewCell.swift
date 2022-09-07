//
//  MoodViewCell.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/7/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class MoodViewCell: UICollectionViewCell {

    static let reuseIdentifier = "MoodViewCell"
    static var nib: UINib {
        get {
            return UINib(nibName: "MoodViewCell", bundle: nil)
        }
    }
    @IBOutlet var imageViewMood: UIImageView!
    @IBOutlet var labelMood: UILabel!
    
    @IBOutlet var imageViewCircle1: UIImageView!
    @IBOutlet var imageViewCircle2: UIImageView!
    @IBOutlet var imageViewCircle3: UIImageView!
    @IBOutlet var imageViewCircle4: UIImageView!
    @IBOutlet var viewCircle5: UIView!
    @IBOutlet var labelMore: UILabel!
    
    var MoodsParticipants: [String] = [String]()
    let m_moodmanager = MoodsManager()
    override func awakeFromNib() {
        super.awakeFromNib()
        if isIOS7 {
            self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        self.layer.masksToBounds = true
    }
    
    // In layoutSubViews, need set preferredMaxLayoutWidth for multiple lines label
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configCell(mood: Moods) {
        
        
        if mood.mood.isEqual("SOIREE"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodsoiree()
            imageViewMood.image = UIImage(named: "SOIREE")
            labelMood.text = "Soirée"
            self.backgroundColor = UIColorFromRGB(rgbValue: 0xA10BAE)
            viewCircle5.backgroundColor = UIColorFromRGB(rgbValue: 0xA10BAE)
        }else if mood.mood.isEqual("SPORT"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodsport()
            imageViewMood.image = UIImage(named: "SPORT")
            labelMood.text = "Sport"
            self.backgroundColor = UIColorFromRGB(rgbValue: 0xFE3061)
            viewCircle5.backgroundColor = UIColorFromRGB(rgbValue: 0xFE3061)
        }else if mood.mood.isEqual("FOOD"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodfood()
            imageViewMood.image = UIImage(named: "FOOD")
            labelMood.text = "Food"
            self.backgroundColor = UIColorFromRGB(rgbValue: 0x01ECD0)
            viewCircle5.backgroundColor = UIColorFromRGB(rgbValue: 0x01ECD0)
        }else if mood.mood.isEqual("CHILL"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodchill()
            imageViewMood.image = UIImage(named: "CHILL")
            labelMood.text = "Chill"
            self.backgroundColor = UIColorFromRGB(rgbValue: 0x75C1FF)
            viewCircle5.backgroundColor = UIColorFromRGB(rgbValue: 0x75C1FF)
        }else if mood.mood.isEqual("OTHER"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodautres()
            imageViewMood.image = UIImage(named: "OTHER")
            labelMood.text = "Autres"
            self.backgroundColor = UIColorFromRGB(rgbValue: 0xF3B700)
            viewCircle5.backgroundColor = UIColorFromRGB(rgbValue: 0xF3B700)
        }else if mood.mood.isEqual("GAME"){
            self.MoodsParticipants = m_moodmanager.initRequetemoodgame()
            imageViewMood.image = UIImage(named: "GAME")
            labelMood.text = "Jeux"
             self.backgroundColor = UIColorFromRGB(rgbValue: 0x4F3BDE)
            viewCircle5.backgroundColor = UIColorFromRGB(rgbValue: 0x4F3BDE)
        }
    
        
        
        
        //Activate autolayout modification
        self.setNeedsLayout()
        self.layoutIfNeeded()
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
        
        
        
        //Keep this code lines after the layoutIfNeeded
        //Set the shadow on Rounded profile image
        //rounded circle imageview
        if(self.MoodsParticipants.count > 0) {
        imageViewCircle1.isHidden = false
        imageViewCircle1.layer.borderWidth = 2
        imageViewCircle1.layer.masksToBounds = false
        imageViewCircle1.layer.borderColor = UIColor.white.cgColor
        imageViewCircle1.layer.cornerRadius = imageViewCircle1.frame.size.width/2
        imageViewCircle1.clipsToBounds = true
        imageViewCircle1.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[0]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
         imageViewCircle1.isHidden = true
        }
        
        if(self.MoodsParticipants.count > 1) {
        imageViewCircle2.isHidden = false
        imageViewCircle2.layer.borderWidth = 2
        imageViewCircle2.layer.masksToBounds = false
        imageViewCircle2.layer.borderColor = UIColor.white.cgColor
        imageViewCircle2.layer.cornerRadius = imageViewCircle2.frame.size.width/2
        imageViewCircle2.clipsToBounds = true
        imageViewCircle2.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[1]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
        imageViewCircle2.isHidden = true
        }
        
         if(self.MoodsParticipants.count > 2) {
        imageViewCircle3.isHidden = false
        imageViewCircle3.layer.borderWidth = 2
        imageViewCircle3.layer.masksToBounds = false
        imageViewCircle3.layer.borderColor = UIColor.white.cgColor
        imageViewCircle3.layer.cornerRadius = imageViewCircle3.frame.size.width/2
        imageViewCircle3.clipsToBounds = true
        imageViewCircle3.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[2]), placeholderImage: UIImage(named: "placeholder.png"))
         }else {
        imageViewCircle3.isHidden = true
        }
        
        if(self.MoodsParticipants.count > 3) {
        imageViewCircle4.isHidden = false
        imageViewCircle4.layer.borderWidth = 2
        imageViewCircle4.layer.masksToBounds = false
        imageViewCircle4.layer.borderColor = UIColor.white.cgColor
        imageViewCircle4.layer.cornerRadius = imageViewCircle4.frame.size.width/2
        imageViewCircle4.clipsToBounds = true
        imageViewCircle4.sd_setImage(with: URL(string: "URLserver".localized + self.MoodsParticipants[3]), placeholderImage: UIImage(named: "placeholder.png"))
        }else {
        imageViewCircle4.isHidden = true
        }
        
        if(self.MoodsParticipants.count > 4) {
        viewCircle5.isHidden = false
        viewCircle5.layer.borderWidth = 2
        viewCircle5.layer.masksToBounds = false
        viewCircle5.layer.borderColor = UIColor.white.cgColor
        viewCircle5.layer.cornerRadius = viewCircle5.frame.size.width/2
        viewCircle5.clipsToBounds = true
        labelMore.text = "+\(self.MoodsParticipants.count-4)"
        }else {
        viewCircle5.isHidden = true
        }
        
        //Radius on cell container
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = false
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
