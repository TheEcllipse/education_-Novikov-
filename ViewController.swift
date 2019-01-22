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
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    @IBAction func theButton(_ sender: Any)
    {
        theLabel.text! = textField1.text! + " " + textField2.text!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

