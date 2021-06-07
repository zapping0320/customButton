//
//  LottieViewController.swift
//  customButton
//
//  Created by DD Dev on 2021/06/07.
//  Copyright © 2021 John Kim. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {

    @IBOutlet weak var loadingAnimView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            let loadingAnim = Animation.named("coffee")
            self.loadingAnimView?.animation = loadingAnim
            self.loadingAnimView?.contentMode = .scaleAspectFit
            self.loadingAnimView?.loopMode = .loop
            self.loadingAnimView?.play()
        }
    }
   
    @IBAction func closeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
