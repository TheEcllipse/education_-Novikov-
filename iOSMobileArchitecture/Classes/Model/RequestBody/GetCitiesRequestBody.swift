//
//  GetCitiesRequestBody.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 20/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import Alamofire

struct GetCitiesRequestBody: AuthAPIRequestBody {
    var accessToken: String = ""
    
    var url: String {
        return GlobalDefinitions.domainUrl + "/api/get_cities"
    }
}
