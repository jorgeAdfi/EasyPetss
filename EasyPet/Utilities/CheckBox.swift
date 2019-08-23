//
//  CheckBox.swift
//  EasyPet
//
//  Created by Jorge on 8/15/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checkedImage = UIImage(named: "checked")
    let uncheckedImage = UIImage(named:"unchecked")
    
    
    ///Bool property
    var isChecked:Bool = false{
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            }else{
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
//    override func awakeFromNib() {
//        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//    }
    
//    @objc func buttonClicked(sender: UIButton){
//        if sender == self{
//            if isChecked == true{
//                isChecked = false
//            }else{
//                isChecked = true
//            }
//        }
//    }
}
