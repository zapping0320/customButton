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
        
       makeIndicator()
    }
    
    private func makeIndicator() {
        self.addSubview(inidicator)
        
        //inidicator.isHidden = true//그냥 쓰면 화면 그리고 나서 적용되게 할 수 없다.
        DispatchQueue.main.async {
            self.inidicator.isHidden = true
        }
        
        inidicator.style = .gray
        inidicator.startAnimating()
        inidicator.translatesAutoresizingMaskIntoConstraints = false
        inidicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inidicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    func startLoading() {
        let titleColor = self.titleLabel?.textColor
        self.setTitleColor(titleColor?.withAlphaComponent(0), for: UIControl.State.normal)
        inidicator.isHidden = false
    }
    
    func stopLoading() {
        let titleColor = self.titleLabel?.textColor
        self.setTitleColor(titleColor?.withAlphaComponent(1), for: UIControl.State.normal)
        inidicator.isHidden = true
    }
}
