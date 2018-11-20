//
//  CityFromJSONMapper.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

class CitiesFromJSONMapper {
    static func map(array: [[String: AnyObject]]) -> [City] {
        return array.map { json -> City in
            return City(id: json["id"] as? String ?? "",
                        name: json["name"] as? String ?? "")
        }
    }
}
