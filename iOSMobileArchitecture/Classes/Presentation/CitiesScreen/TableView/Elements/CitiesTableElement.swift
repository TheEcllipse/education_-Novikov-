//
//  CitiesTableElement.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 12/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

enum CityTableElement {
    case city(CityElement)
    case favorite(FavoriteCityElement)
}

struct CityElement {
    let id: String
    let name: String
}

struct FavoriteCityElement {
    let id: String
    let name: String
    let dateAdded: String
}
