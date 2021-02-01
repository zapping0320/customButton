//
//  KeyboardViewController.swift
//  customButton
//
//  Created by DD Dev on 2021/02/02.
//  Copyright © 2021 John Kim. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var textfield5: UITextField!
    
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textfield1.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
               view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//          self.view.endEditing(true)
//    }
    @objc func tap(gesture: UITapGestureRecognizer) {
        //self.titleTextField.resignFirstResponder()
        for view in self.stackView.arrangedSubviews {
            if view is UITextField || view is UITextView {
                view.resignFirstResponder()
            }//|| view is
        }
    }

}
