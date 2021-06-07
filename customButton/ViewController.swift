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
    
    @IBOutlet weak var barCodeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myButton.layer.borderColor = UIColor.black.cgColor
        myButton.layer.borderWidth = 1
        
        setDefaultTextField()
        
        self.mySwitch.delegate = self
        
        applyBarcode()
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
        self.basicTextField.text = dateString
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
    
    
    @IBAction func alert2(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "협압 입력", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "수축기"
        })
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "이완기"
        })
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
            let textfields = alert.textFields
            
            print("수축기 - \(alert.textFields?[0].text)")
            print("이완기 - \(alert.textFields?[1].text)")
            
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: false)
    }
    
    
    @IBAction func alert1(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "협당 입력", preferredStyle: .alert)
               alert.addTextField(configurationHandler: { (textField) in
                   textField.placeholder = "혈당"
               })
               
               
               alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                   let textfields = alert.textFields
                   
                   print("혈당 - \(alert.textFields?[0].text)")
                 
                   
               }))
               
               alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
               self.present(alert, animated: false)
    }
    
    func applyBarcode() {
        let barcodeString = "0000123456"
        
        guard let uiimage = barcodeString.generateBarcodeImage(isQRCode: false) else { return }
        
        self.barCodeImageView.image = uiimage
    }
    
    
    @IBAction func testLottieView(_ sender: Any) {
        let lotttieVC = LottieViewController()
        self.present(lotttieVC, animated: true, completion: nil)
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

extension String {
    /** 바코드 이미지 만들기 - Parameter isQRCode: true(QRCode), false(Code128) */
    func generateBarcodeImage(isQRCode: Bool) -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        
        var filterName = "CICode128BarcodeGenerator"
        if isQRCode { filterName = "CIQRCodeGenerator" }
        if let filter = CIFilter(name: filterName) {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform)
            {
                return UIImage(ciImage: output)
                
            }
            
        }
        return nil
        
    }
}



