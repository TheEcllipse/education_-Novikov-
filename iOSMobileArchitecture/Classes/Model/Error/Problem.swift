//
//  Problem.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

struct Problem: Error {
    let message: String
    let code: Int
    let isNetworkProblem: Bool

    init(message: String = "unknown_error".localized, code: Int = -1, isNetworkProblem: Bool = false) {
        self.message = message
        self.code = code
        self.isNetworkProblem = isNetworkProblem
    }
}
