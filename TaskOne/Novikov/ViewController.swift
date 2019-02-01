//
//  ViewController.swift
//  Novikov
//
//  Created by user on 15.01.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var textFieldFirst: UITextField!
    @IBOutlet weak var textFieldSecond: UITextField!
    
    @IBAction func theButton(_ sender: Any){
        theLabel.text! = textFieldFirst.text! + " " + textFieldSecond.text!
    }
}

