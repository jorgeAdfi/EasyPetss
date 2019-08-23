//
//  SplashViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/13/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import SwiftGifOrigin



class SplashViewController: UIViewController {

    @IBOutlet weak var loadingDots: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A UIImageView with async loading
        imageView.loadGif(name: "raton")
        loadingDots.loadGif(name: "loading")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    var count = 1
    
    @objc func update() {
        if(count > 0){
            count -= 1
        }else{
            timer?.invalidate()
            self.performSegue(withIdentifier: "conexionInicio", sender: self)
        }
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
