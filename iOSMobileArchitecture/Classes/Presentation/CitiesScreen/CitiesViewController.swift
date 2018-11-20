//
//  CitiesViewController.swift
//  iOSMobileArchitecture
//
//  Created by Andrey Chernyshev on 12/11/2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CitiesViewController: UIViewController {
    @IBOutlet weak var tableView: CitiesTableView!
    
    let viewModel = CitiesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel
            .elements
            .drive(tableView.rx.elements)
            .disposed(by: disposeBag)
        
        tableView
            .didAddFavorite
            .bind(to: viewModel.addFavorite)
            .disposed(by: disposeBag)
        
        tableView
            .didRemoveFavorite
            .bind(to: viewModel.removeFavorite)
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}
