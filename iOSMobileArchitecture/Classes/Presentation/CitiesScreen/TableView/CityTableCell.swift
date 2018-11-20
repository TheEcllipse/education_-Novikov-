//
//  CityTableCell.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 20/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit

class CityTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var didSelected: ((String) -> ())?
    
    func bind(cityElement: CityElement) {
        id = cityElement.id
        
        nameLabel.text = cityElement.name
    }
    
    @IBAction func didTap(_ sender: Any) {
        didSelected?(id)
    }
    
    private var id: String!
}
