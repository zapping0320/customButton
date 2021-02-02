//
//  KeyboardViewController.swift
//  customButton
//
//  Created by DD Dev on 2021/02/02.
//  Copyright © 2021 John Kim. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var textfield5: UITextField!
    
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    
    var activeTextField : UITextField? = nil
    var activeTextView: UITextView? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.textfield1.delegate = self
//        self.textfield2.delegate = self
//        self.textfield3.delegate = self
//        self.textfield4.delegate = self
//        self.textfield5.delegate = self
        
        //self.textview1.delegate = self
        //self.textview2.delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
               view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func keyboardWillShow(noti : Notification){
        
        guard let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {

          // if keyboard size is not available for some reason, dont do anything
          return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)//
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
//        var shouldMoveViewUp = false
//
//        // if active text field is not nil
//        if let activeTextField = activeTextField {
//
//          let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
//
//          let topOfKeyboard = self.view.frame.height - keyboardSize.height
//
//          // if the bottom of Textfield is below the top of keyboard, move up
//          if bottomOfTextField > topOfKeyboard {
//            shouldMoveViewUp = true
//          }
//        }
//
//        if(shouldMoveViewUp) {
//          self.view.frame.origin.y = 0 - keyboardSize.height
//        }

       }
       
       @objc func keyboardWillHide(noti : Notification){
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)


        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
//        guard let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//
//          // if keyboard size is not available for some reason, dont do anything
//          return
//        }
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0 + keyboardSize.height
//        }

       }
}

extension KeyboardViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//      // set the activeTextField to the selected textfield
//      self.activeTextField = textField
//    }
//
//    // when user click 'done' or dismiss the keyboard
//    func textFieldDidEndEditing(_ textField: UITextField) {
//      self.activeTextField = nil
//    }

}

extension KeyboardViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeTextView = textView
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       // self.ac
    }
}
