//
//  CitiesElementMapper.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 12/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

class CititesElementMapper {
    static func map(cities: [City], favoriteCities: [FavoriteCity]) -> [CityTableElement] {
        return cities.map { city -> CityTableElement in
            let favoriteCity = favoriteCities.first(where: { favoriteCity -> Bool in
                return favoriteCity.cityID == city.id
            })
            
            if let favorite = favoriteCity {
                let e = FavoriteCityElement(id: city.id,
                                            name: city.name,
                                            dateAdded: favorite.dateAdded.dayMonthYear)
                return CityTableElement.favorite(e)
            } else {
                let e = CityElement(id: city.id,
                                    name: city.name)
                
                return CityTableElement.city(e)
            }
        }
    }
}
