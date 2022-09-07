//
//  ProfileView.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/3/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit


// Check System Version
let isIOS7: Bool = !isIOS8
let isIOS8: Bool = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1


class MyProfileViewCell: SwipeCarouselCollectionViewCell {
    
    static let reuseIdentifier = "MyProfileViewCell"
    static var nib: UINib {
        get {
            return UINib(nibName: "MyProfileViewCell", bundle: nil)
        }
    }
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var imageViewProfile: UIImageView!
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
        //TODO Set l'image ici

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
        imageViewProfile.image = User.sharedInstance.getmediumPhoto()
    
        
    }
    
}
