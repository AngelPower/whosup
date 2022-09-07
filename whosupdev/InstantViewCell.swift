//
//  InstantViewCell.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/9/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class InstantViewCell: UICollectionViewCell {
    static let reuseIdentifier = "InstantViewCell"
    static var nib: UINib {
        get {
            return UINib(nibName: "InstantViewCell", bundle: nil)
        }
    }

    
    @IBOutlet var labelDistance: UILabel!
    @IBOutlet var labelPeoples: UILabel!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var labelHashtag: UILabel!
    @IBOutlet var imageViewInstant: UIImageView!
    @IBOutlet var imageViewMood: UIImageView!
    
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
    
    func configCell(instant: Instant) {
        
        //Activate autolayout modification
        self.setNeedsLayout()
        self.layoutIfNeeded()
        labelPeoples.text = ""
        viewContainer.layer.cornerRadius = 15
        viewContainer.layer.masksToBounds = false
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.3
        viewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewContainer.layer.shadowRadius = 5
        
        imageViewInstant.layer.borderWidth = 10
        imageViewInstant.layer.masksToBounds = false
        imageViewInstant.layer.cornerRadius = 15
        imageViewInstant.clipsToBounds = true
        
        //Radius on cell container
        self.layer.cornerRadius = 10.0
        //self.layer.borderWidth = 1
        //self.layer.borderColor = UIColorFromRGB(rgbValue: 0xEEEEEE,alpha:1.0).cgColor
        self.layer.masksToBounds = false
        
        // Gestion du label peoples
        let instantId = InstantsManager()
        let mynamearray = instantId.initMembers(_id: instant._id)
        if (mynamearray.count != 0){
                if(mynamearray.count <= 3 ) {
                    for i in 0...mynamearray.count - 1 {
                    if (i == 0) {labelPeoples.text =  mynamearray[i]}
                    else {labelPeoples.text = labelPeoples.text! + ", " + mynamearray[i]}
                    }
                }else {
                    labelPeoples.text = mynamearray[0] + ", " + mynamearray[1] + ", " + mynamearray[2] + " et " + String(mynamearray.count - 3) + " autres"
                }
            }

         imageViewInstant.sd_setImage(with: URL(string: "URLserver".localized + instant.picture), placeholderImage: UIImage(named: "placeholder.png"))
        labelHashtag.text = "#" + instant.hashtag
        if instant.mood.isEqual("SOIREE"){
            imageViewMood.image = UIImage(named: "ic_party")
            imageViewInstant.layer.borderColor = UIColorFromRGB(rgbValue: 0xA10BAE,alpha:1.0).cgColor
            self.backgroundColor = UIColorFromRGB(rgbValue: 0xA10BAE,alpha:0.08)
            labelHashtag.textColor = UIColorFromRGB(rgbValue: 0xA10BAE,alpha:1.0)
        }else if instant.mood.isEqual("SPORT"){
            imageViewMood.image = UIImage(named: "ic_sport")
            imageViewInstant.layer.borderColor = UIColorFromRGB(rgbValue: 0xFE3061,alpha:1.0).cgColor
            self.backgroundColor = UIColorFromRGB(rgbValue: 0xFE3061,alpha:0.08)
            labelHashtag.textColor = UIColorFromRGB(rgbValue: 0xFE3061,alpha:1.0)
        }else if instant.mood.isEqual("FOOD"){
            imageViewMood.image = UIImage(named: "ic_food")
            imageViewInstant.layer.borderColor = UIColorFromRGB(rgbValue: 0x01ECD0,alpha:1.0).cgColor
            self.backgroundColor = UIColorFromRGB(rgbValue: 0x01ECD0,alpha:0.08)
            labelHashtag.textColor = UIColorFromRGB(rgbValue: 0x01ECD0,alpha:1.0)
        }else if instant.mood.isEqual("CHILL"){
            imageViewMood.image = UIImage(named: "ic_chill")
            imageViewInstant.layer.borderColor = UIColorFromRGB(rgbValue: 0x75C1FF,alpha:1.0).cgColor
            self.backgroundColor = UIColorFromRGB(rgbValue: 0x75C1FF,alpha:0.08)
            labelHashtag.textColor = UIColorFromRGB(rgbValue: 0x75C1FF,alpha:1.0)
        }else if instant.mood.isEqual("OTHER"){
            imageViewMood.image = UIImage(named: "ic_other")
            imageViewInstant.layer.borderColor = UIColorFromRGB(rgbValue: 0xF3B700,alpha:1.0).cgColor
            self.backgroundColor = UIColorFromRGB(rgbValue: 0xF3B700,alpha:0.08)
            labelHashtag.textColor = UIColorFromRGB(rgbValue: 0xF3B700,alpha:1.0)
        }else if instant.mood.isEqual("GAME"){
            imageViewMood.image = UIImage(named: "ic_game")
            imageViewInstant.layer.borderColor = UIColorFromRGB(rgbValue: 0x4F3BDE, alpha:1.0).cgColor
            self.backgroundColor = UIColorFromRGB(rgbValue: 0x4F3BDE,alpha:0.08)
            labelHashtag.textColor = UIColorFromRGB(rgbValue: 0x4F3BDE,alpha:1.0)
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
