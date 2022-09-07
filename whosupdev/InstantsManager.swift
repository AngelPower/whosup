//
//  InstantsManager.swift
//  whosupdev
//
//  Created by Sophie Romanet on 15/08/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class InstantsManager: NSObject {

    func initMembers(_id: String) -> [String] {
        
        var MembersName = [String]()
        let realm = try! Realm()
        
        let m_moodchill = realm.objects(Instant.self).filter("_id == %@", _id).first
        
        
        if (m_moodchill != nil) {
        
        for memberitem in (m_moodchill?.members)! {
                MembersName.append(memberitem.name)

        }
        }
        return MembersName
    }

    
    




}
