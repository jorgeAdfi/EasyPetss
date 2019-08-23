//
//  DatabaseManager.swift
//  EasyPet
//
//  Created by Jorge on 8/15/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManager {
    
    let animales        = Table("animal")
    let idAnimal        = Expression<Int64>("idAnimal")
    let nombreAnimal    = Expression<String?>("nombreAnimal")
    
    
    let raza = Table("raza")
    let colores = Table("color")
    
    static let shared = DatabaseManager()
    let db: Connection = {
        let path: String = Bundle.main.path(forResource: "EasyPet", ofType: "sqlite")!
        return try! Connection(path, readonly: true)
    }()
    
    func requestForConnection(){
        print("Se ha iniciado la conexion")
    }
    
    func getTiposAnimales() -> [String : Int64]? {
        var animales = [String : Int64]()
        
        do{
            for row in try db.prepare("SELECT * FROM animal") {
                //                print("idAnimal: \(String(describing: row[0]!)), nombreAnimal: \(String(describing: row[1]!))")
                
                animales[row[1] as! String] = (row[0] as! Int64)
            }
            return animales
        }catch{
            print(error)
        }
        
        return nil
    }
    
    func getRazas(idAnimal : String) -> [String : Int64]? {
        var razas = [String : Int64]()
        
        do{
            for row in try db.prepare("SELECT * FROM raza WHERE idAnimal=\(idAnimal)") {
                //                print("idAnimal: \(String(describing: row[1]!)), nombreRaza: \(String(describing: row[2]!))")
                 razas[row[2] as! String] = (row[1] as! Int64)
            }
            return razas
        }catch{
            print(error)
        }
        
        return nil
    }
    
    func getColores() -> [String : Int64]? {
        var colores = [String : Int64]()
        
        do{
            for row in try db.prepare("SELECT * FROM color") {
                //                 print("idColor: \(String(describing: row[0]!)), nombreColor: \(String(describing: row[1]!))")
                colores[row[1] as! String] = row[0] as? Int64
            }
            return colores
        }catch{
            print(error)
        }
        
        return nil
    }
    
    
}
