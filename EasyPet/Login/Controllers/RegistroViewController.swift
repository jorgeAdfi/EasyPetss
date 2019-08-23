//
//  RegistroViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/12/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DatePickerDialog

class RegistroViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var fondoCampos: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBOutlet weak var apellido2: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fechaNac: UITextField!
    
    let sendRegistroURL = "http://easypets.mx/ws/createUser.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormat()
        setupKeyboard()
        scrollView.contentInsetAdjustmentBehavior = .automatic
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: contentView.frame.height)
        self.view.layoutIfNeeded()
    }
    
   
    
    func setupFormat() {
        scrollView.indicatorStyle = .black
        
        fondoCampos.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        fondoCampos.layer.shadowRadius = 5
        fondoCampos.layer.shadowOpacity = 0.8
        fondoCampos.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        fondoCampos.layer.cornerRadius = 40
        
        subrayarCampo(myTextField: nombre)
        subrayarCampo(myTextField: apellido)
        subrayarCampo(myTextField: apellido2)
        subrayarCampo(myTextField: email)
        subrayarCampo(myTextField: celular)
        subrayarCampo(myTextField: password)
        subrayarCampo(myTextField: fechaNac)
    }

    
     func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentView.frame.height + keyboardSize.height)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: UIScreen.main.bounds.height)
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func subrayarCampo(myTextField : UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.bounds.maxY, width: myTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
    
        myTextField.borderStyle = .none
        myTextField.layer.addSublayer(bottomLine)
    }
  
    
    
    @IBAction func Registrar(_ sender: Any) {
        sendRegistroData(url: sendRegistroURL, parameters: ["nombre" : nombre.text!,
                                                            "apellido" : apellido.text!,
                                                            "apellido2" : apellido2.text!,
                                                            "email" : email.text!,
                                                            "celular" : celular.text!,
                                                            "password" : password.text!,
                                                            "fechaNac" : fechaNac.text!,
                                                            "aceptaPetClub" : "1"])
    }
    
    func sendRegistroData(url: String, parameters: [String:String]?){
        
        var arrayString = [String]()
        
        for param in parameters! {
            arrayString.append("\(param.key)=\(param.value)")
        }
        
        print("DATA: \(arrayString.joined(separator:"&"))")
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
                let responseJSON : JSON = JSON(response.result.value!)
                self.presentAlert(responseJSON["mensajeServer"].stringValue)
                
            }else{
                let responseJSON : JSON = JSON(response.result.value!)
                self.presentAlert(responseJSON["mensajeServer"].stringValue)
            }
        }
    }
    
    func presentAlert(_ alertaTexto : String) {
        let alertView = UIAlertController(title: nil, message: alertaTexto, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(OKAction)
        
        self.present(alertView, animated: true, completion: nil)
        self.view.endEditing(true)
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
    }
    
    @IBAction func chooseFechaNac(_ sender: Any) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.fechaNac.text = formatter.string(from: dt)
            }
        }
    }
    @IBAction func dismissRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
