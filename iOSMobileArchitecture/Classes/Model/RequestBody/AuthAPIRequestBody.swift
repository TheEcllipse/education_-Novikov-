//
//  AuthAPIRequestBody.swift
//  DrSmart
//
//  Created by Andrey Chernyshev on 06.08.2018.
//  Copyright © 2018 SimbirSoft. All rights reserved.
//

import Alamofire

protocol AuthAPIRequestBody: APIRequestBody {
    var accessToken: String { get set }
    
    mutating func setAccessToken(accessToken: String)
}

extension AuthAPIRequestBody {
    mutating func setAccessToken(accessToken: String) {
        self.accessToken = accessToken
    }
}
