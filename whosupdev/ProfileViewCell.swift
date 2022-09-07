//
//  ProfileViewCell.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/17/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class ProfileViewCell: UICollectionViewCell {

    static let reuseIdentifier = "ProfileViewCell"
    static var nib: UINib {
        get {
            return UINib(nibName: "ProfileViewCell", bundle: nil)
        }
    }
    
    @IBOutlet var labelDistance: UILabel!
    @IBOutlet var labelProfileName: UILabel!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var labelHashtag: UILabel!
    @IBOutlet var imageViewProfile: UIImageView!
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
    
    func configCell() {
        //Activate autolayout modification
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        //set shadow and rounded on view container
        viewContainer.layer.cornerRadius = viewContainer.frame.size.width/2
        viewContainer.layer.masksToBounds = false
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.3
        viewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewContainer.layer.shadowRadius = 5
        
        imageViewProfile.layer.borderWidth = 10
        imageViewProfile.layer.masksToBounds = false
        imageViewProfile.layer.borderColor = UIColor.white.cgColor
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.clipsToBounds = true
                
        
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
