//
//  RealmCity.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 14/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RealmSwift

class RealmCity: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var coordinate: RealmCoordinate!
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
}
