//
//  FriendViewCell.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/4/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

class FriendViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FriendViewCell"
    static var nib: UINib {
        get {
            return UINib(nibName: "FriendViewCell", bundle: nil)
        }
    }
    
    @IBOutlet var imageViewCheck: UIImageView!
    @IBOutlet var labelName: UILabel!
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
    
    func configCell(user: User) {
        
        // TODO: uncomment and set the image and name here
        //labelName.text = user.firsname
        //imageViewProfile
        
        //Set the shadow on cell
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 5

        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        //rounded circle imageview
        //Keep this code lines after the layoutIfNeeded
        imageViewProfile.layer.borderWidth = 1
        imageViewProfile.layer.masksToBounds = false
        imageViewProfile.layer.borderColor = UIColor.lightGray.cgColor
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.clipsToBounds = true
    }
    
}

