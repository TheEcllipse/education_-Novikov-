//
//  CityService.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RxSwift
import RxCocoa

class CityService: RestAPI {
    static func getCities() -> Observable<[City]> {
        return wrapperArrayResponse(with: GetCitiesRequestBody()) { response -> [City] in
            return CitiesFromJSONMapper.map(array: response)
        }
        .catchError { _ -> Observable<[City]> in
            // Имитация запроса
            return Observable<[[String: AnyObject]]>.create { observer in
                let path = Bundle.main.path(forResource: "getCities", ofType: "json")!
                let url = URL(fileURLWithPath: path)
                let data = try? Data(contentsOf: url, options: [])
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                let dict = json as? [[String: AnyObject]] ?? []
                
                observer.onNext(dict)
                observer.onCompleted()
                
                return Disposables.create()
            }
            .map { dict -> [City] in
                return CitiesFromJSONMapper.map(array: dict)
            }
        }
    }
    
    static func getFavoriteCities() -> Observable<[FavoriteCity]> {
        return DAO().loadData(realmType: RealmFavoriteCity.self) { realm -> FavoriteCity in
            return FavoriteCityRealmMapper.map(realm: realm)
        }
    }
    
    static func addFavorite(cityID: String) -> Observable<Void> {
        let favoriteCity = FavoriteCity(cityID: cityID, dateAdded: Date().timeIntervalSince1970)
        return DAO().saveData(entities: [favoriteCity]) { favoriteCity -> RealmFavoriteCity in
            return FavoriteCityRealmMapper.map(entity: favoriteCity)
        }
    }
    
    static func removeFavorite(cityID: String) -> Observable<Void> {
        let filter = NSPredicate(format: "cityID == %@", cityID)
        return DAO().deleteData(realmType: RealmFavoriteCity.self, filter: filter)
    }
}
