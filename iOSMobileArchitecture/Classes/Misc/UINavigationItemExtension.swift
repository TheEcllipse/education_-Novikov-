//
//  UINavigationItemExtension.swift
//  DrSmart
//
//  Created by Andrey Chernyshev on 31.07.2018.
//  Copyright © 2018 SimbirSoft. All rights reserved.
//

import UIKit

extension UINavigationItem {
    @IBInspectable var titleLocalize: String? {
        set {
            if let newValue = newValue {
                title = NSLocalizedString(newValue, comment: "")
            }
        }
        get {
            return title
        }
    }
}
