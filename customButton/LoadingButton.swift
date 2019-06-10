//
//  LoadingButton.swift
//  customButton
//
//  Created by 김동현 on 09/06/2019.
//  Copyright © 2019 John Kim. All rights reserved.
//

import UIKit

class LoadingButton: UIButton {

    private let inidicator = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //init
        
        self.addSubview(inidicator)
        
        inidicator.style = .gray
        inidicator.startAnimating()
        inidicator.translatesAutoresizingMaskIntoConstraints = false
        inidicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inidicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    func startLoading() {
        inidicator.isHidden = false
    }
    
    func stopLoading() {
        inidicator.isHidden = true
    }
}
