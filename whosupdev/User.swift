//
//  User.swift
//  whosupdev
//
//  Created by Sophie Romanet on 09/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import MapKit

public class User: NSObject {
    
    static let sharedInstance = User()
    
    var _id = String()
    var nom = String()
    var tel = String()
    var email = String()
    var facebookid = String()
    var urlphoto = String()
    var gendre = String()
    var longitude = String()
    var latitude = String()
    let defaults = UserDefaults.standard
    //private Location location ;
    
  
    func getLongitude() -> String{
        
        let longitude =  defaults.value(forKey: "longitude")
        return longitude as! String
        
    }
    
   func setLongitude(_longitude: String) {
    
        defaults.setValue(_longitude, forKey: "longitude")
 
    }
    
    func getLatitude() -> String {
      
        return defaults.value(forKey: "latitude") as! String
        
    }
    
    func setfirstconnection (isconnect: String) {
        
        defaults.setValue(isconnect, forKey: "firstconnection")
        
    }
    
    func getfirstconnection() -> String {
        
        return defaults.value(forKey: "firstconnection") as! String
        
    }
    
    
    
    func setLatitude( _latitude: String) {
        defaults.setValue(_latitude, forKey: "latitude")
        
    }
    
    func get_id() -> String {
        return defaults.value(forKey: "id") as! String
    }
    
   func set_id(_id: String) {
        defaults.setValue(_id, forKey: "id")
 
    }
    
    func getGender() -> String {
        return defaults.value(forKey: "gender") as! String;
    }
    
    func setGender( _gender: String) {
        defaults.setValue( _gender, forKey: "gender")
    }
    
    func getUrlphoto() -> String {
    return defaults.value(forKey: "urlphoto") as! String
    }
    
    func setUrlphoto( _urlphoto: String) {
        defaults.setValue( _urlphoto, forKey: "urlphoto")
    }
    
    func getNom() -> String {
        return defaults.value(forKey: "nom") as! String
        
    }
    
    func setNom( _nom: String) {
        
        defaults.setValue( _nom, forKey: "nom")
    }
    
   func getTel() -> String {
    
        return defaults.value(forKey: "tel") as! String;
    }
    
    func setTel( _tel: String) {
        
        defaults.setValue( _tel, forKey: "tel")
        
    }
    
    func getEmail() -> String {
        return defaults.value(forKey: "email") as! String
    }
    
    func setEmail( _email: String) {
        
        defaults.setValue( _email, forKey: "email")
        
    }
    
    func getFacebookid() -> String {
    
        return defaults.value(forKey: "facebookid") as! String;
    }
    
    func setFacebookid( _facebookid: String) {
        defaults.setValue( _facebookid, forKey: "facebookid")
    }
    
    func getTocken() -> String {
        
        return defaults.value(forKey: "tocken") as! String;
    }
    
    func setTocken( _tocken: String) {
        defaults.setValue( _tocken, forKey: "tocken")
    }
    
    func getDevice() -> String {
        
        return defaults.value(forKey: "device") as! String;
    }
    
    func setDevice( _device: String) {
        defaults.setValue( _device, forKey: "device")
    }
    func getlargePhoto() -> UIImage {
       
        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent("largepicture")
        
        var myUrlString = myurl.absoluteString
        
        myUrlString = myUrlString.replacingOccurrences(of: "file://", with: "")
        let image =  UIImage(contentsOfFile: myUrlString)
        return image!
   
    }
    
    func setlargePhoto( _urlphoto: String) {
       
    }
    
    func getsmallPhoto() -> UIImage {
        
        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent("smallpicture")
        
        var myUrlString = myurl.absoluteString
        
        myUrlString = myUrlString.replacingOccurrences(of: "file://", with: "")
        let image =  UIImage(contentsOfFile: myUrlString)
        return image!
    }
    
    func setsmallPhoto( _urlphoto: String) {
        defaults.setValue( _urlphoto, forKey: "smallPhoto")
    }
    
    func getmediumPhoto() -> UIImage {
        
        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent("img_0")
        
        var myUrlString = myurl.absoluteString
        
        myUrlString = myUrlString.replacingOccurrences(of: "file://", with: "")
        let image =  UIImage(contentsOfFile: myUrlString)
        return image!
    }
    
    func setmediumPhoto( _urlphoto: String) {
        defaults.setValue( _urlphoto, forKey: "mediumPhoto")
    }
    
    
    func toString() -> String {
    return "User{" +
    "_id='" + self.get_id() + "'" +
    ", nom='" + self.getNom() + "'" +
    ", tel='" + self.getTel() + "'" +
    ", email='" + self.getEmail() + "'" +
    ", facebookid='" + self.getFacebookid() + "'" +
    ", urlphoto='" + self.getUrlphoto() + "'" +
    ", latitude='" + self.getLatitude() + "'" +
    ", Longitude='" + self.getLongitude() + "'" +
    ", gender='" + self.getGender() + "'" +
    "}";
    }
}
