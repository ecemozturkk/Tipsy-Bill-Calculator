//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalValue = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //Dismiss the keyboard when the user taps on one of the tip values
        if billTextField.isEditing {
               billTextField.endEditing(true)
           }
        
        //Deselect all tip buttons at the beginning
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Trigger the button that IBAction selected
        sender.isSelected = true
        
        //Get the current title of the button that was pressed
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title, then turn it back into a String
        let buttonTitlePlain = String(buttonTitle.dropLast())
        
        //Turn the String into a Double
        let buttonTitleNumber = Double(buttonTitlePlain)!
        
        //Divide the percent expressed out of 100 into a decimal (10 becomes 0.1)
        tip = buttonTitleNumber / 100
        
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        print(tip)
        print(splitNumberLabel.text!)
        
        //When the button is pressed, it checks if there is text in the billTextField, and if there is, it gets the text and prints it to the console.
        if let billAmount = billTextField.text {
            print("Bill amount: \(billAmount)")
            billTotal = Double(billAmount)!
            
            //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
            let final = billTotal * (1 + tip) / Double(numberOfPeople)
            
            //Round the final price to 2 decimal places and turn it into a String
            let finalDec = String(format: "%.2f", final)
            
            finalValue = finalDec
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.finalValue = finalValue
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
    
}

