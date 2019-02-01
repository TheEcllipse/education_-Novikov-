//
//  ViewController.swift
//  taskTwo
//
//  Created by education on 28.01.2019.
//  Copyright © 2019 education. All rights reserved.
//

import UIKit
import Foundation

protocol Furniture{
    var material: String {get}
    var year: Int {get}
    var company: String {get}
    var customer: String {get}
}

class Table: Furniture {
    var tableMaterial: String
    var tableYear: Int
    var tableCompany: String
    var tableCustomer: String
    
    var material: String{
        return tableMaterial
    }
    var year: Int{
        return tableYear
    }
    var company: String{
        return tableCompany
    }
    var customer: String{
        return tableCustomer
    }
    
    init(tableMaterial: String, tableYear: Int , tableCompany: String, tableCustomer: String){
        self.tableMaterial = tableMaterial
        self.tableYear = tableYear
        self.tableCompany = tableCompany
        self.tableCustomer = tableCustomer
    }
    
    func complete () -> String {
        return "Стол \(tableMaterial) изготовлен в \(tableYear) году компанией \(tableCompany) по заказу компании \(tableCustomer)"
    }
}

class Chair: Furniture {
    var chairMaterial: String
    var chairYear: Int
    var chairCompany: String
    var chairCustomer: String
    
    var material: String{
        return chairMaterial
    }
    var year: Int{
        return chairYear
    }
    var company: String{
        return chairCompany
    }
    var customer: String{
        return chairCustomer
    }
    
    init(chairMaterial: String, chairYear: Int , chairCompany: String, chairCustomer: String){
        self.chairMaterial = chairMaterial
        self.chairYear = chairYear
        self.chairCompany = chairCompany
        self.chairCustomer = chairCustomer
    }
    
    func complete () -> String {
        return "Стул \(chairMaterial) изготовлен в \(chairYear) году компанией \(chairCompany) по заказу компании \(chairCustomer)"
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttomAction(_ sender: Any) {
        var tableFinal = Table(tableMaterial: "деревянный", tableYear: 2018, tableCompany: "ООО Строим Столы", tableCustomer: "ООО Нужны Столы")
        var chairFinal = Chair(chairMaterial: "кожаный", chairYear: 2015, chairCompany: "ООО Строим Стулья", chairCustomer: "ООО Нужны Стулья")
        if textField.text == "Стол"{
            labelField.text! = tableFinal.complete()
        }
        if textField.text == "Стул"{
            labelField.text! = chairFinal.complete()
        }
    }
}

