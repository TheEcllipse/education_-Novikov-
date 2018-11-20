//
//  UIScrollViewReactiveExtension.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 01/10/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var contentInsets: Binder<UIEdgeInsets> {
        return Binder(base) { base, insets in
            base.contentInset = insets
        }
    }
}
