//
//  UserManager.swift
//  whosupdev
//
//  Created by Sophie Romanet on 14/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import RealmSwift


class UserManager: NSObject {

    static let sharedInstance = UserManager()
    var mainNavigationController:UINavigationController = UINavigationController()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    var MoodsSelect = String()
    var MoodsUrl = [String]()
    ////.......MoodsSelects..........
    func setMoodsSelects( _moodsselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodsselects, forKey: "moodsselects")
        
    }
    
    func getMoodsSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodsselects") ?? String()
        return myarray
        
    }
    //...........indexactive .............
    func setIndexActive( _indexActive : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_indexActive, forKey: "indexactive")
        
    }
    
    func getIndexActive() -> String {
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "indexactive") ?? String()
        return myarray
        
    }
    
    ////.......WhiteList..........
    func setWhiteList( _whiteList : [String]) {
    
        let defaults = UserDefaults.standard
        defaults.set(_whiteList, forKey: "whiteList")
    
    }
    
    func getWhiteList() -> [String]{
    
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: "whiteList") ?? [String]()
        return myarray
    
    }
    
    
    ////.......MoodsPublicSoireeSelects..........
    func setMoodSoireePublicSelects( _moodsoireeselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodsoireeselects, forKey: "moodsoireeselects")
        
    }
    
    func getMoodSoireePublicSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodsoireeselects") ?? String()
        return myarray
        
    }
    
    ////.......MoodsPublicGameSelects..........
    func setMoodGamePublicSelects( _moodgameseselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodgameseselects, forKey: "moodgameseselects")
        
    }
    
    func getMoodGameSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodgameseselects") ?? String()
        return myarray
        
    }
    
    ////.......MoodsPublicGameSelects..........
    func setMoodFoodPublicSelects( _moodfoodseselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodfoodseselects, forKey: "moodfoodseselects")
        
    }
    
    func getMoodFoodPublicSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodfoodseselects") ?? String()
        return myarray
        
    }
    
    ////.......MoodsPublicSportSelects..........
    func setMoodSportPublicSelects( _moodsportseselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodsportseselects, forKey: "moodsportseselects")
        
    }
    
    func getMoodSportPublicSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodsportseselects") ?? String()
        return myarray
        
    }
    
    ////.......MoodsPublicAutreSelects..........
    
    
    func setMoodAutrePublicSelects( _moodautreseselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodautreseselects, forKey: "moodautreseselects")
        
    }
    
    func getMoodAutrePublicSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodautreseselects") ?? String()
        return myarray
        
    }
    
    
    ////.......MoodsPublicChillSelects..........
    
    
    func setMoodChillPublicSelects( _moodchillseselects : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_moodchillseselects, forKey: "moodchillseselects")
        
    }
    
    func getMoodChillPublicSelects() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "moodchillseselects") ?? String()
        return myarray
        
    }
    
    
    
    
    func IsConnect( _window : UIWindow) {
       
        if (UserDefaults.standard.value(forKey: "id") != nil){
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let initialViewControlleripad : HomeViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            mainNavigationController = UINavigationController(rootViewController: initialViewControlleripad)
            mainNavigationController.setNavigationBarHidden(true, animated: false)
            _window.rootViewController = mainNavigationController
            _window.makeKeyAndVisible()
            
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
                currentLocation = locManager.location
                
                let sLatitude:String = String(format:"%f", currentLocation.coordinate.latitude)
                let sLongitude:String = String(format:"%f", currentLocation.coordinate.longitude)
                //User.sharedInstance.setLatitude(_latitude: sLatitude)
                //User.sharedInstance.setLongitude(_longitude: sLongitude)             
                //proviiiiisoiiiiire !!!!!
                
              
     
                if ( sLatitude != User.sharedInstance.getLatitude()){
                    
                   // User.sharedInstance.setLatitude(_latitude: sLatitude)
                
                }
                if( sLongitude != User.sharedInstance.getLongitude()) {
                
                    //User.sharedInstance.setLongitude(_longitude: sLongitude)
                    
                }
              
            }
            
            User.sharedInstance.setLatitude(_latitude: "45.125028")
            User.sharedInstance.setLongitude(_longitude: "5.694778")
   
            
         /*   try! realm.write ({
                realm.delete(moods)
            })
            */
          
            User.sharedInstance.setfirstconnection(isconnect: "no")
            }
        else {
            
            
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Inscription", bundle: nil)
            let initialViewControlleripad : Login = mainStoryboardIpad.instantiateViewController(withIdentifier: "Login") as! Login
            mainNavigationController = UINavigationController(rootViewController: initialViewControlleripad)
            mainNavigationController.setNavigationBarHidden(true, animated: false)
            _window.rootViewController = mainNavigationController
            _window.makeKeyAndVisible()
        User.sharedInstance.setfirstconnection(isconnect: "yes")
        
        }
        
        let realm = try! Realm()
        
        let moods = realm.objects(Moods.self)
        print(Realm.Configuration.defaultConfiguration.fileURL)
        var m_moods:[Moods] = []
        let faceTypes = Array(realm.objects(Moods.self))
        m_moods = faceTypes.map({$0 as Moods})
        
        print("nooooommmmbre de mmooooooooods \(m_moods.count)")
        
        if  moods.count == 0 { // 1
            
            
            let defaultMoods = ["soiree".localized, "sport".localized, "food".localized, "game".localized, "autres".localized, "chill".localized ] // 3
            
            for itemmood in defaultMoods { // 4
                let newMood = Moods()
                newMood.mood = itemmood
                newMood.statut = "noactive"
                newMood.m_id = newMood.incrementPK()
                try! realm.write { // 2
                    
                    realm.add(newMood, update: true)
                }
                
                
            }
         
                  }
        
      
            
     /*   UserManager.sharedInstance.setMoodSoireePublicSelects(_moodsoireeselects: "noactive")
        UserManager.sharedInstance.setMoodGamePublicSelects(_moodgameseselects: "noactive")
        UserManager.sharedInstance.setMoodFoodPublicSelects(_moodfoodseselects: "noactive")
        UserManager.sharedInstance.setMoodSportPublicSelects(_moodsportseselects: "noactive")
        UserManager.sharedInstance.setMoodAutrePublicSelects(_moodautreseselects: "noactive")
        UserManager.sharedInstance.setMoodChillPublicSelects(_moodchillseselects: "noactive")
        UserManager.sharedInstance.setIndexActive(_indexActive: "0")*/
        
    }
    

    
    func GetPicProfilCircle( _url: String, _mood:String) -> UIImageView {
    
        let imageName = _url
        let image1 = UIImage(named: imageName)
        let imageView = UIImageView(image: image1!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height:100)
       
        //let image1: UIImage = UIImage(named: "lapin")!
        imageView.image = image1
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        
        switch _mood {
            
        case "SOIREE":
            imageView.layer.borderColor = UIColor.purple.cgColor
        case "CHILL":
            imageView.layer.borderColor = UIColor.blue.cgColor
        case "SPORT":
            imageView.layer.borderColor = UIColor.red.cgColor
        case "ME":
            imageView.layer.borderColor = UIColor.white.cgColor
            
        default:
            break
        }
        
        imageView.layer.shadowColor = UIColor(white: 0.7, alpha: 0.7).cgColor
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.4
        imageView.zoomInWithEasing()

        
        return imageView
  
    }

    


}
