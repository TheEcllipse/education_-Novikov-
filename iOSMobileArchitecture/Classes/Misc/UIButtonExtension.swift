//
//  ButtonExtension.swift
//  iOS-Platform
//
//  Created by Andrey Chernyshev on 29.11.16.
//  Copyright © 2016 simbirsoft. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable var textLocalize: String? {
        set {
            if let newValue = newValue {
                setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
            }
        }
        get {
            return titleLabel?.text
        }
    }
}
