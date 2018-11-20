//
//  UITextFieldReactiveExtension.swift
//  RetNavigator
//
//  Created by Andrey Chernyshev on 01/10/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    var textValue: ControlProperty<String> {
        return base.rx.controlProperty(editingEvents: [.allEditingEvents, .valueChanged, .programmaticChange], getter: { textField -> String in
            return textField.text ?? ""
        }, setter: { textField, value in
            if textField.text != value {
                textField.text = value
                textField.sendActions(for: .programmaticChange)
            }
        })
    }
}

private extension UIControl.Event {
    static let programmaticChange = UIControlEvents(rawValue: 0b0001 << 24)
}
