//
//  EditProfileViewController.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/4/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController{
    
    @IBOutlet var textFieldEmojis: UITextField!
    @IBOutlet var textFieldAge: UITextField!
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var imageViewProfile: UIImageView!
    @IBOutlet var viewInfos: UIView!
    
    // MARK: ViewController Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // MARK: Action Button
    @IBAction func actionRegister(_ sender: Any) {
    }
    @IBAction func actionUpdatePicture(_ sender: Any) {
    }
    @IBAction func actionBack(_ sender: Any) {
       UserManager.sharedInstance.mainNavigationController.popViewController(animated: true)
    }
    
}
