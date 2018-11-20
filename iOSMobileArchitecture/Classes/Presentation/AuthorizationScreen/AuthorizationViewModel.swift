//
//  AuthorizationViewModel.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import RxSwift
import RxCocoa

class AuthorizationViewModel {
    let login = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    
    let loading = RxActivityIndicator()
    let error = PublishRelay<Error>()
    
    let allowEntry: Driver<Bool>
    
    init() {
        let credentialsIsFilled = Observable
            .combineLatest(login, password) { login, password -> Bool in
                return (login?.isEmpty == false && password?.isEmpty == false)
            }
            .asDriver(onErrorJustReturn: true)
        
        allowEntry = Driver
            .combineLatest(credentialsIsFilled, loading) { credentialsIsFilled, loading -> Bool in
                return credentialsIsFilled && !loading
            }
    }
    
    func signIn() -> Observable<Void> {
        return Observable
            .combineLatest(login, password)
            .flatMapLatest { [loading] login, password -> Observable<Void> in
                return SessionService
                    .signIn(login: login!, password: password!)
                    .trackActivity(loading)
            }
            .do(onError: { [weak self] error in
                self?.error.accept(error)
            })
            .consumeError()
    }
}
