//
//  MoodsManager.swift
//  whosupdev
//
//  Created by Sophie Romanet on 20/07/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class MoodsManager: NSObject {

        static let sharedInstance = MoodsManager()
 
        ////.......MoodsSoirée..........
        func setMoodsSoiree( _moodsoiree : [String]) {
            
            let defaults = UserDefaults.standard
            defaults.set(_moodsoiree, forKey: "moodsoiree")
            
        }
        
        func getMoodsSoiree() ->  [String]{
            
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodsoiree") ?? [String]()
            return myarray
            
        }
    
        func removeMoodsSoiree( _moodsoiree : [String]) {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodsoiree")
            setMoodsSoiree(_moodsoiree: _moodsoiree)
    
        }
    
        func setmymoodTimerSoireeActivate (_moodtimersoiree : String){
    
            let defaults = UserDefaults.standard
            defaults.set(_moodtimersoiree, forKey: "mymoodTimerSoireeActivate")
            
    
        }
    
        func getmymoodTimeractivate () -> String {
        
         let defaults = UserDefaults.standard
         let myarray = defaults.string( forKey: "mymoodTimerSoireeActivate") ?? String()
         return myarray
        
        }
    
        ////.......MoodsidSoirée..........
        func setMoodsIdSoiree( _moodIdsoiree : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodIdsoiree, forKey: "moodIdsoiree")
        
        }
    
        func getMoodsIdSoiree() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodIdsoiree") ?? [String]()
            return myarray
        
        }
    
        func removeMoodsIdSoiree( _moodIdsoiree : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodIdsoiree")
            setMoodsIdSoiree(_moodIdsoiree: _moodIdsoiree)
        
        }
    
    
        ////.......MoodsGame..........
        func setMoodsGame( _moodGame : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodGame, forKey: "moodGame")
        
        }
    
        func getMoodsGame() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodGame") ?? [String]()
            return myarray
        
        }
        func removeMoodsGame( _moodgame : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodGame")
            setMoodsGame(_moodGame: _moodgame)
        
        }
    
        ////.......MoodsidGame..........
        func setMoodsIdGame( _moodIdgame : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodIdgame, forKey: "moodIdgame")
        
        }
    
        func getMoodsIdGame() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodIdgame") ?? [String]()
            return myarray
        
        }
        func removeMoodsIdGame( _moodIdgame : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodIdgame")
            setMoodsIdGame( _moodIdgame: _moodIdgame)
        
        }
    
    
        ////.......Moodsfood..........
        func setMoodsfood( _moodfood : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodfood, forKey: "moodfood")
        
        }
    
        func getMoodsfood() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodfood") ?? [String]()
            return myarray
        
        }
        func removeMoodsfood( _moodfood : [String]) {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodfood")
            setMoodsfood(_moodfood: _moodfood)
        
        }
    
    
        ////.......Moodsidfood..........
        func setMoodsIdFood( _moodIdfood : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodIdfood, forKey: "moodIdfood")
        
        }
    
        func getMoodsIdFood() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodIdfood") ?? [String]()
            return myarray
        
        }
    
        func removeMoodsIdFood( _moodIdfood : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodIdfood")
            setMoodsIdFood(_moodIdfood: _moodIdfood)
        
        }
    
        ////.......Moodssport..........
        func setMoodSport( _moodsport : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodsport, forKey: "moodsport")
        
        }
    
        func getMoodSport() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodsport") ?? [String]()
            return myarray
        
        }
    
        func removeMoodSport( _moodSport : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodsport")
            setMoodSport(_moodsport: _moodSport)
        
        }
    
        ////.......MoodsidSport..........
        func setMoodIdSport( _moodIdsport : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodIdsport, forKey: "moodIdsport")
        
        }
    
        func getMoodIdSport() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodIdsport") ?? [String]()
            return myarray
        
        }
        func removeMoodIdSport( _moodIdSport : [String])  {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodIdsport")
            setMoodIdSport(_moodIdsport: _moodIdSport)
            
        }
    
        ////.......MoodAutres..........
        func setMoodAutres( _moodAutre : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodAutre, forKey: "moodautres")
        
        }
    
        func getMoodAutres() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodautres") ?? [String]()
            return myarray
        
        }
        func removeMoodAutres( _moodAutres : [String])  {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodautres")
            setMoodAutres(_moodAutre: _moodAutres)
        
        }
    
    
        ////.......MoodsidAutres..........
        func setMoodIdAutres( _moodIdAutre : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodIdAutre, forKey: "moodIdautres")
        
        }
    
        func getMoodIdAutres() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodIdautres") ?? [String]()
            return myarray
        
        }
    
        func removeMoodIdAutres( _moodIdAutre : [String])  {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodIdautres")
            setMoodIdAutres(_moodIdAutre: _moodIdAutre)
        
        }
    
        ////.......MoodChill..........
        func setMoodChill( _moodChill : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodChill, forKey: "moodchill")
        
        }
    
        func getMoodChill() ->  [String]{
            
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodchill") ?? [String]()
            return myarray
        
        }
    
        func removeMoodChill ( _moodChill : [String])  {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodchill")
            setMoodChill(_moodChill: _moodChill)
        
        }
    
        ////.......MoodsidChill..........
        func setMoodIdChill( _moodIdChill : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.set(_moodIdChill, forKey: "moodIdchill")
        
        }
    
        func getMoodIdChill() ->  [String]{
        
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "moodIdchill") ?? [String]()
            return myarray
        
        }
    
        func removeMoodIdChill ( _moodIdChill : [String]) {
        
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "moodIdchill")
            setMoodIdChill(_moodIdChill: _moodIdChill)
        
        }
    
    
    
    func initRequetemoodsoiree() -> [String] {

        var moodsoiree = [String]()
        
        let realm = try! Realm()
        
        let m_moodSoiree = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["soiree".localized])
        if (m_moodSoiree.count != 0 ){
            
            for index in 0...m_moodSoiree.count-1 {
                moodsoiree.append(m_moodSoiree[index].smallPhoto)
               
            }
        }
        
        return moodsoiree
        
    }
    
    func initRequetemoodsport() -> [String] {
        
        var MoodsSport = [String]()
        let realm = try! Realm()
        
        let m_moodsport = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["sport".localized])
        
        if (m_moodsport.count != 0 ){
            
            for index in 0...m_moodsport.count-1 {
                MoodsSport.append(m_moodsport[index].smallPhoto)
                
            }
        }
        return MoodsSport
        
    }
  
    func initRequetemoodgame() -> [String] {
        
        var MoodsGame = [String]()
        let realm = try! Realm()
        
        let m_moodgame = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["game".localized])
        if (m_moodgame.count != 0 ){
            
            for index in 0...m_moodgame.count-1 {
                MoodsGame.append(m_moodgame[index].smallPhoto)
                
            }
        }
        return MoodsGame
        
    }
    
    func initRequetemoodfood() -> [String] {
        
        var MoodsFood = [String]()
        let realm = try! Realm()
        
        let m_moodfood = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["food".localized])
        
        if (m_moodfood.count != 0 ){
            
            for index in 0...m_moodfood.count-1 {
                MoodsFood.append(m_moodfood[index].smallPhoto)
                
            }
        }
        return MoodsFood
        
    }
    
    func initRequetemoodautres() -> [String] {
        
        var MoodsAutre = [String]()
        let realm = try! Realm()
        
        
        let m_moodautres = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["autres".localized])
        
        
        if (m_moodautres.count != 0 ){
            
            for index in 0...m_moodautres.count-1 {
                MoodsAutre.append(m_moodautres[index].smallPhoto)
              
                
            }
        }
        
        return MoodsAutre
        
    }
    
    func initRequetemoodchill() -> [String] {
        
        var MoodsChill = [String]()
        let realm = try! Realm()
 
        let m_moodchill = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["chill".localized])
        
        
        if (m_moodchill.count != 0 ){
            
            for index in 0...m_moodchill.count-1 {
                MoodsChill.append(m_moodchill[index].smallPhoto)
                
            }
        }
        
         return MoodsChill
    }
 
 

}
