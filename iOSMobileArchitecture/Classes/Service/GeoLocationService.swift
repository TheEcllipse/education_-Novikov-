//
//  GeoLocationService.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 16/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

class GeoLocationService {
    static func continuoslyKeepLocation() -> Observable<Coordinate> {
        return Observable<Coordinate>.create { observer in
            let manager = CLLocationManager()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = 10
            
            manager.rx.didChangeAuthorizationStatus { status in
                switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    manager.startUpdatingLocation()
                    manager.rx.didUpdateLocations { locations in
                        if let location = locations.last {
                            observer.onNext(Coordinate(
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude)
                            )
                        }
                    }
                case .notDetermined:
                    manager.requestWhenInUseAuthorization()
                default:
                    break
                }
            }
            
            manager.rx.didFailWithError { error in
                observer.onError(Problem(message: "error_location_failed".localized))
            }
            
            return Disposables.create {
                manager.stopUpdatingLocation()
            }
        }
    }
    
    static func justDetermineCurrentLocation() -> Observable<Coordinate> {
        return Observable<Coordinate>.create { observer in
            let manager = CLLocationManager()
            manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            manager.rx
                .didChangeAuthorizationStatus { (status: CLAuthorizationStatus) in
                    if status == .authorizedWhenInUse || status == .authorizedAlways {
                        manager.requestLocation()
                        manager.rx
                            .didUpdateLocations { locations in
                                if let location = locations.last {
                                    observer.onNext(Coordinate(
                                        latitude: location.coordinate.latitude,
                                        longitude: location.coordinate.longitude)
                                    )
                                    observer.onCompleted()
                                }
                        }
                    }
                    
                    if status == .notDetermined {
                        manager.requestWhenInUseAuthorization()
                    }
                    
                    if status == .denied {
                        observer.onError(Problem(message: "error_location_failed".localized))
                    }
            }
            
            manager.rx.didFailWithError { (error: Error) in
                observer.onError(Problem(message: "error_location_failed".localized))
            }
            
            return Disposables.create {
                manager.stopUpdatingLocation()
            }
        }
    }
}

private class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    
    public init(locationManager: CLLocationManager) {
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register {
            RxCLLocationManagerDelegateProxy(locationManager: $0)
        }
    }
    
    public static func currentDelegate(for object: CLLocationManager) -> CLLocationManagerDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: CLLocationManagerDelegate?, to object: CLLocationManager) {
        object.delegate = delegate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateLocationsHandler?(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        changeAuthorizationHandler?(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithErrorHandler?(error)
    }
    
    func setUpdateLocationsHandler(_ handler: (([CLLocation]) -> ())?) {
        self.updateLocationsHandler = handler
    }
    
    func setChangeAuthorizationHandler(_ handler: ((CLAuthorizationStatus) -> ())?) {
        self.changeAuthorizationHandler = handler
    }
    
    func setDidFailWithErrorHandler(_ handler: ((Error) -> ())?) {
        self.didFailWithErrorHandler = handler
    }
    
    private var updateLocationsHandler: (([CLLocation]) -> ())?
    private var changeAuthorizationHandler: ((CLAuthorizationStatus) -> ())?
    private var didFailWithErrorHandler: ((Error) -> ())?
}

extension Reactive where Base: CLLocationManager {
    func didUpdateLocations(handler: (([CLLocation]) -> ())?) {
        rx_delegate.setUpdateLocationsHandler(handler)
    }
    
    func didChangeAuthorizationStatus(handler: ((CLAuthorizationStatus) -> ())?) {
        rx_delegate.setChangeAuthorizationHandler(handler)
    }
    
    func didFailWithError(handler: ((Error) -> ())?) {
        rx_delegate.setDidFailWithErrorHandler(handler)
    }
    
    fileprivate var rx_delegate: RxCLLocationManagerDelegateProxy {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
}

