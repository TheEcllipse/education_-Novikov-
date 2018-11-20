//
//  FavoriteCityTableElement.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 20/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit

class FavoriteCityTableElement: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateAddedLabel: UILabel!
    
    var didSelected: ((String) -> ())?
    
    func bind(favoriteCityElement: FavoriteCityElement) {
        id = favoriteCityElement.id
        
        nameLabel.text = favoriteCityElement.name
        dateAddedLabel.text = favoriteCityElement.dateAdded
    }
    
    @IBAction func didTap(_ sender: Any) {
        didSelected?(id)
    }
    
    private var id: String!
}
