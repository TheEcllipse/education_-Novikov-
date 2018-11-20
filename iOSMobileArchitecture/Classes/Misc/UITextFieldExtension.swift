//
//  UITextFieldExtension.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 02/10/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable var textLocalize: String? {
        set {
            if let newValue = newValue {
                text = NSLocalizedString(newValue, comment: "")
            }
        }
        get {
            return text
        }
    }
    
    @IBInspectable var placeholderLocalize: String? {
        set {
            if let newValue = newValue {
                placeholder = NSLocalizedString(newValue, comment: "")
            }
        }
        get {
            return placeholder
        }
    }
}
