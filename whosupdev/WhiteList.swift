//
//  WhiteList.swift
//  whosupdev
//
//  Created by Sophie Romanet on 06/08/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class RealmString: Object {
    
    convenience init(string: String){
        self.init()
        self.stringValue = string
    }
    dynamic var stringValue = ""
}

class Hachtags: Object {
    
    dynamic var stringHach = ""
    dynamic var moods = ""


}


class WhiteList: Object, Mappable {

    dynamic var w_id: Int = 0
    dynamic var gender = ""
    dynamic var instantCount = ""
    dynamic var emojis = ""
    dynamic var age = ""
    dynamic var mediumPhoto = ""
    dynamic var _id = ""
    dynamic var latitude = ""
    dynamic var smallPhoto = ""
    dynamic var longitude = ""
    dynamic var name = ""
    dynamic var largePhoto = ""
    
    var moods: [String] {
        get {
            return moodsV.map { $0.stringValue }
        }
        set {
            moodsV.removeAll()
            moodsV.append(objectsIn: newValue.map({ RealmString(value: [$0]) }))
        }
    }
    
    
    let moodsV = List<RealmString>()
    
    var hashtagsV = List<Hachtags>()
    
    
    override static func ignoredProperties() -> [String] {
        return ["moods"]
    }
    
    
    // gestion primary key id autoincrémente
    
    override static func primaryKey() -> String? {
        return "w_id"
    }
    
    func incrementPK() -> Int {
        let realm = try! Realm()
        return (realm.objects(WhiteList.self).max(ofProperty: "w_id") as Int? ?? 0) + 1
    }

    
    //Impl. of Mappable protocol
    required convenience init?(map p: Map) {
        self.init()
    }
    
    
    
    func mapping(map: Map) {
   
        gender <- map["gender"]
        instantCount <- map["instantCount"]
        emojis <- map["emojis"]
        age <- map["age"]
        mediumPhoto <- map["mediumPhoto"]
        _id <- map["_id"]
        latitude <- map["latitude"]
        smallPhoto <- map["smallPhoto"]
        name <- map["name"]
        latitude <- map["latitude"]
        largePhoto <- map["largePhoto"]
        moods <- map["moods"]
        hashtagsV <- map["hashtags"]
        longitude <- map["longitude"]

    }


}


