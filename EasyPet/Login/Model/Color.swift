//
//  Color.swift
//  EasyPet
//
//  Created by Jorge on 8/15/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import Foundation

class Color {
    var idColor        : Int64
    var nombreColor    : String?
    
    init(idColor : Int64, nombreColor : String) {
        self.idColor        = idColor
        self.nombreColor    = nombreColor
    }
    
    init() {
        self.idColor   = 0
        self.nombreColor = ""
    }
}
