//
//  Usuario.swift
//  EasyPet
//
//  Created by Jorge on 8/13/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import Foundation
import UIKit

class User {
    var idUsuario : String
    var name : String?
    var apellidos : String?
    var facebook_id : String?
    var email : String?
    var picture_url : String?
    var gender : String?
    var birthday : String?
    var password : String?
    
    var imagenUsuario : UIImage?
    
    
    init(idUsuario : String, name : String?, apellidos : String?, facebook_id : String?, email : String?, picture_url : String?, gender : String?, birthday : String?, password : String?, imageUsuario : UIImage?) {
        self.idUsuario = idUsuario
        self.name = name
        self.apellidos = apellidos
        self.facebook_id = facebook_id
        self.email = email
        self.picture_url = picture_url
        self.gender = gender
        self.birthday = birthday
        self.password = password
        self.imagenUsuario = imageUsuario
    }
}
