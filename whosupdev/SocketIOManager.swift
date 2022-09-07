//
//  SocketIOManager.swift
//  whosupdev
//
//  Created by Sophie Romanet on 03/07/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import SocketIO
import RealmSwift
import SwiftyJSON

class SocketIOManager: NSObject {

    
    static let sharedInstance = SocketIOManager()
   var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://82.236.159.23:8080")! as URL,config: [.connectParams(["_id": User.sharedInstance.get_id()])])
    var realm = try! Realm()
   // var socket = SocketIOClient(socketURL: URL(string: "http://82.236.159.23:8080")!, config: [.log(true), .forcePolling(true)])
    
    
    override init() {
        super.init()
    }

    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func MAJListeMoods() {
    
        
        self.socket.on("whiteList") { data, ack in
           // NSAssertionHandler(data[0] as? Dictionary<String,Any>)
        }
    
    
    }
    
    
    
    
    
    func GetupdateConnectedUser (moodsActivate: String, hachtagCreate: String) {
        
        let realm = try! Realm()
        let myuserwhiteliste = realm.objects(WhiteList.self)
        var mywhitelistId = [String]()
        for WhiteListone in myuserwhiteliste {
            
            mywhitelistId.append(WhiteListone._id)
        }
        
        let arraymoods = realm.objects(Moods.self).filter("statut ==  %@", "activate")
        print(arraymoods)
        
        
        let dict = ["_id": User.sharedInstance.get_id(),"moods":moodsActivate,"hashtags":hachtagCreate,"whiteList":mywhitelistId,"position": ["latitude": Float(User.sharedInstance.getLatitude()),"longitude": Float(User.sharedInstance.getLongitude())]] as [String : Any]
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            self.socket.emit("updateConnectedUser", decoded as! SocketData)
            
        } catch {
            print(error.localizedDescription)
        }
    
        
    }
    
    func connectToServerGetWhitelist(dict: [String : Any], completionHandler:  @escaping (_ whiteList:  Dictionary<String,Any>?) -> Void) {
        do {
        
         
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            self.socket.emit("initPosition", decoded as! SocketData)
            
        } catch {
            print(error.localizedDescription)
        }
        
        self.socket.on("whiteList") { data, ack in
            
      
            completionHandler(data[0] as? Dictionary<String,Any>)
        }
        
     
    }
    
    
    
    
    func MoodOver (completionHandler:  @escaping (_ mood:  [String]?) -> Void) {
        
        do {
            
            let dict = ["_id": User.sharedInstance.get_id(), "mood": UserManager.sharedInstance.getMoodsSelects()]
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            self.socket.emit("moodOver", decoded as! SocketData)
            
        } catch {
            print(error.localizedDescription)
        }
        self.socket.on("moodOk") { data, ack in
            completionHandler(data[0] as? [String])
        }
        
        
    }
    
    
    
    func RemovedUserPreview (completionHandler:  @escaping (_ idUserMoodremoved: [String:String]?) -> Void) {
        
        self.socket.on("removedUserPreview") { data, ack in
            
            print("utilisateur remove mood")
            print(data[0])
            completionHandler(data[0] as? [String:String])
            
            
        }
        
        
    }
    
    
    //socket à garder
    
    func getuserMatched () {
        
           self.socket.on("userMatched") { data, ack in
            
            print("sooocket musermfljdsqkl")
               print(data)
            if (data.count != 0) {
                 let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController : HightFiveTemporaireViewController = storyboard.instantiateViewController(withIdentifier: "HightFiveTemporaireViewController") as! HightFiveTemporaireViewController
               UserManager.sharedInstance.mainNavigationController.present(viewController, animated: true)
            //hightFiveTemporaireViewController
            
            }
            
         
            
        }
        
    
    
    }
    
   
    //socket à garder
    
    func GetinstantJoined (instantid: String)
    {
        
        let realm = try! Realm()
        let myuserwhiteliste = realm.objects(WhiteList.self)     
        var mywhitelistId = [String]()
        for WhiteListone in myuserwhiteliste {
            
            mywhitelistId.append(WhiteListone._id)
        }
    
        do {
            
            let dict = ["_id": User.sharedInstance.get_id(), "instantId": instantid, "whiteList": mywhitelistId] as [String : Any]
            print(dict)
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            self.socket.emit("instantJoined", decoded as! SocketData)
            
        } catch {
            print(error.localizedDescription)
        }
        
    
    }
   
   //socket gardé
    
    func GetMajInstant (completionHandler:  @escaping (_ instantmaj: Dictionary<String, AnyObject>?) -> Void) {
    
      self.socket.on("majInstant") { data, ack in
     
        let instantupadate = data[0] as? Dictionary<String, AnyObject>
        completionHandler(data[0] as? Dictionary<String, AnyObject>)
        print("/******************************** GETMAJINSTANT **************************/")
        print(instantupadate!)
        

      do{
            // update instant
            let instantarray = self.realm.objects(Instant.self).filter("_id == %@", instantupadate!["_id"]!).first
            
            if (instantarray != nil)
            {
                
                try self.realm.write {
                instantarray?.hashtag = instantupadate?["hashtag"]! as! String
                instantarray?._id = instantupadate?["_id"]! as! String
                instantarray?.picture = instantupadate?["picture"]! as! String
                instantarray?.mood = instantupadate?["mood"]! as! String
                let myarraymembers = instantupadate?["members"]!
                  
                    if (myarraymembers?.count != 0) {
                        let arrayname = instantupadate?["members"]!.value(forKey: "name")! as! [String]
                        let arrayId = instantupadate?["members"]!.value(forKey: "_id")! as! [String]
                        // for i in 0...(json[index]["members"].array?.count)! - 1{
                        for i in 0...(arrayname.count) - 1{
                            let permissions = PermissionMembers()
                            permissions._id = arrayId[i]
                            permissions.name = arrayname[i]
                            instantarray?.members.append(permissions)
                            
                        } // fin for

                    }
                }
            }//fin if nil
        
        else {
            // add instant
                let myInstantList = Instant()
                myInstantList.hashtag = instantupadate?["hashtag"]! as! String
                myInstantList._id = instantupadate?["_id"]! as! String
                myInstantList.picture = instantupadate?["picture"]! as! String
                myInstantList.mood = instantupadate?["mood"]! as! String
                
                myInstantList.i_id = myInstantList.incrementPK()
                let myarraymembers = instantupadate?["members"]!
                if (myarraymembers?.count != 0) {
                    
                    let arrayname = instantupadate?["members"]!.value(forKey: "name")! as! [String]
                    let arrayId = instantupadate?["members"]!.value(forKey: "_id")! as! [String]
                    for i in 0...(arrayname.count) - 1{
                      let permissions = PermissionMembers()
                        permissions._id = arrayId[i]
                        permissions.name = arrayname[i]
                        myInstantList.members.append(permissions)
                    } // fin for
                    
                }
                try self.realm.write {
                    self.realm.add(myInstantList, update: true)
                }
            }
        }//fin do
        catch {
            print("Error creating the database")
        }
   
        }//finsocket
    
    }

