//
//  UITextFieldExtension.swift
//  whosupdev
//
//  Created by Sophie Romanet on 07/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
  
    
    /*@IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
    
    func showError(){
        let errorImageView = UIImageView(frame:CGRect(x: 0, y: 0,width: 40, height: 20))
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.image = UIImage(named: "error_icon")
        self.rightView?.isHidden = false
        self.rightView = errorImageView
        self.rightViewMode = .always
    }
    
    func hideError(){
        self.rightView?.isHidden = true
    }*/
    
    func isEmptyField() -> Bool{
        let trimmedString = self.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmedString!.isEmpty
    }
}


extension String {
    func isValidEmail()->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var first: String {
        return String(characters.prefix(1))
    }
    
    var last: String {
        return String(characters.suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
