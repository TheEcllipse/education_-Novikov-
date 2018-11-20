//
//  TokensFromJSONMapper.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 28.09.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

class TokensFromJSONMapper {
    static func map(json: [String: Any]) -> Tokens? {
        guard
            let accessToken = json["access_token"] as? String,
            let refreshToken = json["refresh_token"] as? String
        else {
            return nil
        }
        
        return Tokens(accessToken: accessToken,
                      refreshToken: refreshToken)
    }
}
