//
//  CityFromJSONMapper.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

class CityFromJSONMapper {
    static func map(json: [String: Any]) -> City {
        let coordinate = json["coordinate"] as? [String: Any] ?? [:]
        
        return City(id: json["id"] as? String ?? "",
                    name: json["name"] as? String ?? "",
                    coordinate: Coordinate(latitude: coordinate["latitude"] as? Double ?? 0.0,
                                           longitude: coordinate["longitude"] as? Double ?? 0.0))
    }
}
