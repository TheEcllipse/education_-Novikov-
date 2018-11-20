//
//  ReSignInRequest.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 27.09.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

struct ReSignInRequest: APIRequestBody {
    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    var url: String {
        return GlobalDefinitions.domainUrl + "/api/refresh-token/\(refreshToken)"
    }
    
    private let refreshToken: String
}
