//
//  CitiesViewModel.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 12/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RxSwift
import RxCocoa

class CitiesViewModel {
    let elements: Driver<[CityTableElement]>
    
    let addFavorite = PublishRelay<String>()
    let removeFavorite = PublishRelay<String>()
    
    init() {
        let cities = CityService
            .getCities()
        
        let storedFavoriteCities = CityService
            .getFavoriteCities()
        
        let afterAddFavoritesCities = addFavorite
            .flatMap { id -> Observable<Void> in
                return CityService.addFavorite(cityID: id)
            }
            .flatMap { _ -> Observable<[FavoriteCity]> in
                return CityService.getFavoriteCities()
            }
        
        let afterRemoveFavotiteCities = removeFavorite
            .flatMap { id -> Observable<Void> in
                return CityService.removeFavorite(cityID: id)
            }
            .flatMap { _ -> Observable<[FavoriteCity]> in
                return CityService.getFavoriteCities()
            }
        
        let favoriteCities = Observable
            .merge(storedFavoriteCities, afterAddFavoritesCities, afterRemoveFavotiteCities)
        
        
        elements = Observable
            .combineLatest(cities, favoriteCities) { cities, favoriteCities -> [CityTableElement] in
                return CititesElementMapper.map(cities: cities, favoriteCities: favoriteCities)
            }
            .asDriver(onErrorJustReturn: [])
    }
}
