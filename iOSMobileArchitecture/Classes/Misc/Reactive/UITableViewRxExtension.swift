//
//  UITableViewRxExtension.swift
//  DrSmart
//
//  Created by Andrey Chernyshev on 18.07.2018.
//  Copyright © 2018 SimbirSoft. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    var contentInsets: Binder<UIEdgeInsets> {
        return Binder(base) { base, insets in
            base.contentInset = insets
        }
    }
}
