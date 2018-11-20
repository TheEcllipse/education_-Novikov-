//
//  SessionService.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 26.09.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RxSwift
import RxCocoa

class SessionService: RestAPI {
    static var userIsAuthorized: Observable<Bool> {
        return Observable.create { observer in
            let userID = UserDefaults.standard.string(forKey: UserIDKey)
            
            if userID != nil {
                observer.onNext(true)
            } else {
                observer.onNext(false)
            }
            
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    static var userID: Observable<Int> {
        return Observable.create { observer in
            let userID = UserDefaults.standard.string(forKey: UserIDKey) ?? ""
            
            observer.onNext(Int(userID) ?? 0)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    static var accessToken: Observable<String> {
        return Observable.create { observer in
            guard let accessToken = UserDefaults.standard.string(forKey: AccessTokenKey) else {
                observer.onError(Problem())
                
                return Disposables.create()
            }
            
            observer.onNext(accessToken)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
//    if let file = Bundle.main.path(forResource: "document", ofType: "json") {
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: file), options: [])
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            observer.onNext(json)
//            observer.onCompleted()
//        } catch {
//            print(error)
//        }
//
//    }

    static func signIn(login: String, password: String) -> Observable<Void> {
        let request = SignInRequest(login: login, password: password)
        
        return requestSingleResponse(with: request) { response -> JWT? in
            return JWTFromJSONMapper.map(json: response)
        }
//        .catchError { _ -> Observable<JWT?> in
//            return Observable<[String: Any]>.create { observer in
//                let path = Bundle.main.path(forResource: "authorization", ofType: "json")!
//                let url = URL(fileURLWithPath: path)
//                let data = try? Data(contentsOf: url, options: [])
//                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//
//                let dict = json as? [String: Any] ?? [:]
//
//                observer.onNext(dict)
//                observer.onCompleted()
//
//                return Disposables.create()
//            }
//            .map { dict -> JWT? in
//                return JWTFromJSONMapper.map(json: dict)
//            }
//        }
        .flatMap { value -> Observable<Void> in
            if let jwt = value {
                return Observable.create { observer in
                    UserDefaults.standard.set(jwt.tokens.accessToken, forKey: AccessTokenKey)
                    UserDefaults.standard.set(jwt.tokens.refreshToken, forKey: RefreshTokenKey)
                    UserDefaults.standard.set(jwt.userID, forKey: UserIDKey)
                    
                    observer.onNext(Void())
                    observer.onCompleted()
                    
                    return Disposables.create()
                }
            } else {
                return Observable.error(Problem())
            }
        }
    }
    
    static func reSignIn() -> Observable<Void> {
        guard let refreshToken = UserDefaults.standard.string(forKey: RefreshTokenKey) else {
            return Observable.error(Problem())
        }
        
        let request = ReSignInRequest(refreshToken: refreshToken)
        
        return requestSingleResponse(with: request) { response -> Tokens? in
            return TokensFromJSONMapper.map(json: response)
        }
        .flatMap { value -> Observable<Void> in
            if let tokens = value {
                return Observable.create { observer in
                    UserDefaults.standard.set(tokens.accessToken, forKey: AccessTokenKey)
                    UserDefaults.standard.set(tokens.refreshToken, forKey: RefreshTokenKey)
                    
                    observer.onNext(Void())
                    observer.onCompleted()
                    
                    return Disposables.create()
                }
            } else {
                return Observable.error(Problem())
            }
        }
    }
    
    static func logout() -> Observable<Void> {
        return Observable.create { observer in
            UserDefaults.standard.removeObject(forKey: AccessTokenKey)
            UserDefaults.standard.removeObject(forKey: RefreshTokenKey)
            UserDefaults.standard.removeObject(forKey: UserIDKey)
            
            observer.onNext(Void())
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    private static let AccessTokenKey = "access_token_key"
    private static let RefreshTokenKey = "refresh_token_key"
    private static let UserIDKey = "user_id_key"
}
