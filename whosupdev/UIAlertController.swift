//
//  UIAlertController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 09/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//
import Foundation
import UIKit

extension UIAlertController {
    func show() {
        present(true, completion: nil)
    }
    
    func present(_ animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        }
        else if let tabVC = controller as? UITabBarController,
            let selectedVC = tabVC.selectedViewController {
            presentFromController(selectedVC, animated: animated, completion: completion)
        }
        else {
            controller.view.setNeedsLayout()
            controller.present(self, animated: animated, completion: completion)
        }
    }
}
