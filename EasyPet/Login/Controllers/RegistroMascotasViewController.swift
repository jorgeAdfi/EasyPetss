//
//  RegistroMascotasViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/13/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import SearchTextField
import Alamofire
import SwiftyJSON

class RegistroMascotasViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var tipoMascota: SearchTextField!
    @IBOutlet weak var raza: SearchTextField!
    @IBOutlet weak var peso: UITextField!
    @IBOutlet weak var talla: SearchTextField!
    @IBOutlet weak var color: SearchTextField!
    @IBOutlet weak var cuidados: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var opcionMacho: CheckBox!
    @IBOutlet weak var opcionHembra: CheckBox!
    @IBOutlet weak var opcionEsterelizado: CheckBox!
    
    let tallas = ["Pequeño / Small"     : "0",
                  "Miniatura"           : "1",
                  "Mini"                : "2",
                  "Mediano / Medium"    : "3",
                  "Grande / Large"      : "4",
                  "Gigante / Giant"     : "5",
                  "Extra Grande / Extra Large" : "6"]
    
    var idAnimalTipo : String = "1";
    var idAnimalRaza : Int64 = 0;
    var idColor : Int64 = 0
    var idTalla : String = ""
    
    let sendRegistroMascotaURL = "http://easypets.mx/ws/saveMascota.php"
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        accionarSubrayar()
        opcionMacho.isChecked = true
        setupDropDowns()
    }
    
    func setupDropDowns() {
        var arrayMascotas = [String]()
        var arrayColores = [String]()
        var arrayRazas = [String]()
        var arrayTallas = [String]()
        let razas = [Raza]()
        
        talla.theme.font = UIFont.systemFont(ofSize: 20)
        talla.theme.cellHeight = 50
        talla.maxResultsListHeight = 200
        talla.theme.bgColor = UIColor.white
        talla.theme.separatorColor = UIColor.lightGray
        
        for t in tallas{
            arrayTallas.append(t.key)
        }
        
        talla.filterStrings(arrayTallas)
        talla.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.talla.text = item.title
            self.idTalla = self.tallas[item.title]!
            print("el idTalla \(self.idTalla)")
        }
        
        
        color.theme.font = UIFont.systemFont(ofSize: 20)
        color.theme.cellHeight = 50
        color.maxResultsListHeight = 200
        color.theme.bgColor = UIColor.white
        color.theme.separatorColor = UIColor.lightGray
        
        let colorMascotaDictionary = DatabaseManager.shared.getColores()
        print(colorMascotaDictionary!)
        
        for color in colorMascotaDictionary! {
            arrayColores.append(color.key)
        }
        
        color.filterStrings(arrayColores)
        
        color.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.color.text = item.title
            self.idColor = colorMascotaDictionary![item.title]!
            print("el idcolor \(self.idColor)")
        }
        

        
        tipoMascota.theme.font = UIFont.systemFont(ofSize: 20)
        tipoMascota.theme.cellHeight = 50
        tipoMascota.maxResultsListHeight = 200
        tipoMascota.theme.bgColor = UIColor.white
        tipoMascota.theme.separatorColor = UIColor.lightGray
        
        let tipoMascotaDictionary = DatabaseManager.shared.getTiposAnimales()
        
        for pet in tipoMascotaDictionary!{
            arrayMascotas.append(pet.key)
        }
        
        tipoMascota.filterStrings(arrayMascotas)
        
        
        var razasDict = [String : Int64]()
        tipoMascota.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tipoMascota.text = item.title
            self.idAnimalTipo = item.title
            
            
            
            
            if let tipoM = tipoMascotaDictionary{
                razasDict  = DatabaseManager.shared.getRazas(idAnimal: String(tipoM[self.idAnimalTipo]!))!
            }
            
            for r in razasDict{
                arrayRazas.append(r.key)
            }
            
            self.raza.filterStrings(arrayRazas)
        }
        
        print("este es el idRaza \(String(describing: idAnimalTipo))")
        
        raza.theme.font = UIFont.systemFont(ofSize: 20)
        raza.theme.cellHeight = 50
        raza.maxResultsListHeight = 200
        raza.theme.bgColor = UIColor.white
        raza.theme.separatorColor = UIColor.lightGray
        
        for r in razas{
            arrayRazas.append(r.nombreRaza!)
        }
        
        raza.filterStrings(arrayRazas)
        
        raza.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.raza.text = item.title
            self.idAnimalRaza = razasDict[item.title]!
        }
    }
    
    @IBAction func machoPressed(_ sender: Any) {
        opcionMacho.isChecked   = true
        opcionHembra.isChecked  = false
    }
    
    @IBAction func hembraPressed(_ sender: Any) {
        opcionHembra.isChecked  = true
        opcionMacho.isChecked   = false
    }
    
    @IBAction func esterelizadoPressed(_ sender: CheckBox) {
        if sender.isChecked == true{
            sender.isChecked = false
        }else{
            sender.isChecked = true
        }
    }
    
    
    func accionarSubrayar(){
        subrayarCampo(nombre)
        subrayarCampo(raza)
        subrayarCampo(peso)
        subrayarCampo(talla)
        subrayarCampo(color)
        subrayarCampo(tipoMascota)
    }
    
    func subrayarCampo(_ myTextField : UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.bounds.maxY, width: myTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.orange.cgColor
        
        myTextField.borderStyle = .none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(scrollView.contentSize.height)
    }
    
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentView.frame.height + keyboardSize.height + 20)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1031.0)
        self.view.layoutIfNeeded()
    }
    
    @IBAction func Registrar(_ sender: Any) {
        
        if let nombreAnimal = nombre.text{
            sendRegistroData(url: sendRegistroMascotaURL, parameters: ["nombre" : nombreAnimal,
                                                                       "idTipoMascota" : idAnimalTipo,
                                                                       "idRaza" : "\(idAnimalRaza)",
                                                                       "sexo" :  opcionMacho.isChecked == true ? "1" : "0",
                                                                       "peso" : peso.text!,
                                                                       "talla" : idTalla,
                                                                       "color" : "\(idColor)",
                                                                       "esterilizado" : opcionEsterelizado.isChecked == true ? "1" : "0",
                                                                       "cuidados": cuidados.text,
                                                                       "idUsuario":"9"])
        }else{
            self.presentAlert("Llenar todos los campos")
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    @IBAction func openPhoto(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func seleccionarTalla(_ sender: Any) {
        
    }
    
    @IBAction func RegistrarMascota(_ sender: Any) {
        
    }
}