// socket gardé
    func getmajConnectedUser(viewcollection : UICollectionView) {
    
    
        self.socket.on("majConnectedUser") { data, ack in
            let whiteList = data[0] as? Dictionary<String,Any>
            let myuserwhiteliste = self.realm.objects(WhiteList.self).filter("_id == %@", whiteList!["_id"]!).first
            do{
                if (myuserwhiteliste != nil)
                {
                    try self.realm.write {
                        myuserwhiteliste?.gender = whiteList!["gender"]! as! String
                        myuserwhiteliste?._id = whiteList!["_id"]! as! String
                        myuserwhiteliste?.name = whiteList!["name"]! as! String
                        myuserwhiteliste?.age = String(describing: whiteList!["age"])
                        myuserwhiteliste?.emojis = whiteList!["emojis"]! as! String
                        myuserwhiteliste?.largePhoto = whiteList!["largePhoto"] as! String
                        myuserwhiteliste?.mediumPhoto = whiteList!["mediumPhoto"] as! String
                        myuserwhiteliste?.smallPhoto = whiteList!["smallPhoto"] as! String
                        myuserwhiteliste?.latitude = String(describing: whiteList!["latitude"])
                        myuserwhiteliste?.longitude = String(describing: whiteList!["longitude"])
                        let myarraymoods = whiteList!["moods"] as! [String]
                        myuserwhiteliste?.moods.removeAll()
                        
                        if (myarraymoods.count != 0) {
                            
                            for i in 0...myarraymoods.count - 1{
                                let mystringvalue = RealmString()
                                mystringvalue.stringValue = myarraymoods[i]
                                myuserwhiteliste?.moods.append(mystringvalue.stringValue)
                            }
                        }
                        
                        let myarrayhach = whiteList!["hashtags"] as! [String : String]
                        myuserwhiteliste?.hashtagsV.removeAll()
                        
                        if (myarrayhach.count != 0) {

                            if(myarrayhach["CHILL"] != nil) {
                                let mystringvalue = Hachtags()
                                mystringvalue.moods = "CHILL"
                                mystringvalue.stringHach = myarrayhach["CHILL"]!
                                myuserwhiteliste?.hashtagsV.append(mystringvalue)
                            }
                           if(myarrayhach["SOIREE"] != nil) {
                                let mystringvalue1 = Hachtags()
                                mystringvalue1.moods = "SOIREE"
                                mystringvalue1.stringHach = myarrayhach["SOIREE"]!
                                myuserwhiteliste?.hashtagsV.append(mystringvalue1)
                            }
                            if(myarrayhach["GAME"] != nil) {
                                let mystringvalue2 = Hachtags()
                                mystringvalue2.moods = "GAME"
                                mystringvalue2.stringHach = myarrayhach["GAME"]!
                                myuserwhiteliste?.hashtagsV.append(mystringvalue2)
                            }
                            if(myarrayhach["FOOD"] != nil) {
                               let mystringvalue3 = Hachtags()
                                mystringvalue3.moods = "FOOD"
                                mystringvalue3.stringHach = myarrayhach["FOOD"]!
                                myuserwhiteliste?.hashtagsV.append(mystringvalue3)
                            }
                            
                            if(myarrayhach["OTHER"] != nil) {
                                let mystringvalue4 = Hachtags()
                                mystringvalue4.moods = "OTHER"
                                mystringvalue4.stringHach = myarrayhach["OTHER"]!
                                myuserwhiteliste?.hashtagsV.append(mystringvalue4)
                            }
                            
                            if(myarrayhach["SPORT"] != nil) {
                                let mystringvalue5 = Hachtags()
                                mystringvalue5.moods = "SPORT"
                                mystringvalue5.stringHach = myarrayhach["SPORT"]!
                                myuserwhiteliste?.hashtagsV.append(mystringvalue5)
                                
                            }
                        }
                    }
                }
                else {
                   let myuserwhiteliste = WhiteList()
                    myuserwhiteliste.gender = whiteList!["gender"]! as! String
                    myuserwhiteliste._id = whiteList!["_id"]! as! String
                    myuserwhiteliste.name = whiteList!["name"]! as! String
                    myuserwhiteliste.age = String(describing: whiteList!["age"])
                    myuserwhiteliste.emojis = whiteList!["emojis"]! as! String
                    myuserwhiteliste.largePhoto = whiteList!["largePhoto"] as! String
                    myuserwhiteliste.mediumPhoto = whiteList!["mediumPhoto"] as! String
                    myuserwhiteliste.smallPhoto = whiteList!["smallPhoto"] as! String
                    myuserwhiteliste.latitude = String(describing: whiteList!["latitude"])
                    myuserwhiteliste.longitude = String(describing: whiteList!["longitude"])
                    let myarraymoods = whiteList!["moods"] as! [String]
                    
                    if (myarraymoods.count != 0) {
                        
                        for i in 0...myarraymoods.count - 1{
                            let mystringvalue = RealmString()
                            mystringvalue.stringValue = myarraymoods[i]
                            myuserwhiteliste.moods.append(mystringvalue.stringValue)
                        }
                    }
                    let myarrayhach = whiteList!["hashtags"] as! [String : String]
                    myuserwhiteliste.hashtagsV.removeAll()
                    
                    if (myarrayhach.count != 0) {
                        if(myarrayhach["CHILL"] != nil) {
                            let mystringvalue = Hachtags()
                            mystringvalue.moods = "CHILL"
                            mystringvalue.stringHach = myarrayhach["CHILL"]!
                            myuserwhiteliste.hashtagsV.append(mystringvalue)
                        }
                        if(myarrayhach["SOIREE"] != nil) {
                            let mystringvalue1 = Hachtags()
                            mystringvalue1.moods = "SOIREE"
                            mystringvalue1.stringHach = myarrayhach["SOIREE"]!
                            myuserwhiteliste.hashtagsV.append(mystringvalue1)
                        }
                        if(myarrayhach["GAME"] != nil) {
                            let mystringvalue2 = Hachtags()
                            mystringvalue2.moods = "GAME"
                            mystringvalue2.stringHach = myarrayhach["GAME"]!
                            myuserwhiteliste.hashtagsV.append(mystringvalue2)
                        }
                        if(myarrayhach["FOOD"] != nil) {
                            let mystringvalue3 = Hachtags()
                            mystringvalue3.moods = "FOOD"
                            mystringvalue3.stringHach = myarrayhach["FOOD"]!
                            myuserwhiteliste.hashtagsV.append(mystringvalue3)
                       }
                        if(myarrayhach["OTHER"] != nil) {
                            let mystringvalue4 = Hachtags()
                            mystringvalue4.moods = "OTHER"
                            mystringvalue4.stringHach = myarrayhach["OTHER"]!
                            myuserwhiteliste.hashtagsV.append(mystringvalue4)
                        }
                        if(myarrayhach["SPORT"] != nil) {
                            let mystringvalue5 = Hachtags()
                            mystringvalue5.moods = "SPORT"
                            mystringvalue5.stringHach = myarrayhach["SPORT"]!
                            myuserwhiteliste.hashtagsV.append(mystringvalue5)
                        }
                    }
                    try self.realm.write {
                        self.realm.add(myuserwhiteliste,update: true)
          
                    }
                    
                }
            }
            catch {
                print("Error creating the database")
            }
                viewcollection.reloadData()
            
        }
    }
    
    func UserPreview (completionHandler:  @escaping (_ idUserMoodActivate: [String:String]?) -> Void) {
        
        self.socket.on("userPreview") { data, ack in

            print("nouvel utilisateur active mood")
            print(data[0])
            completionHandler(data[0] as? [String:String])
           
           
        }
        
        
    }
    
    func MoodChange (completionHandler:  @escaping (_ mood:  [String]?) -> Void) {
       
        do {
          
            let dict = ["_id": User.sharedInstance.get_id(), "mood": UserManager.sharedInstance.getMoodsSelects()]
             print(dict)
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            self.socket.emit("moodChanged", decoded as! SocketData)
            
        } catch {
            print(error.localizedDescription)
        }
        self.socket.on("moodOk") { data, ack in
            completionHandler(data[0] as? [String])
        }
        
        
    }
    
    
    func PublicMatch (completionHandler:  @escaping (_ mood:  [String]?) -> Void) {
    
    do {
    
        let dict = ["_id": User.sharedInstance.get_id(), "mood": UserManager.sharedInstance.getMoodsSelects(), "whiteList": UserManager.sharedInstance.getWhiteList()] as [String : Any]
        print(dict)
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
        self.socket.emit("publicMatch", decoded as! SocketData)
    
    } catch {
    print(error.localizedDescription)
    }
     
    
    }

    
    
    
}
