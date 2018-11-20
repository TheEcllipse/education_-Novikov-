//
//  CityRealmMapper.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RealmSwift

class CityRealmMapper {
    static func map(entity: City) -> RealmCity {
        let realmCity = RealmCity()
        
        realmCity.id = entity.id
        realmCity.name = entity.name
        
        let realmCoordinate = RealmCoordinate()
        realmCoordinate.latitude = entity.coordinate.latitude
        realmCoordinate.longitude = entity.coordinate.longitude
        realmCity.coordinate = realmCoordinate
        
        return realmCity
    }
    
    static func map(realm: RealmCity) -> City {
        let coordinate = Coordinate(latitude: realm.coordinate.latitude,
                                    longitude: realm.coordinate.longitude)
        
        return City(id: realm.id,
                    name: realm.name,
                    coordinate: coordinate)
    }
}
