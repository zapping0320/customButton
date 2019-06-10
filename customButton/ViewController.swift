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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myButton.layer.borderColor = UIColor.black.cgColor
        myButton.layer.borderWidth = 1
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
    
}

