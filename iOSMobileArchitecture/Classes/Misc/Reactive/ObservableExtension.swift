//
//  ObservableExtension.swift
//  DrSmart
//
//  Created by Andrey Chernyshev on 17.07.2018.
//  Copyright © 2018 SimbirSoft. All rights reserved.
//

import RxSwift

extension ObservableType {
    static func create<T>(with element: T) -> Observable<T> {
        return Observable<T>.create { observer in
            observer.onNext(element)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func consumeError() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func retryWithDelay(timeInterval: Double) -> Observable<E> {
        return retryWhen { error -> Observable<Void> in
            return error
                .flatMap { _ -> Observable<Void> in
                    return Observable<Void>
                        .create(with: Void())
                        .delay(timeInterval, scheduler: MainScheduler.instance)
                }
        }
    }
    
    func once() -> Observable<E> {
        return single()
            .catchError { _ -> Observable<E> in
                return Observable.never()
            }
    }
}
