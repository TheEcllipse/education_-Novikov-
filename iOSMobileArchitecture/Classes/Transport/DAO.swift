//
//  DAO.swift
//  AutoCheck
//
//  Created by Andrey Chernyshev on 10.03.2018.
//

import RxSwift
import RxCocoa
import RealmSwift

class DAO {
    func loadData<E, R: Object>(realmType: R.Type, filter: NSPredicate? = nil, map: @escaping (R) -> (E)) -> Observable<[E]> {
        return Observable.create { observer in
            
            guard let realm = try? Realm(configuration: DAO.realmConfiguration) else {
                observer.onError(Problem())
                return Disposables.create()
            }
            
            var results = realm.objects(R.self)
            if filter != nil {
                results = results.filter(filter!)
            }
            
            let objects: [E] = results.map { obj -> E in
                return map(obj)
            }
            
            observer.onNext(objects)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func saveData<E, R: Object>(entities: [E], map: @escaping (E) -> (R)) -> Observable<Void> {
        return Observable.create { observer in
            
            guard let realm = try? Realm(configuration: DAO.realmConfiguration) else {
                observer.onError(Problem())
                return Disposables.create()
            }
            
            let objects = entities.map { entity -> R in
                return map(entity)
            }
            
            do {
                try realm.write{
                    realm.add(objects, update: true)
                }
                
                observer.onNext(Void())
                observer.onCompleted()
            }
            catch _ {
                observer.onError(Problem())
            }
            
            return Disposables.create()
        }
    }
    
    func deleteData<R: Object>(realmType: R.Type, filter: NSPredicate? = nil) -> Observable<Void> {
        return Observable.create { observer in
            
            guard let realm = try? Realm(configuration: DAO.realmConfiguration) else {
                observer.onError(Problem())
                return Disposables.create()
            }
            
            do {
                try realm.write {
                    var results = realm.objects(R.self)
                    if filter != nil {
                        results = results.filter(filter!)
                    }
                    
                    realm.delete(results)
                }
                
                observer.onNext(Void())
                observer.onCompleted()
            }
            catch _ {
                observer.onError(Problem())
            }
            
            return Disposables.create()
        }
    }
    
    private static let realmConfiguration = Realm.Configuration(
        schemaVersion: 1,
        deleteRealmIfMigrationNeeded: true
    )
}
