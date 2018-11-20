//
//  RestAPI.swift
//  DrSmart
//
//  Created by Andrey Chernyshev on 17.07.2018.
//  Copyright © 2018 SimbirSoft. All rights reserved.
//

import RxSwift

protocol RestAPI {}

extension RestAPI {
    static func request(with body: APIRequestBody) -> Observable<Any> {
        return RestAPITransport().callServerApi(requestBody: body)
    }
    
    static func requestWithoutResponse(with body: APIRequestBody) -> Observable<Void> {
        return request(with: body).flatMap { _ -> Observable<Void> in
            return Observable<Void>.create(with: Void())
        }
    }
    
    static func requestArrayResponse<E>(with body: APIRequestBody, map: @escaping ([[String: AnyObject]]) -> ([E])) -> Observable<[E]> {
        return request(with: body).flatMap { response -> Observable<[E]> in
            guard let array = response as? [[String: AnyObject]] else {
                return .empty()
            }
            
            let result = map(array)
            
            return Observable<[E]>.create(with: result)
        }
    }
    
    static func requestSingleResponse<E>(with body: APIRequestBody, map: @escaping ([String: AnyObject]) -> (E)) -> Observable<E> {
        return request(with: body).flatMap { response -> Observable<E> in
            guard let dict = response as? [String: AnyObject] else {
                return .empty()
            }
            
            let result = map(dict)
            
            return Observable<E>.create(with: result)
        }
    }
    
    static func wrapperWithoutResponse(with body: AuthAPIRequestBody) -> Observable<Void> {
        return SessionService
            .accessToken
            .flatMap { accessToken -> Observable<Void> in
                var requestBody = body
                requestBody.setAccessToken(accessToken: accessToken)

                return requestWithoutResponse(with: requestBody)
                    .catchError { error -> Observable<Void> in
                        guard let problem = error as? Problem, problem.code == 401 else {
                            return Observable.error(error)
                        }

                        return SessionService
                            .reSignIn()
                            .flatMap { _ -> Observable<Void> in
                                return SessionService
                                    .accessToken
                                    .flatMap { accessToken -> Observable<Void> in
                                        requestBody.setAccessToken(accessToken: accessToken)

                                        return requestWithoutResponse(with: requestBody)
                                    }
                            }
                    }
            }
    }

    static func wrapperArrayResponse<E>(with body: AuthAPIRequestBody, map: @escaping ([[String: AnyObject]]) -> ([E])) -> Observable<[E]> {
        return SessionService
            .accessToken
            .flatMap { accessToken -> Observable<[E]> in
                var requestBody = body
                requestBody.setAccessToken(accessToken: accessToken)

                return requestArrayResponse(with: requestBody, map: map)
                    .catchError { error -> Observable<[E]> in
                        guard let problem = error as? Problem, problem.code == 401 else {
                            return Observable.error(error)
                        }

                        return SessionService
                            .reSignIn()
                            .flatMap { _ -> Observable<[E]> in
                                return SessionService
                                    .accessToken
                                    .flatMap { accessToken -> Observable<[E]> in
                                        requestBody.setAccessToken(accessToken: accessToken)

                                        return requestArrayResponse(with: requestBody, map: map)
                                    }
                            }
                    }
            }
    }

    static func wrapperSingleResponse<E>(with body: AuthAPIRequestBody, map: @escaping ([String: AnyObject]) -> (E)) -> Observable<E> {
        return SessionService
            .accessToken
            .flatMap { accessToken -> Observable<E> in
                var requestBody = body
                requestBody.setAccessToken(accessToken: accessToken)

                return requestSingleResponse(with: requestBody, map: map)
                    .catchError { error -> Observable<E> in
                        guard let problem = error as? Problem, problem.code == 401 else {                            
                            return Observable.error(error)
                        }

                        return SessionService
                            .reSignIn()
                            .flatMap { _ -> Observable<E> in
                                return SessionService
                                    .accessToken
                                    .flatMap { accessToken -> Observable<E> in
                                        requestBody.setAccessToken(accessToken: accessToken)

                                        return requestSingleResponse(with: requestBody, map: map)
                                    }
                            }
                    }
            }
    }
}
