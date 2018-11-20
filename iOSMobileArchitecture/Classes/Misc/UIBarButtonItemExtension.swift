//
//  UIBarButtonItemExtension.swift
//  RetNavigator
//
//  Created by Yegor on 11.10.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
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
