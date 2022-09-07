//
//  RequestServer.swift
//  whosupdev
//
//  Created by Sophie Romanet on 14/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class RequestServer: NSObject {

    static let sharedInstance = RequestServer()

    
    //Update USer
    
    func UpdateUser(completionHandler: @escaping (_ json: JSON) -> Void) {

        let params = ["_id":User.sharedInstance.get_id(), "longitude": "5.694778", "latitude":"45.125028"] as [String : Any]
        Alamofire.request("http://82.236.159.23:8080/connectedUsers/updateUser", method: .put, parameters: params).responseJSON ( completionHandler: { response in

            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(data: response.data!)
                completionHandler(swiftyJsonVar)
                //print("This is the checkin response:\(swiftyJsonVar)")
            }
            })
 
    }
    

    //Recupère la whitelist
    
   
    func GetWhiteListe (completionHandler: @escaping (_ json: JSON) -> Void) {
        
        let params = ["_id": User.sharedInstance.get_id()]
        Alamofire.request("http://82.236.159.23:8080/connectedUsers/getWhiteList", method: .get, parameters: params).responseJSON ( completionHandler: { response in
            
            
            switch response.result {
            case .success:
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 201:
                        
                        break
                    case 200:
                        print ("Ok 200")
                        _ = JSON(data: response.data!)
                        // print(json)
                        
                        if((response.result.value) != nil) {
                            let swiftyJsonVar = JSON(data: response.data!)
                            completionHandler(swiftyJsonVar)
                            //print("This is the checkin response:\(swiftyJsonVar)")
                        }
                        
                        break
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 400:
                        print("ERREUR FONCTIONNELLE.")
                        break
                    case 409:
                        print ("Exception")
                        
                        break
                    default:
                        break
                    }
                    
                    
                }
                
                break
                
                
            }
            
            
        })
        
    }

    
    // GetOnstant RequestServer.sharedInstance.GetWhiteListe() { (json) in
    
    
    
    func GetInstant(completionHandler: @escaping (_ json: JSON) -> Void) {
        
        
       let realm = try! Realm()
        let myuserwhiteliste = realm.objects(WhiteList.self)
        
        
        var mywhitelistId = [String]()
        //let requests = myuserwhiteliste.toArray()
   
     
        for WhiteListone in myuserwhiteliste {
        
            mywhitelistId.append(WhiteListone._id)
        }
        
        //print(mywhitelist)
        let params = ["_id": User.sharedInstance.get_id(), "whiteList": mywhitelistId] as [String : Any]
        //print(params)
      Alamofire.request("URLserver".localized+"/instants/getInstant", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON ( completionHandler: { response in
        
 
            switch response.result {
            case .success:
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 201:
                        
                        break
                    case 200:
                        print ("Ok 200")
                       
                        if((response.result.value) != nil) {
                            let json = JSON(data: response.data!)
                            completionHandler(json)
                            
                            let realm = try! Realm()
                            
                            let listes = realm.objects(Instant.self)
                           
                            try! realm.write ({
                                realm.delete(listes)
                      
                            })
                            
                            var mymemberlist = [WhiteList]()
                            print("/************************************** get instesnnnnt ***************/")
                            print(json)
                        
                            if (json.count != 0) {
                                do{
                                
                                    for index in 0...json.count-1 {
                                
                                        let myInstantList = Instant()
                                        
                                       myInstantList.hashtag = json[index]["hashtag"].stringValue
                                        myInstantList._id = json[index]["_id"].stringValue
                                        myInstantList.picture = json[index]["picture"].stringValue
                                        myInstantList.mood = json[index]["mood"].stringValue
                                        
                                        myInstantList.i_id = myInstantList.incrementPK()
                                        //myWhiteListe.moods =  as! [String]
                                        if (json[index]["members"].array?.count != 0) {
                                            
                                           
                                            
                                           // for i in 0...(json[index]["members"].array?.count)! - 1{
                                            for membersList in (json[index]["members"].array)! {
                              
                                                    let permissions = PermissionMembers()
                                                    permissions._id = membersList["_id"].stringValue
                                                    permissions.name = membersList["name"].stringValue
                                                    myInstantList.members.append(permissions)
                        
                                            } // fin for
                                
  
                                        }
                                        
                                        try realm.write {
                                            
                                            realm.add(myInstantList,update: true)
                                            
                                        }
                                        
                                    }
                                    
                                  
                                }
                                catch {
                                    print("Error creating the database")
                                }
                                ///fin do
                            }//json.count != 0
                            
                            
                        }
                        
                        break
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 400:
                        print("ERREUR FONCTIONNELLE.")
                        break
                    case 409:
                        print ("Exception")
                        
                        break
                    default:
                        break
                    }
                    
                    
                }
                
                break
                
                
            }
            
            
        })
    
  
    
    }
    
    
    
    
    
    
    
    
    //Récupère les utilisateurs autour de soi à modifier car latitude et longitude en duuuuuure !!!!!
    
    func GetUserSample (completionHandler: @escaping (_ json: JSON) -> Void) {
        
     
       /* Alamofire.request("http://82.236.159.23:8080/connectedUsers/getUserSample", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON ( completionHandler: { response in
           
        switch response.result {
            case .success:
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 201:
                     
                        break
                    case 200:
                        print ("Ok 200")
                        let json = JSON(data: response.data!)
                     // print(json)
                        
                        if((response.result.value) != nil) {
                            let swiftyJsonVar = JSON(data: response.data!)
                            completionHandler(swiftyJsonVar)
                            //print("This is the checkin response:\(swiftyJsonVar)")
                        }
                        
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
                       break
                    case 409:
                        print ("Exception")
                    
                        break
                    default:
                        break
                    }
                    
                    
                }
                
                break
                
            }

           
        })*/
        
    }
    
    ///connectedUsers/moodUsers
    
    func GetmoodUsers (_id: String, _mood: String, whiteList: [String], completionHandler: @escaping (_ json: JSON) -> Void) {
        
        let params = ["_id":_id,"mood": _mood, "whiteList": whiteList] as [String : Any]
        print(params)
        
        
        Alamofire.request("http://82.236.159.23:8080/connectedUsers/moodUsers", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON ( completionHandler: { response in
            
            switch response.result {
            case .success:
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 201:
                        
                        break
                    case 200:
                        print ("Ok 200")
                        
                        if((response.result.value) != nil) {
                            let swiftyJsonVar = JSON(data: response.data!)
                            completionHandler(swiftyJsonVar)
                            //print("This is the checkin response:\(swiftyJsonVar)")
                        }
                        
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
                        print(error)
                        print("ERREUR FONCTIONNELLE.")
                        break
                    case 409:
                        print ("Exception")
                        
                        break
                    default:
                        break
                    }
                    
                    
                }
                
                break
                
            }
            
            
        })
        
        
    }

    //récupère les URLS photos de la whiteList
    
    func GetmoodPreview (whiteList: [String], completionHandler: @escaping (_ json: JSON) -> Void) {
        
        let params = ["whiteList": whiteList] as [String : [String]]
       // print(params)
        
    
        Alamofire.request("http://82.236.159.23:8080/connectedUsers/moodPreview", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON ( completionHandler: { response in
            
            switch response.result {
            case .success:
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 201:
                        
                        break
                    case 200:
                        print ("Ok 200")
                        
                        if((response.result.value) != nil) {
                            let swiftyJsonVar = JSON(data: response.data!)
                            completionHandler(swiftyJsonVar)
                            //print("This is the checkin response:\(swiftyJsonVar)")
                        }
                        
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
                        print(error)
                        print("ERREUR FONCTIONNELLE.")
                        break
                    case 409:
                        print ("Exception")
                        
                        break
                    default:
                        break
                    }
                    
                    
                }
                
                break
                
            }
            
            
        })
      
        
    }
    
    

    
    
    //Télécharge les images dans le cache du téléphone pour animation de la home
    
    func SaveImg (urlimg: String, nameimage: String, colorimg:String, completionHandler: @escaping (_ json: JSON) -> Void) {
        Alamofire.request("http://82.236.159.23:8080\(urlimg)").responseImage { response in
    
        if let image = response.result.value {
        
      let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameimage)
        //let image = UIImage(named: "apple.jpg")
            
            
        UserDefaults.standard.setValue(colorimg, forKey: nameimage)
    
        let imageData = UIImagePNGRepresentation(image)!
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
            
            
       /*     if(nameimage == "largepicture"){
                
                User.sharedInstance.setsmallPhoto(_urlphoto: swiftyJsonVar["smallPhoto"].stringValue)
                
            }
            else if (nameimage == "smallpicture"){
                
                
            }else if (nameimage == "mediumpicture"){
                
                User.sharedInstance.setmediumPhoto(_urlphoto: swiftyJsonVar["mediumPhoto"].stringValue)
                User.sharedInstance.setlargePhoto(_urlphoto: s)
                
                
            }*/
            
    
            }
        }
    }


    //Télécharge l'upload d'image
    
    func UploadImg (urlimg: String, nameimage: String, colorimg:String, completionHandler: @escaping (_ json: JSON) -> Void) {
        
       }

    

}
