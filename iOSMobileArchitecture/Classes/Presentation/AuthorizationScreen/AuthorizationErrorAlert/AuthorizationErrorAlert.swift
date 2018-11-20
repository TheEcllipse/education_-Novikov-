//
//  AuthorizationErrorAlert.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 20/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit

class AuthorizationErrorAlert {
    init(error: Error) {
        alertController = UIAlertController(title: "error".localized, message: errorMessage(at: error), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "ok".localized, style: .cancel)
        alertController.addAction(cancel)
    }
    
    func present(from vc: UIViewController) {
        vc.present(alertController, animated: true)
    }
    
    private func errorMessage(at error: Error) -> String {
        guard let problem = error as? Problem else {
            return "unknown_error".localized
        }
        
        switch problem.code {
        case 401:
            return "invalid_credentials".localized
        default:
            return problem.message
        }
    }
    
    private var alertController: UIAlertController!
}
