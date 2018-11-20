//
//  FavoriteCityRealmMapper.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 20/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RealmSwift

class FavoriteCityRealmMapper {
    static func map(entity: FavoriteCity) -> RealmFavoriteCity {
        let realmFavoriteCity = RealmFavoriteCity()
        
        realmFavoriteCity.cityID = entity.cityID
        realmFavoriteCity.dateAdded = entity.dateAdded
        
        return realmFavoriteCity
    }
    
    static func map(realm: RealmFavoriteCity) -> FavoriteCity {
        return FavoriteCity(cityID: realm.cityID,
                            dateAdded: realm.dateAdded)
    }
}
