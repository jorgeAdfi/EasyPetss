//
//  LoginViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/12/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let loginURL = "http://easypets.mx/ws/login.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormat()
        // Do any additional setup after loading the view.
    }
    
    func setupFormat() {
        imageContainer.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        imageContainer.layer.shadowRadius = 5
        imageContainer.layer.shadowOpacity = 0.8
        imageContainer.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        subrayarCampo(myTextField: email)
        subrayarCampo(myTextField: password)
    }
    
    func subrayarCampo(myTextField : UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.bounds.maxY, width: myTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        
        myTextField.borderStyle = .none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    
    func Login(url: String, parameters: [String:String]?){
        
        var arrayString = [String]()
        
        for param in parameters! {
            arrayString.append("\(param.key)=\(param.value)")
        }
        
        print("DATA: \(arrayString.joined(separator:"&"))")
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
                let responseJSON : JSON = JSON(response.result.value!)
                print(responseJSON)
                self.presentAlert(responseJSON["mensajeServer"].stringValue)
                
                let idUsuario = responseJSON["idUsuario"].stringValue
                
                self.appDelegate.guardarIsLogged("1")
                let usuario = User(idUsuario: idUsuario, name: nil, apellidos: nil, facebook_id: nil, email: nil, picture_url: nil, gender: nil, birthday: nil, password: "", imageUsuario: nil)
                self.appDelegate.guardarDatoPref(dato: idUsuario, etiqueta: "idUsuario")
                self.appDelegate.saveUser(usuario: usuario)
                self.appDelegate.iniciarHome()
                
            }else{
                let responseJSON : JSON = JSON(response.result.value!)
                self.presentAlert(responseJSON["mensajeServer"].stringValue)
            }
        }
    }
    
//    [appDelegate GuardarIsLogged:@"1"];
//    usuario.idUsuario = idUsuario;
//    [appDelegate GuardarDatoPref:idUsuario etiqueta:@"idUsuario"];
//    [appDelegate SaveUser:usuario];
//    [appDelegate IniciarHome];
//    [self EnviarDatosWatch:@"0"];
    
    func presentAlert(_ alertaTexto : String) {
        let alertView = UIAlertController(title: nil, message: alertaTexto, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(OKAction)
        self.present(alertView, animated: true) {
            self.view.endEditing(true)
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        Login(url: loginURL, parameters: ["email" : email.text!,
                                          "password" : password.text!])
    }
    
    @IBAction func LoginFacebook(_ sender: Any) {
        
    }
    
    @IBAction func SignInGoogle(_ sender: Any) {
        
    }
    
    @IBAction func Registrar(_ sender: Any) {
        self.performSegue(withIdentifier: "conexionRegistro", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
