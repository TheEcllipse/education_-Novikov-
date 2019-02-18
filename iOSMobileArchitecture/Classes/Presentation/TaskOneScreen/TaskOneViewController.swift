//
//  TaskOneViewController.swift
//  iOSMobileArchitecture
//
//  Created by Serj on 18/02/2019.
//  Copyright © 2019 Andrey Chernyshev. All rights reserved.
//

import UIKit

class TaskOneViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBAction func actionButton(_ sender: Any) {
      /* resultLabel.text = firstTextField.text! + " " + secondTextField.text! */
        
      /* let firstNotOptionalValue = firstTextField.text!
         let secondNotOptionalValue = secondTextField.text!
         resultLabel.text = firstNotOptionalValue + " " + secondNotOptionalValue
      */
        
      /* let firstNotOptionalValue = firstTextField.text ?? " "
        let secondNotOptionalValue = secondTextField.text ?? " "
        resultLabel.text = firstNotOptionalValue + " " + secondNotOptionalValue
      */
        
       guard firstTextField.text == nil || secondTextField.text == nil else {
            let firstNotOptionalValue = firstTextField.text!
            let secondNotOptionalValue = secondTextField.text!
            return resultLabel.text = firstNotOptionalValue + " " + secondNotOptionalValue
        }
    }
}
