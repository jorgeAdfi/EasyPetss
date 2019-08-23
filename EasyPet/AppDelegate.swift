//
//  AppDelegate.swift
//  EasyPet
//
//  Created by Jorge on 8/12/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var login : UINavigationController?
    var home  : UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        DatabaseManager.shared.requestForConnection()

        
        if getDatoPref(dato: "isLogged") == nil || getDatoPref(dato: "isLogged") == "0"{
            print("settle is logged a 0")
            guardarIsLogged("0")
        }else{
            guardarIsLogged("1")
            iniciarHome()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getDatoPref(dato : String) -> String?{
        let prefs = UserDefaults.standard
        let data = prefs.string(forKey: dato)
        return data
    }
    
    func guardarDatoPref(dato : String, etiqueta : String){
        let prefs = UserDefaults.standard
        prefs.set(dato, forKey: etiqueta)
    }
    
    func IniciarLogin(){
        let mainStoryBoard = UIStoryboard.init(name: "Login", bundle: nil)
        let controller = mainStoryBoard.instantiateViewController(withIdentifier: "Login") as? UINavigationController
        window?.rootViewController = controller
        login = controller
    }
    
    func guardarIsLogged(_ yesOrNo : String){
        print("guardando is logged %@")
        guardarDatoPref(dato: yesOrNo, etiqueta: "isLogged")
    }

    func iniciarHome(){
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        home = mainStoryBoard.instantiateViewController(withIdentifier: "ViewIntroTab") as? UITabBarController
        home?.delegate = self
        window?.rootViewController = home
    }
    
    func saveUser (usuario:User){
        print("SAVE USER \(usuario.idUsuario)")
        let shared = UserDefaults.init(suiteName: "group.org.easypet.app")//TODO CAMBIAR GROUP
        shared?.set(usuario.idUsuario, forKey: "idUsuario")
        shared?.synchronize()
        
        guardarDatoPref(dato: usuario.idUsuario, etiqueta: "idUsuario")
        guardarDatoPref(dato: usuario.name ?? "", etiqueta: "name")
        guardarDatoPref(dato: usuario.picture_url ?? "", etiqueta: "picture_url")
        guardarDatoPref(dato: usuario.email ?? "", etiqueta: "email")
        guardarDatoPref(dato: usuario.gender ?? "", etiqueta: "gender")
        guardarDatoPref(dato: usuario.email ?? "", etiqueta: "email")
        guardarDatoPref(dato: usuario.gender ?? "", etiqueta: "birthday")
    }
    
    func getIdUsuario() -> String?{
        let prefs = UserDefaults.standard
        let idUsuario = prefs.string(forKey: "idUsuario")
        
        if idUsuario == ""{
        
        }else{
            let shared = UserDefaults.init(suiteName: "group.org.easypet.app")
            shared?.set(idUsuario, forKey: "idUsuario")
            shared?.synchronize()
            print("Guarda Usuario")
        }
        
        return idUsuario
    }
}

