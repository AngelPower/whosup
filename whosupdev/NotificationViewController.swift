//
//  NotificationViewController.swift
//  whosupdev
//
//  Created by SYN-MBO-DEV-03 on 8/6/17.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    // MARK: ViewController Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: TableView delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Returning the cell
        return UITableViewCell()
    }
    
    
    
    // MARK: Action Button
    @IBAction func actionBack(_ sender: Any) {
        UserManager.sharedInstance.mainNavigationController.popViewController(animated: true)
    }
}
