//
//  CitiesTableView.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 12/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CitiesTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    let didAddFavorite = PublishRelay<String>()
    let didRemoveFavorite = PublishRelay<String>()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = _elements[indexPath.row]
        
        switch element {
        case .city(let cityElement):
            let cell = dequeueReusableCell(withIdentifier: "CityTableCell", for: indexPath) as! CityTableCell
            
            cell.didSelected = { [weak self] id in
                self?.didAddFavorite.accept(id)
            }
            
            cell.bind(cityElement: cityElement)
            
            return cell
        case .favorite(let favoriteCityElement):
            let cell = dequeueReusableCell(withIdentifier: "FavoriteCityTableElement", for: indexPath) as! FavoriteCityTableElement
            
            cell.didSelected = { [weak self] id in
                self?.didRemoveFavorite.accept(id)
            }
            
            cell.bind(favoriteCityElement: favoriteCityElement)
            
            return cell
        }
    }
    
    fileprivate var _elements: [CityTableElement] = []
}

extension Reactive where Base: CitiesTableView {
    var elements: Binder<[CityTableElement]> {
        return Binder(base) { base, elements in
            base._elements = elements
            base.reloadData()
        }
    }
}
