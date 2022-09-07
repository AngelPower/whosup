//
//  PhoneInscriptionViewController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 07/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import Alamofire

class PhoneInscriptionViewController: UIViewController {

    

    var nameUser = String()
    var codeValidate = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func actionAlright(_ sender: Any) {
 
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController : HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        UserManager.sharedInstance.mainNavigationController.pushViewController(viewController, animated: true)
        
        
    
    
    }

    

}
