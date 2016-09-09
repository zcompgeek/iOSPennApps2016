//
//  ViewController.swift
//  CalcTest2
//
//  Created by Zach Costa on 9/9/16.
//  Copyright © 2016 WillowTree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    var beginNewNumber = true
    var savedNumber = 0
    var mode: Mode = .Equal

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func digitButtonPressed(_ sender: UIButton) {
        if let newDigit = sender.currentTitle,
            let currentDigits = resultLabel.text {
            if beginNewNumber {
                beginNewNumber = false
                resultLabel.text = newDigit
            } else {
                resultLabel.text = currentDigits + newDigit
            }
        }
    }

    @IBAction func clearButtonPressed(_ sender: UIButton) {
        resultLabel.text = "0"
        savedNumber = 0
        mode = .Equal
    }

    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        if let operatorText = sender.currentTitle,
            let currentLabel = resultLabel.text,
            let currentNumber = Int(currentLabel),
            let mode = Mode(string: operatorText) {
            if case .Equal = mode {
                savedNumber = self.mode.operate(a: savedNumber, b: currentNumber)
                resultLabel.text = "\(savedNumber)"
            } else {
                savedNumber = currentNumber
            }
            self.mode = mode
            beginNewNumber = true
        }
    }

    enum Mode {
        case Equal, Add, Sub, Mult

        func operate(a: Int, b: Int) -> Int {
            switch self {
            case .Add:
                return a + b
            case .Mult:
                return a * b
            case .Sub:
                return a - b
            case .Equal:
                return a
            }
        }

        init?(string: String) {
            switch string {
            case "+":
                self = .Add
            case "-":
                self = .Sub
            case "x":
                self = .Mult
            case "=":
                self = .Equal
            default:
                return nil
            }
        }
    }

}

