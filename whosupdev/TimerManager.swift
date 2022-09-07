//
//  TimerManager.swift
//  whosupdev
//
//  Created by Sophie Romanet on 07/07/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit

class TimerManager: NSObject {
    
    
    static let sharedInstance = TimerManager()
    

    var setTimerSoiree = String()

    ////.......MoodsSelects..........
    func setTimerSoiree( _timer : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_timer, forKey: "TimerSoiree")
        
    }
    
    func getTimerSoiree() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "TimerSoiree") ?? String()
        return myarray
        
    }
    
    
    ////.......Timer Sport..........
    func setTimerSport( _timer : String) {
        
        let defaults = UserDefaults.standard
        defaults.set(_timer, forKey: "TimerSport")
        
    }
    
    func getTimerSport() -> String{
        
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: "TimerSport") ?? String()
        return myarray
        
    }
    

}
