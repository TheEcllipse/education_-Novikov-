//
//  SignInRequest.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 27.09.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

struct SignInRequest: APIRequestBody {
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    var url: String {
        return GlobalDefinitions.domainUrl + "/api/login-token"
    }
    
    var headers: [String : String]? {
        return [
            "Authorization": String(format: "Basic %@", String(format: "%@:%@", login, password).asBase64)
        ]
    }
    
    private let login: String
    private let password: String
}
