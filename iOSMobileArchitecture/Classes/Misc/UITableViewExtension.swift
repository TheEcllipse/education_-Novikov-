//
//  TableViewExtension.swift
//  iOS-Platform
//
//  Created by Andrey Chernyshev on 13.11.16.
//  Copyright © 2016 simbirsoft. All rights reserved.
//

import UIKit

extension UITableView {
    @IBInspectable var estimatedRow: CGFloat {
        set {
            rowHeight = UITableView.automaticDimension
            estimatedRowHeight = newValue
        }
        get {
            return estimatedRowHeight
        }
    }
}
