//
//  JWTFromJSONMapper.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 27.09.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

class JWTFromJSONMapper {
    static func map(json: [String: Any]) -> JWT? {
        guard
            let tokens = TokensFromJSONMapper.map(json: json),
            let userID = json["user_id"] as? Int
        else {
            return nil
        }
        
        return JWT(tokens: tokens, userID: userID)
    }
}
