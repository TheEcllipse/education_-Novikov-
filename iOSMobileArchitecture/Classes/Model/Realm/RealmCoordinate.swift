//
//  RealmCoordinate.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RealmSwift

class RealmCoordinate: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
}
