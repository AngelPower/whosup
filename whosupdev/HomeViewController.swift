//
//  HomeViewController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 13/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//
import UIKit
import Lottie
import Alamofire
import AlamofireImage
import SwiftyJSON
import MapKit
import RealmSwift
import ObjectMapper



class HomeViewController: UIViewController {
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let vw = UIView()
    var window: UIWindow?
    var arrayNames: [String] = []
    var arrayMood: [String] = []
    var arraygender: [String] = []
    var arrayinstantCount: [String] = []
    var arrayemojis: [String] = []
    var arrayage: [String] = []
    var arraymediumPhoto: [String] = []
    var arraylongitude: [String] = []
    var array_id: [String] = []
    var arraylatitude: [String] = []
    var arraysmallPhoto: [String] = []
    var arraymoods = [[String]] ()
    var arrayhashtags = [[String]] ()
    var arrayname: [String] = []
    var arraylargePhoto: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            let sLatitude:String = String(format:"%f", currentLocation.coordinate.latitude)
            let sLongitude:String = String(format:"%f", currentLocation.coordinate.longitude)
            print(sLatitude)
            print(sLongitude)
        }
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        
        // User.sharedInstance.setLatitude(_latitude: sLatitude)
        //User.sharedInstance.setLongitude(_longitude: sLongitude)
        /*User.sharedInstance.setLatitude(_latitude: "45.125028")
        User.sharedInstance.setLongitude(_longitude: "5.694778")*/
        
        User.sharedInstance.setLatitude(_latitude: "45.2237793")
        User.sharedInstance.setLongitude(_longitude: "5.8184821")
        
        User.sharedInstance.setDevice(_device: deviceID)
        
        print(User.sharedInstance.getLatitude())
        
        
        
        let MyUserInJson = ["user":["tel":User.sharedInstance.getTel(), "email":User.sharedInstance.getEmail(), "facebookId":User.sharedInstance.getFacebookid(), "name":User.sharedInstance.getNom(), "gender":User.sharedInstance.getNom()],"position": ["latitude": Float(User.sharedInstance.getLatitude()),"longitude": Float(User.sharedInstance.getLongitude())], "deviceId": User.sharedInstance.getDevice()] as [String : Any]
        
        
        print(MyUserInJson)
        
        Alamofire.request("http://82.236.159.23:8080/users/auth", method: .post, parameters: MyUserInJson, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                print(response.result)
                /* User.sharedInstance.set_id(_id: json["user"]["_id"].string!)
                 User.sharedInstance.setEmail(_email: json["user"]["email"].string!)
                 User.sharedInstance.setUrlphoto(_urlphoto: json["user"]["urlphoto"].string!)
                 User.sharedInstance.setFacebookid(_facebookid: json["user"]["facebookId"].string!)
                 //User.sharedInstance.setGender(_gender: json["user"]["gender"].string!)
                 User.sharedInstance.setNom(_nom: responseDictionary["name"]! as! String)
                 //print(User.sharedInstance.toString())*/
                switch response.result {
                case .success:
                    
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 201:
                            print ("Ok 201")
                            let json = JSON(data: response.data!)
                            print(json)
                            
                            break
                        case 200:
                            print ("Ok 200")
                            let json = JSON(data: response.data!)
                            User.sharedInstance.set_id(_id: json["user"]["_id"].string!)
                            
                            
                            SocketIOManager.sharedInstance.establishConnection()
                            
                            
                            let realm = try! Realm()
                            
                            let listes = realm.objects(WhiteList.self)
                            let stringrealm = realm.objects(RealmString.self)
                            let stringrealm1 = realm.objects(Hachtags.self)
                            
                            try! realm.write ({
                                realm.delete(listes)
                                realm.delete(stringrealm)
                                realm.delete(stringrealm1)
                            })
                            
                            RequestServer.sharedInstance.GetWhiteListe() { (json) in
                                
                                
                                self.arrayNames = json.arrayValue.map({$0["smallPhoto"].stringValue})
                                self.arrayMood = json.arrayValue.map({$0["moods"][0].stringValue})
                                
                                
                            print("/**************************WHITELIST ***************/")
                                
                              //print(json.count)
                              // print(json)
                                
                                if (json.count != 0) {
                                    
                                    for index in 0...json.count-1 {
                                        
                                        
                                        do{
                                            
                                            
                                            let myWhiteListe = WhiteList()
                                            
                                            
                                            myWhiteListe.gender = json[index]["gender"].stringValue
                                            myWhiteListe._id = json[index]["_id"].stringValue
                                            myWhiteListe.age = json[index]["age"].stringValue
                                            myWhiteListe.name = json[index]["name"].stringValue
                                            myWhiteListe.emojis = json[index]["emojis"].stringValue
                                            myWhiteListe.instantCount = json[index]["instantCount"].stringValue
                                            myWhiteListe.largePhoto = json[index]["largePhoto"].stringValue
                                            myWhiteListe.mediumPhoto = json[index]["mediumPhoto"].stringValue
                                            myWhiteListe.smallPhoto = json[index]["smallPhoto"].stringValue
                                            myWhiteListe.latitude = json[index]["latitude"].stringValue
                                            myWhiteListe.longitude = json[index]["longitude"].stringValue
                                            myWhiteListe.w_id = myWhiteListe.incrementPK()
                                            
                                            //myWhiteListe.moods =  as! [String]
                                            if (json[index]["moods"].array?.count != 0) {
                                                for i in 0...(json[index]["moods"].array?.count)! - 1{
                                                    let mystringvalue = RealmString()
                                                    mystringvalue.stringValue = json[index]["moods"][i].stringValue
                                                    myWhiteListe.moods.append(mystringvalue.stringValue)
                                                }
                                            }
                                            
                                            
                                            if (json[index]["hashtags"].count != 0) {
                                                
                                                if(json[0]["hashtags"]["CHILL"] != "") {
                                                    let mystringvalue = Hachtags()
                                                    mystringvalue.moods = "CHILL"
                                                    mystringvalue.stringHach = json[0]["hashtags"]["CHILL"].stringValue
                                                    //mystringvalue.h_id = mystringvalue.incrementPK()
                                                    
                                                    myWhiteListe.hashtagsV.append(mystringvalue)
                                                    
                                                    
                                                }
                                                
                                                
                                                if(json[0]["hashtags"]["SOIREE"] != "") {
                                                    let mystringvalue1 = Hachtags()
                                                    mystringvalue1.moods = "SOIREE"
                                                    mystringvalue1.stringHach = json[0]["hashtags"]["SOIREE"].stringValue
                                                    //mystringvalue1.h_id = mystringvalue1.incrementPK()
                                                    
                                                    myWhiteListe.hashtagsV.append(mystringvalue1)
                                                    
                                                    
                                                }
                                                if(json[0]["hashtags"]["GAME"] != "") {
                                                    let mystringvalue2 = Hachtags()
                                                    mystringvalue2.moods = "GAME"
                                                    mystringvalue2.stringHach = json[0]["hashtags"]["GAME"].stringValue
                                                    //mystringvalue2.h_id = mystringvalue2.incrementPK()
                                                    
                                                    myWhiteListe.hashtagsV.append(mystringvalue2)
                                                    
                                                    
                                                }
                                                
                                                
                                                if(json[0]["hashtags"]["FOOD"] != "") {
                                                    
                                                    let mystringvalue3 = Hachtags()
                                                    mystringvalue3.moods = "FOOD"
                                                    
                                                    mystringvalue3.stringHach = json[0]["hashtags"]["FOOD"].stringValue
                                                    // mystringvalue3.h_id = mystringvalue3.incrementPK()
                                                    
                                                    myWhiteListe.hashtagsV.append(mystringvalue3)
                                                    
                                                    
                                                }
                                                
                                                if(json[0]["hashtags"]["OTHER"] != "") {
                                                    let mystringvalue4 = Hachtags()
                                                    mystringvalue4.moods = "OTHER"
                                                    mystringvalue4.stringHach = json[0]["hashtags"]["OTHER"].stringValue
                                                    // mystringvalue4.h_id = mystringvalue4.incrementPK()
                                                    
                                                    myWhiteListe.hashtagsV.append(mystringvalue4)
                                                    
                                                    
                                                }
                                                
                                                if(json[0]["hashtags"]["SPORT"] != "") {
                                                    let mystringvalue5 = Hachtags()
                                                    mystringvalue5.moods = "SPORT"
                                                    mystringvalue5.stringHach = json[0]["hashtags"]["SPORT"].stringValue
                                                    // mystringvalue5.h_id = mystringvalue5.incrementPK()
                                                    
                                                    myWhiteListe.hashtagsV.append(mystringvalue5)
                                                    
                                                    
                                                }
                                                
                                            }
                                            // fin if hashtags.count
                                            
                                            try realm.write {
                                                realm.add(myWhiteListe,update: true)
                                                
                                            }
                                        }
                                            
                                        catch {
                                            print("Error creating the database")
                                        }
                                        ///fin do
                                        
                                        
                                    } // fin for
                                    
                                    
                                    
                                    //// Debut Upload
                                    print(User.sharedInstance.getUrlphoto())
                                    
                                    if (User.sharedInstance.getfirstconnection() == "yes"){
                                        let parameters = ["_id" :User.sharedInstance.get_id()]
                                        
                                        
                                        
                                        //récuperer la photo de facebook dans le cache de bonne qualité
                                        let fm = FileManager.default
                                        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                        let myurl = docsurl.appendingPathComponent("img_0")
                                        
                                        var myUrlString = myurl.absoluteString
                                        
                                        myUrlString = myUrlString.replacingOccurrences(of: "file://", with: "")
                                        let image =  UIImage(contentsOfFile: myUrlString)
                                        
                                        //fin récuperation
                                        
                                        let URL = try! URLRequest(url: "http://82.236.159.23:8080/profilePicture/uploadPicture", method: .post)
                                        
                                        //upload de la photo de facebook et sauvegarde des url medium small et large
                                        Alamofire.upload(multipartFormData: { multipartFormData in
                                            
                                            for (key, value) in parameters {
                                                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                                            }
                                            
                                            multipartFormData.append(UIImagePNGRepresentation(image!)!, withName: "img", fileName: "picture.png", mimeType: "image/png")
                                            
                                            
                                        }, with: URL, encodingCompletion: {
                                            encodingResult in
                                            switch encodingResult {
                                            case .success(let upload, _, _):
                                                upload.responseJSON { response in
                                                    debugPrint("SUCCESS RESPONSE: \(response)")
                                                    let swiftyJsonVar = JSON(data: response.data!)
                                                    print(swiftyJsonVar["largePhoto"].stringValue)
                                                    
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                                        RequestServer.sharedInstance.SaveImg(urlimg:swiftyJsonVar["largePhoto"].stringValue,nameimage: "largepicture", colorimg: "") { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:swiftyJsonVar["smallPhoto"].stringValue ,nameimage: "smallpicture", colorimg: "") { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:swiftyJsonVar["mediumPhoto"].stringValue ,nameimage: "img_0", colorimg: "") { (json) in}
                                                        
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[1] ,nameimage: "img_2", colorimg: self.arrayMood[1]) { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[2] ,nameimage: "img_3", colorimg: self.arrayMood[2]) { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[3] ,nameimage: "img_4", colorimg: self.arrayMood[3]) { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[4] ,nameimage: "img_6", colorimg: self.arrayMood[4]) { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[5], nameimage: "img_7", colorimg: self.arrayMood[5]) { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[6] ,nameimage: "img_8", colorimg: self.arrayMood[6]) { (json) in}
                                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[7] ,nameimage: "img_9", colorimg: self.arrayMood[7]) { (json) in}
                                                        
                                                          RequestServer.sharedInstance.GetInstant() { (json) in}
                                                        
                                                        let animationView = LOTAnimationView(name: "splash.json")
                                                        
                                                        animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                                        animationView.contentMode = .scaleAspectFill
                                                        
                                                        animationView.loopAnimation = true
                                                        // animationView?.layer = "Group 30.png"
                                                        self.view.addSubview(animationView)
                                                        animationView.play()
                                                        
                                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                                                            animationView.pause()
                                                            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "InstantsLio", bundle: nil)
                                                            let initialViewControlleripad : InstantsLioViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "InstantsLioViewController") as! InstantsLioViewController
                                                            UserManager.sharedInstance.mainNavigationController.pushViewController(initialViewControlleripad, animated: true)
                                                            
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    
                                                }
                                            case .failure(let encodingError):
                                                // hide progressbas here
                                                print("ERROR RESPONSE: \(encodingError)")
                                            }
                                        })
                                        
                                        
                                        
                                        
                                    }
                                    else {
                                        
                                        RequestServer.sharedInstance.SaveImg(urlimg:"",nameimage: "img_0", colorimg: self.arrayMood[0]) { (json) in}
                                        
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[1] ,nameimage: "img_2", colorimg: self.arrayMood[1]) { (json) in}
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[2] ,nameimage: "img_3", colorimg: self.arrayMood[2]) { (json) in}
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[3] ,nameimage: "img_4", colorimg: self.arrayMood[3]) { (json) in}
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[4] ,nameimage: "img_6", colorimg: self.arrayMood[4]) { (json) in}
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[5], nameimage: "img_7", colorimg: self.arrayMood[5]) { (json) in}
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[6] ,nameimage: "img_8", colorimg: self.arrayMood[6]) { (json) in}
                                        RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[7] ,nameimage: "img_9", colorimg: self.arrayMood[7]) { (json) in}
                                        
                                        
                                        RequestServer.sharedInstance.GetInstant() { (json) in}
                                        let animationView = LOTAnimationView(name: "splash.json")
                                        
                                        animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                        animationView.contentMode = .scaleAspectFill
                                        
                                        animationView.loopAnimation = true
                                        // animationView?.layer = "Group 30.png"
                                        self.view.addSubview(animationView)
                                        animationView.play()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                                            animationView.pause()
                                            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "InstantsLio", bundle: nil)
                                            let initialViewControlleripad : InstantsLioViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "InstantsLioViewController") as! InstantsLioViewController
                                            UserManager.sharedInstance.mainNavigationController.pushViewController(initialViewControlleripad, animated: true)
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                    // fin upload
                                    
                                    
                                    
                                } // if json.count != 0
                                
                                
                                //
                                
                                
                            } // fin resquest getwhitelist
                            
                            
                            
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
        }
        
        
        
        
        
    }
    
    
    
    
    
    /*       RequestServer.sharedInstance.GetUserSample() { (json) in
     //print(json)
     self.arrayNames = json.arrayValue.map({$0["smallPhoto"].stringValue})
     self.arrayMood = json.arrayValue.map({$0["mood"].stringValue})
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[0] ,nameimage: "img_0", colorimg: self.arrayMood[0]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[1] ,nameimage: "img_2", colorimg: self.arrayMood[1]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[2] ,nameimage: "img_3", colorimg: self.arrayMood[2]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[3] ,nameimage: "img_4", colorimg: self.arrayMood[3]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[4] ,nameimage: "img_6", colorimg: self.arrayMood[4]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[5], nameimage: "img_7", colorimg: self.arrayMood[5]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[6] ,nameimage: "img_8", colorimg: self.arrayMood[6]) { (json) in}
     RequestServer.sharedInstance.SaveImg(urlimg:self.arrayNames[7] ,nameimage: "img_9", colorimg: self.arrayMood[7]) { (json) in}
     
     }
     
     let animationView = LOTAnimationView(name: "splash.json")
     
     animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
     animationView.contentMode = .scaleAspectFill
     
     animationView.loopAnimation = true
     // animationView?.layer = "Group 30.png"
     self.view.addSubview(animationView)
     animationView.play()
     
     DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
     animationView.pause()
     let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let initialViewControlleripad : InstantsViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "InstantsViewController") as! InstantsViewController
     self.present(initialViewControlleripad, animated: true)
     
     }
     */
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
/*
 // MARK: - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


