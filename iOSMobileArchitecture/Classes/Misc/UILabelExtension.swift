//
//  LabelExtension.swift
//  iOS-Platform
//
//  Created by Andrey Chernyshev on 29.11.16.
//  Copyright © 2016 simbirsoft. All rights reserved.
//

import UIKit

extension UILabel {
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
}
