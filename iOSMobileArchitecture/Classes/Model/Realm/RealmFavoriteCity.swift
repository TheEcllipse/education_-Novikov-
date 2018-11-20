//
//  RealmFavoriteCity.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 20/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RealmSwift
import Foundation.NSDate

class RealmFavoriteCity: Object {
    @objc dynamic var cityID: String = ""
    @objc dynamic var dateAdded: TimeInterval = 0.0
    
    @objc open override class func primaryKey() -> String? {
        return "cityID"
    }
}
