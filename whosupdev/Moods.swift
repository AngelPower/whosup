//
//  Moods.swift
//  whosupdev
//
//  Created by Sophie Romanet on 10/07/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import RealmSwift


class Moods: Object {
    
    dynamic var m_id: Int = 0
    dynamic var mood = ""
    dynamic var statut = ""
    dynamic var HActivate = ""
    dynamic var hachtag = ""
    
   // let whitelist = LinkingObjects(fromType: WhiteList.self , property: "moods")
    
    // gestion primary key id autoincrémente
    
    override static func primaryKey() -> String? {
        return "m_id"
    }
    
    func incrementPK() -> Int {
        let realm = try! Realm()
        return (realm.objects(Moods.self).max(ofProperty: "m_id") as Int? ?? 0) + 1
    }
    
}
