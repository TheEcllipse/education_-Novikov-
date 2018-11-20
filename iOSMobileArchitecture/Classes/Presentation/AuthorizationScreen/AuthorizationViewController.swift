//
//  AuthorizationViewController.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthorizationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var preloaderView: UIView!
    
    let viewModel = AuthorizationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.rx.text
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel
            .allowEntry
            .drive(signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .loading
            .map { loading -> Bool in
                return !loading
            }
            .drive(preloaderView.rx.isHidden)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .flatMapLatest { [viewModel] _ -> Observable<Void> in
                return viewModel.signIn()
            }
            .bind(to: rx.goToCitiesScreen)
            .disposed(by: disposeBag)
        
        rx.keyboardHeight
            .map { height -> UIEdgeInsets in
                return UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            .bind(to: scrollView.rx.contentInsets)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(to: rx.hideKeyboardObserver)
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .bind(to: rx.showError)
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}

extension Reactive where Base: AuthorizationViewController {
    var goToCitiesScreen: Binder<Void> {
        return Binder(base) { base, _ in
            let vc = UIStoryboard(name: "CitiesScreen", bundle: nil).instantiateViewController(withIdentifier: "CitiesViewController")
            let nc = UINavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow?.rootViewController = nc
        }
    }
    
    var showError: Binder<Error> {
        return Binder(base) { base, error in
            let alert = AuthorizationErrorAlert(error: error)
            alert.present(from: base)
        }
    }
}
