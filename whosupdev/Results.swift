//
//  URL.swift
//  whosupdev
//
//  Created by Sophie Romanet on 10/08/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray() -> [Results.Generator.Element] {
        return map { $0 }
    }
}
