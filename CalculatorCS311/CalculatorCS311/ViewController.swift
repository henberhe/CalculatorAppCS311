//
//  ViewController.swift
//  CalculatorCS311
//
//  Created by Henok on 11/23/19.
//  Copyright © 2019 Henok. All rights reserved.
//

import UIKit

enum modes {
    case notSet
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = .notSet
    var saveNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func updateText(){
       guard let labelInt: Int = Int(labelString) else {
        label.text = "Error"
         return
        }
        if currentMode == .notSet {
            saveNum = labelInt
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
    }
    
    func changeModes(newMode: modes){
        if saveNum == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    @IBAction func tappedPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func tappedMinus(_ sender: Any) {
        changeModes(newMode:.subtraction)
    }
    
    @IBAction func tappedMultip(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    @IBAction func tappedEqual(_ sender: Any) {
        guard let labelInt :Int = Int(labelString) else {
            label.text = "Error"
            return
        }
        if currentMode == modes.notSet || lastButtonWasMode {
            return
        }
        if currentMode == .addition {
            saveNum += labelInt
        } else if currentMode == .subtraction {
            saveNum -= labelInt
        } else if currentMode == .multiplication {
            saveNum *= labelInt
        }
        currentMode = .notSet
        labelString = "\(saveNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func tappedClear(_ sender: Any) {
        labelString = "0"
        saveNum = 0
        label.text = "0"
        currentMode = .notSet
        lastButtonWasMode = false
        
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        guard let stringValue: String = sender.titleLabel?.text else {
            label.text = "Error"
            return
        }
        if lastButtonWasMode{
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString  = labelString.appending(stringValue)
        updateText()
    }
    
    
}

