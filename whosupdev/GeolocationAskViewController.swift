//
//  GeolocationAskViewController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 09/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import Alamofire

class GeolocationAskViewController: UIViewController {

    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var LblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ConfirmLocalisation()
        locManager.requestWhenInUseAuthorization()
        //Codepopup()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //function
    
   
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        
        if identifier == "SegueValidate" {
       
            print("seguevalidate")
            
              
                    
                 
                    
                  

                    
               /* let params = ["_id":User.sharedInstance.get_id(), "longitude": User.sharedInstance.getLongitude(), "latitude":User.sharedInstance.getLatitude()] as [String : Any]
                Alamofire.request("http://82.236.159.23:8080/connectedUsers/updateUser", method: .put, parameters: params).responseJSON { response in
                    
                    
                    switch response.result {
                    case .success:
                        
                        if let httpStatusCode = response.response?.statusCode {
                            switch(httpStatusCode) {
                            case 201:
                                let json = JSON(data: response.data!)
                                print(json)
                              
                                
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
                        
                    case .failure(let error):
                        
                        if let httpStatusCode = response.response?.statusCode {
                            switch(httpStatusCode) {
                            case 400:
                                print("ERREUR FONCTIONNELLE.")
                                AlertManager.sharedInstance.DoubleMessage(_message: "Erreur pendant l'envoie des coordonnées \(error)", _title: "Code", _controller: self)
                                
                                break
                            case 409:
                                print ("Exception")
                                AlertManager.sharedInstance.DoubleMessage(_message: "Erreur pendant l'envoie des coordonnées \(error)", _title: "Code", _controller: self)
                                
                                break
                            default:
                                break
                            }
                            
                            
                        }
                        
                        break
                        
                    }*/
                    
            
             }
                
                return true
                
        
        
       
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
