//
//  Animal.swift
//  EasyPet
//
//  Created by Jorge on 8/15/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import Foundation

class Animal : NSObject{
    var idAnimal        : Int64
    var nombreAnimal    : String
    var idMascota       : Int
    var idRaza          : Int
    var sexo            : Int
    var peso            : Float
    var talla           : Int
    var color           : String
    var esterilizado    : Int
    var cuidados        : String
    
    init(idAnimal : Int64, nombreAnimal : String, idMascota : Int, idRaza : Int, sexo : Int, peso : Float, talla : Int, color : String, esterilizado : Int, cuidados : String) {
        self.idAnimal       = idAnimal
        self.nombreAnimal   = nombreAnimal
        self.idMascota      = idMascota
        self.idRaza         = idRaza
        self.sexo           = sexo
        self.peso           = peso
        self.talla          = talla
        self.color          = color
        self.esterilizado   = esterilizado
        self.cuidados       = cuidados
    }
    
    override init() {
        self.idAnimal       = 0
        self.nombreAnimal   = ""
        self.idMascota      = 0
        self.idRaza         = 0
        self.sexo           = 0
        self.peso           = 0
        self.talla          = 0
        self.color          = ""
        self.esterilizado   = 0
        self.cuidados       = ""
    }
}
