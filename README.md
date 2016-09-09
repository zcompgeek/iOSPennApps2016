# iOSPennApps2016
Important docs for getting started with iOS

Below you will find a rough outline of the steps used to get to a "completed" version of the basic calculator project

# Step 1 - Add labels to Storyboard
# Step 2 - Get labels to display number 1 when button is pressed

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func digitButtonPressed(_ sender: UIButton) {
        resultLabel.text = sender.currentTitle
    }


}

# Step 3 - Add stack views, rest of numbers, and auto layout constraints
	Duplicate numbers, press stack views button, add edge constraints to horizontal stack views
# Step 4 - Concatenate new numbers onto display label

    @IBAction func digitButtonPressed(_ sender: UIButton) {
        if let newDigit = sender.currentTitle,
            let currentDigits = resultLabel.text {
            if currentDigits == "0" {
                resultLabel.text = newDigit
            } else {
                resultLabel.text = currentDigits + newDigit
            }
        }
    }
	
# Step 5 - Add addition button, equals, and clear

   class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    var beginNewNumber = true
    var savedNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func digitButtonPressed(_ sender: UIButton) {
        if let newDigit = sender.currentTitle,
            let currentDigits = resultLabel.text {
            if beginNewNumber {
                resultLabel.text = newDigit
            } else {
                resultLabel.text = currentDigits + newDigit
            }
            beginNewNumber = false
        }
    }

    @IBAction func clearButtonPressed(_ sender: UIButton) {
        resultLabel.text = "0"
        savedNumber = 0
    }

    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        if let operatorText = sender.currentTitle,
            let currentLabel = resultLabel.text,
            let currentValue = Int(currentLabel) {
            if operatorText == "+" {
                savedNumber = currentValue
            } else if operatorText == "=" {
                resultLabel.text = "\(savedNumber + currentValue)"
            }
            beginNewNumber = true
        }
    }


}

# Step 6 - Add subtraction, multiplication

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
