//
//  Raza.swift
//  EasyPet
//
//  Created by Jorge on 8/15/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import Foundation

class Raza {
    var idAnimal        : Int64
    var nombreRaza    : String?
    
    init(idAnimal : Int64, nombreRaza : String) {
        self.idAnimal       = idAnimal
        self.nombreRaza     = nombreRaza
    }
    
    init() {
        self.idAnimal   = 0
        self.nombreRaza = ""
    }
}
