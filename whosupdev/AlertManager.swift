//
//  AlertManager.swift
//  whosupdev
//
//  Created by Sophie Romanet on 09/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

class AlertManager: NSObject , UIAlertViewDelegate {

    static let sharedInstance = AlertManager()
    
    
    func DoubleMessage( _message: String, _title: String, _controller: UIViewController) {
    
        let refreshAlert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
    
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
    
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
       _controller.present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func SimpleMessage( _message: String, _title: String, _controller: UIViewController) {
        
        print("ok")
        
        let refreshAlert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        _controller.present(refreshAlert, animated: true, completion: nil)
        
    }

}
