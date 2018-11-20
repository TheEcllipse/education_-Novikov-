//
//  SplashViewController.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SessionService
            .userIsAuthorized
            .delaySubscription(2, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] isAuthorized in
                if isAuthorized {
                    self?.goToCitiesScreen()
                } else {
                    self?.goToAuthorizationScreen()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func goToAuthorizationScreen() {
        let vc = UIStoryboard(name: "AuthorizationScreen", bundle: nil).instantiateViewController(withIdentifier: "AuthorizationViewController")
        let nc = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = nc
    }
    
    private func goToCitiesScreen() {
        let vc = UIStoryboard(name: "CitiesScreen", bundle: nil).instantiateViewController(withIdentifier: "CitiesViewController")
        let nc = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = nc
    }
    
    private let disposeBag = DisposeBag()
}
