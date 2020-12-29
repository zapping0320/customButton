//
//  ViewController.swift
//  customButton
//
//  Created by 김동현 on 09/06/2019.
//  Copyright © 2019 John Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: LoadingButton!
    
    var isLoading = false
    
    let pickerView = UIDatePicker()
    
    @IBOutlet weak var mySwitch: CustomSwitch!
    
    @IBOutlet weak var basicTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myButton.layer.borderColor = UIColor.black.cgColor
        myButton.layer.borderWidth = 1
        
        setDefaultTextField()
        
        self.mySwitch.delegate = self
    }

    @IBAction func doAction(_ sender: LoadingButton) {
        //isLoading = !isLoading
        isLoading.toggle()
        
        if(isLoading){
            self.myButton.startLoading()
        }
        else{
            self.myButton.stopLoading()
        }
        
    }
    
    func  setDefaultTextField()  {
        self.basicTextField.clearButtonMode = .never
        
        guard let clearBtn = self.basicTextField.value(forKey: "clearButton") as? UIButton else {
            return
        }
        clearBtn.setImage(#imageLiteral(resourceName: "downButton"), for: .normal)
        
        setPicker()
        
    }
    
    public func setPicker() {
        pickerView.datePickerMode = .date
        pickerView.locale = Locale(identifier: "ko_kr")
        pickerView.timeZone = TimeZone(identifier: "KST")
        pickerView.date = Date()
        self.basicTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem.init(title: "확인", style: .done, target: self, action: #selector(donePicker(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem.init(title: "취소", style: .done, target: self, action: #selector(cancelPicker(_:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.basicTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(_ sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self.pickerView.date)
        print("selected -\(dateString)")
        hide()
    }
    
    @objc func cancelPicker(_ sender: UIBarButtonItem) {
        print("cancel")
        hide()
    }
    
    public func hide() {
        //_ = self.resignFirstResponder()
        self.basicTextField.resignFirstResponder()
    }
    
}

extension ViewController: CustomSwitchDelegate {
    func switchWillValueChange(sender: CustomSwitch, currentValue: Bool) {
        sender.isOn = !sender.isOn
        if sender.isOn {
            print("switch on")
        }
        else {
            print("switch off")
        }
    }
    
    func switchDidValueChange(sender: CustomSwitch, currentValue: Bool) {
        
    }
    
    
}

