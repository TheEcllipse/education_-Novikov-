//
//  TaskTwoViewController.swift
//  iOSMobileArchitecture
//
//  Created by Serj on 19/02/2019.
//  Copyright © 2019 Andrey Chernyshev. All rights reserved.
//

import UIKit

protocol Furniture {
    var material: String {get}
    var year: Int {get}
    var company: String {get}
    var customer: String {get}
    
    func complete () -> String
}

struct Table: Furniture {
    var material: String
    var year: Int
    var company: String
    var customer: String

    func complete () -> String {
        return "Стол \(material) изготовлен в \(year) году компанией \(company) по заказу компании \(customer)"
    }
}

class Chair: Furniture {
    var material: String
    var year: Int
    var company: String
    var customer: String
    
    init(material: String, year: Int , company: String, customer: String) {
        self.material = material
        self.year = year
        self.company = company
        self.customer = customer
    }
    
    func complete () -> String {
        return "Стул \(material) изготовлен в \(year) году компанией \(company) по заказу компании \(customer)"
    }
}

class TaskTwoViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func actionButton(_ sender: Any) {
        let tableFinal = Table(material: "деревянный", year: 2018, company: "ООО Строим Столы", customer: "ООО Нужны Столы")
        let chairFinal = Chair(material: "кожаный", year: 2015, company: "ООО Строим Стулья", customer: "ООО Нужны Стулья")
        if textField.text == "Стол" {
            resultLabel.text = tableFinal.complete()
        }
        if textField.text == "Стул" {
            resultLabel.text = chairFinal.complete()
        }
    }
}
