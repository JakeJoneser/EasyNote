//
//  ChoosePersonPassViewController.swift
//  EasyNotes
//

import UIKit

class ConfirmPasswordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var firstTextField : UITextField!
    @IBOutlet var secondTextField : UITextField!
    @IBOutlet var thirdTextField : UITextField!
    @IBOutlet var fourthTextField : UITextField!
    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
    @IBOutlet var fourthView : UIView!
    @IBOutlet var continueButton : UIButton!
    //contain previous contoller text filed values.
   
    var selectedText = [String]()
    var conformArray = [String]()
     var tagColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        fourthTextField.delegate = self
        
        // Do any additional setup after loading the view.
        firstTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        secondTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        thirdTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        fourthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        //for aliging tetx on center
         textAlignmetCenter()
        //to add all the text file value into one array
        continueButton.isEnabled = false
        print(selectedText)
    }
    func textAlignmetCenter(){
        firstTextField.textAlignment = .center
        firstTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 48.0)
        secondTextField.textAlignment = .center
        secondTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 48.0)
        thirdTextField.textAlignment = .center
        thirdTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 48.0)
        fourthTextField.textAlignment = .center
        fourthTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 48.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func backButtonClicked(){
       navigationController?.popViewController(animated: true)
    }
    func addtextFieldToArray(){
        conformArray.removeAll()
        conformArray.append(firstTextField.text ?? "nil")
        conformArray.append(secondTextField.text ?? "nil" )
        conformArray.append(thirdTextField.text ?? "nil")
        conformArray.append(fourthTextField.text ?? "nil")
    }
//    func checkTextFiledIsEmpty() -> Bool{
//        if firstTextField.text == "" ||  secondTextField.text == "" || thirdTextField.text == "" || fourthTextField.text == "" {
//            let alertController = UIAlertController(title: "password not entered correctly", message: "check whether all filed are entered properly", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                UIAlertAction in
//                NSLog("OK Pressed")
//            }
//            alertController.addAction(okAction)
//            // Present the controller
//            self.present(alertController, animated: true, completion: nil)
//            return false
//    }
//    else{
//        return true
//         }
//    }
    
    func checkTextFiledMatches() {
        
        let str1 = selectedText.joined()
        let str2 = conformArray.joined()
         let password:String = str1
          let defaults = UserDefaults.standard
       
        if str1 == str2{
            self.firstView.backgroundColor = .green
            self.secondView.backgroundColor = .green
            self.thirdView.backgroundColor = .green
            self.fourthView.backgroundColor = .green
            defaults.set(password, forKey: "password")
            print(password)
            continueButton.isEnabled = true
        }else{
            self.firstView.backgroundColor = .red
            self.secondView.backgroundColor = .red
            self.thirdView.backgroundColor = .red
            self.fourthView.backgroundColor = .red
            continueButton.isEnabled = false
        }
       
    }
    //to move cursor from one text field to other
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if let lastChar = text?.last{
            textField.text = String(lastChar)
        }
        if  textField.text?.count == 1 {
            switch textField{
            case firstTextField:
                secondTextField.becomeFirstResponder()
            case secondTextField:
                thirdTextField.becomeFirstResponder()
            case thirdTextField:
                fourthTextField.becomeFirstResponder()
            case fourthTextField:
                fourthTextField.resignFirstResponder()
                //call validation logic
                addtextFieldToArray()
                checkTextFiledMatches()
                
                
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case firstTextField:
                firstTextField.becomeFirstResponder()
            case secondTextField:
                firstTextField.becomeFirstResponder()
            case thirdTextField:
                secondTextField.becomeFirstResponder()
            case fourthTextField:
                thirdTextField.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            print("cursor not entered into text field")
        }
    }
    @IBAction func continueButtonClicked(){
        
        if NoteManager.shared.changePasswordMode{
             self.navigationController?.popToRootViewController(animated: true)
        }else{
            if navigationController?.viewControllers[1] is OnboardingPage2ViewController && navigationController?.viewControllers.count             == 4{
                //Coming from first onboarding
                performSegue(withIdentifier: "goToDashboard", sender: nil)
                NoteManager.shared.updateOnBoardingStatus(true)
            }else{
                showNotesList()
            }
        }
    }
    
    
    func showNotesList(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableViewController") as! NoteListInTableViewController
        nextViewController.tagType = .personal
        nextViewController.tagColor = tagColor
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
