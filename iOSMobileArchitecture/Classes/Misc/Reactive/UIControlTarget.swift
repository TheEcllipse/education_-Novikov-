//
//  UIControlTarget.swift
//  HuntersMap
//
//  Created by Andrey Chernyshev on 22.08.17.
//  Copyright © 2017 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIControlTarget : NSObject, Disposable {
    typealias Callback = (UIControl) -> Void
    
    let selector: Selector = #selector(UIControlTarget.eventHandler(_:))
    
    weak var control: UIControl?
    var callback: Callback?
    var controlEvents: UIControl.Event
    
    init(control: UIControl, controlEvents: UIControl.Event, callback: @escaping Callback) {
        MainScheduler.ensureExecutingOnScheduler()
        
        self.control = control
        self.controlEvents = controlEvents
        self.callback = callback
        
        super.init()
        
        control.addTarget(self, action: selector, for: controlEvents)
    }
    
    @objc func eventHandler(_ sender: UIControl) {
        if let callback = self.callback, let control = self.control {
            callback(control)
        }
    }
    
    func dispose() {
        MainScheduler.ensureExecutingOnScheduler()
        
        control?.removeTarget(self, action: selector, for: controlEvents)
        callback = nil
    }
}
