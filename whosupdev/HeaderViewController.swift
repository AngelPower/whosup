//
//  HeaderViewController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 19/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import Alamofire

class HeaderViewController: UIViewController {


    @IBOutlet weak var MainView: UIView!
  
    @IBOutlet weak var TxtFieldHachtag: UITextField!
    
    
    @IBOutlet weak var BtnNotif: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // swipeViewFrame =  CGRect(x: 0, y: 300, width: view.frame.size.width, height: view.frame.size.height)


        self.view.backgroundColor = UIColor(red:0.26, green:0.39, blue:0.84, alpha:1.0)
        Alamofire.request("https://scontent-cdt1-1.xx.fbcdn.net/v/t1.0-9/19145975_10154355356611735_1254393986764776591_n.jpg?oh=922bfc6f85a0454ae07a2bae4224cb02&oe=59C6E65B").responseImage { response in
            
            if let image = response.result.value {
                print("okokokokoko")
                let fileManager = FileManager.default
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("picprofil")
                //let image = UIImage(named: "apple.jpg")
                
                print(paths)
                let imageData = UIImagePNGRepresentation(image)!
                fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
                
               // self.MainView.addSubview(UserManager.sharedInstance.GetPicProfilCircle(_url: paths, _mood: "soiree".localized))
                
            }
        }
        
       // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
