//
//  ValidatePhoneViewController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 08/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ValidatePhoneViewController: UIViewController {
  
    var codeValidate = String()
    
    @IBOutlet weak var TxtFieldCode: UITextField!
    @IBOutlet weak var Lblnumero: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Lblnumero.text = User.sharedInstance.getTel()
        Codepopup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   //MARK: -IBACTION
    
    @IBAction func ActionValide(_ sender: Any) {
      
    }
    
    //MARK: function
    
    //...... temporaire
    func Codepopup() {
        print("codepupup")
        let MyUserInJson = ["user":["tel":User.sharedInstance.getTel(), "email":"", "facebookId":"", "name":User.sharedInstance.getNom(), "urlphoto":"", "gender":""]]
        print(MyUserInJson)
        
        Alamofire.request("http://82.236.159.23:8080/users/auth", method: .post, parameters: MyUserInJson, encoding: JSONEncoding.default).responseData { response in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                
                print("codepupup\(response.result.value)")
                switch response.result {
                case .success:
                    
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 201:
                          print(User.sharedInstance.toString())
                              print ("Ok 201")
                          //  self.performSegue(withIdentifier: identifier, sender: self)
                            break
                        case 200:
                            print ("Ok 200")
                         //   self.performSegue(withIdentifier: identifier, sender: self)
                            
                            break
                        default:
                            break
                        }
                    }
                    
                    break
                    
                case .failure( _):
                    
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 400:
                            print("ERREUR FONCTIONNELLE.")
                           // AlertManager.sharedInstance.DoubleMessage(_message: "Le code rentré n'est pas valide \(self.codeValidate)", _title: "Code", _controller: self)
                            
                            break
                        case 409:
                            print ("Exception")
                           // AlertManager.sharedInstance.DoubleMessage(_message: "Le code rentré n'est pas valide \(self.codeValidate)", _title: "Code", _controller: self)
                            
                            break
                        default:
                            break
                        }
                        
                        
                    }
                    
                    break
                    
                }

                self.codeValidate = utf8Text
                AlertManager.sharedInstance.SimpleMessage(_message: "Votre code est \(self.codeValidate) pour valider votre compte", _title: "Code", _controller: self)
                
                
            }
        }
  

    }
  
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            
        
            
            if identifier == "SegueCode" {
                
                if ((TxtFieldCode.text) == "") {
                    AlertManager.sharedInstance.SimpleMessage(_message: "Veuillez entrer un code valide", _title: "Code vide", _controller: self)
                    return false
                }
                else {
          
                    let params = ["telephone":User.sharedInstance.getTel(), "code": self.TxtFieldCode.text!] as [String : Any]
                    Alamofire.request("http://82.236.159.23:8080/users/checkCode", method: .get, parameters: params).responseJSON { response in
                        
    
                        switch response.result {
                        case .success:
                            
                            if let httpStatusCode = response.response?.statusCode {
                                switch(httpStatusCode) {
                                case 201:
                                   let json = JSON(data: response.data!)
                                    print(json)
                                    print(json["user"]["_id"])
                                    print(json["user"]["_id"].string!)
                                   User.sharedInstance.set_id(_id: json["user"]["_id"].string!)
                                   User.sharedInstance.setEmail(_email: json["user"]["email"].string!)
                                   User.sharedInstance.setUrlphoto(_urlphoto: json["user"]["urlphoto"].string!)
                                   User.sharedInstance.setFacebookid(_facebookid: json["user"]["facebookId"].string!)
                                   User.sharedInstance.setGender(_gender: json["user"]["gender"].string!)
                                   
                                   print(User.sharedInstance.toString())
                                  
                                   self.performSegue(withIdentifier: identifier, sender: self)
                                    break
                                case 200:
                                    print ("Ok 200")
                                    self.performSegue(withIdentifier: identifier, sender: self)
                                    
                                    break
                                default:
                                    break
                                }
                            }
                            
                            break
                            
                        case .failure( _):
                            
                            if let httpStatusCode = response.response?.statusCode {
                                switch(httpStatusCode) {
                                case 400:
                                    print("ERREUR FONCTIONNELLE.")
                                         AlertManager.sharedInstance.DoubleMessage(_message: "Le code rentré n'est pas valide \(self.codeValidate)", _title: "Code", _controller: self)
                       
                                    break
                                case 409:
                                    print ("Exception")
                                    AlertManager.sharedInstance.DoubleMessage(_message: "Le code rentré n'est pas valide \(self.codeValidate)", _title: "Code", _controller: self)
                                    
                                    break
                                default:
                                    break
                                }
                                
                                
                            }
                            
                            break
                            
                        }
                        
                    }
                    
                    
                    return false
                    
                }
            }
            
            return true
        }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
