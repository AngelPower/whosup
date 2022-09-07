//
//  InstantDetailChatViewController.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/17/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class InstantDetailChatViewController: UIViewController {

    @IBOutlet var textFieldMsg: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var imageViewInstantPeople: UIImageView!
    @IBOutlet var textFieldHashtag: UIView!
    @IBOutlet var labelNbNotif: UILabel!
    @IBOutlet var labelPeoples: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func actionLeaveInstant(_ sender: Any) {
    }
    @IBAction func actionSendMessage(_ sender: Any) {
    }

}
