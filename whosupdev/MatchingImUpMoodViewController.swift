//
//  MatchingImUpMoodViewController.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/6/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class MatchingImUpMoodViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet var imageViewProfile: UIImageView!
    @IBOutlet var imageViewMood: UIImageView!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var buttonYeah: UIButton!
    
     // MARK: - View Controller Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Activate autolayout modification
        imageViewProfile.setNeedsLayout()
        imageViewProfile.layoutIfNeeded()
        
        //rounded circle imageview
        imageViewProfile.layer.borderWidth = 10
        imageViewProfile.layer.masksToBounds = false
        imageViewProfile.layer.borderColor = UIColor.white.cgColor
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.clipsToBounds = true
        
        //Radius buttonYeah
        buttonYeah.layer.masksToBounds = false
        buttonYeah.layer.cornerRadius = 15
        buttonYeah.clipsToBounds = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button action
    @IBAction func actionFinallyNo(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func actionYeah(_ sender: Any) {
    }
}
