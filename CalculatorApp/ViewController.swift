

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myDisplay: UILabel!
    
    var check:Bool = false
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let current_digit = sender.currentTitle!
        
        if check==true {
            let current_display = myDisplay.text!
            myDisplay.text = current_display + current_digit
        }
        else {
            myDisplay.text = sender.currentTitle!
            check = true
        }
        
    }
    
    var displayValue: Double {
        get {
            return Double(myDisplay.text!)!
        }
        set {
            myDisplay.text = String(newValue)
        }
    }
    
    private var calculatorModel = CalculatorModel()
    @IBAction func operationPressed(_ sender: UIButton) {
        
        
        
        calculatorModel.setOperend(displayValue)
        calculatorModel.performOperend(sender.currentTitle!)
        displayValue = calculatorModel.getResult()!
        check = false
    }
}

