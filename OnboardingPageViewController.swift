//
//  ViewController.swift
//  EasyNotes
//

import UIKit

class OnboardingPageViewController: UIViewController {
    //for changing the color of uilabel text
    var myString:NSString = "EasyNote.."
    var myMutableString = NSMutableAttributedString()
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
   
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Mark : to get orange color for  easy text in label
       myMutableString = NSMutableAttributedString(string: myString as String, attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSRange(location:0,length:4))
        // set label Attribute
        titleLabel.attributedText = myMutableString
       //adding border to views
        firstView.layer.borderWidth = 2.0
        firstView.layer.borderColor = UIColor.lightGray.cgColor
        firstView.layer.cornerRadius = 5
        secondView.layer.borderWidth = 2.0
        secondView.layer.borderColor = UIColor.lightGray.cgColor
        secondView.layer.cornerRadius = 5
        thirdView.layer.borderWidth = 2.0
        thirdView.layer.borderColor = UIColor.lightGray.cgColor
        thirdView.layer.cornerRadius = 5
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func continueButtonClicked(){
        performSegue(withIdentifier: "goToNext", sender: nil)
    }
}

