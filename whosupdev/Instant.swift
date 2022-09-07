//
//  Instants.swift
//  whosupdev
//
//  Created by Sophie Romanet on 14/08/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class PermissionMembers: Object {
    
    dynamic var name = ""
    dynamic var _id = ""
    
}

class Instant: Object {
    
    
    dynamic var i_id: Int = 0
    
    dynamic var hashtag = ""
    dynamic var _id = ""
    dynamic var picture = ""
    dynamic var mood = ""
    
    var members = List<PermissionMembers>()
    // gestion primary key id autoincrémente
    
    override static func primaryKey() -> String? {
        return "i_id"
    }
    
    func incrementPK() -> Int {
        let realm = try! Realm()
        return (realm.objects(Instant.self).max(ofProperty: "i_id") as Int? ?? 0) + 1
    }

    
}
