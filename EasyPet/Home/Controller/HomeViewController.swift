//
//  HomeViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/20/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let get_MascotasURL = "http://easypets.mx/ws/getMascotas.php"

    @IBOutlet weak var sideBar          : UIView!
    @IBOutlet weak var leftMargin       : NSLayoutConstraint!
    @IBOutlet weak var sideBarTableView : UITableView!
    
    @IBOutlet weak var collectionViewPets: UICollectionView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var viewFondo: UIView!
    
    let opcionesMenu = [0:"Mi cuenta",
                        1:"Favoritos",
                        2:"Promociones",
                        3:"Recomendaciones",
                        4:"Ayuda",
                        5:"¿Quiéres ser proveedor?",
                        6:"Pet People"]
    
    
    let mascotasTest = ["img1",
                        "img2",
                        "img3",
                        "img4",
                        "img1",
                        "img2",
                        "img3",
                        "img4"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideBarColor()
        setupCollectionView()
        setupViewFondo()
        scrollView.contentInsetAdjustmentBehavior = .automatic
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: contentView.frame.height)
        self.view.layoutIfNeeded()
    }
    
    func getMisMascotas(){
        if let idUsuario = appDelegate.getIdUsuario(){
            getMascotasData(url: get_MascotasURL, parameters: ["idUsuario" : idUsuario])
        }
    }
    
    func getMascotasData(url: String, parameters: [String:String]?){
        
        var arrayString = [String]()
        
        for param in parameters! {
            arrayString.append("\(param.key)=\(param.value)")
        }
        
        print("DATA: \(arrayString.joined(separator:"&"))")
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
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
    
    func setupViewFondo(){
        viewFondo.clipsToBounds = true
        viewFondo.layer.cornerRadius = 20
        viewFondo.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        viewFondo.layer.masksToBounds = false
        viewFondo.layer.shadowRadius = 10
        viewFondo.layer.shadowOpacity = 0.3
        viewFondo.layer.shadowColor = UIColor.lightGray.cgColor
        viewFondo.layer.shadowOffset = CGSize(width: 0.5 , height:-15)
    }
    
    func setupCollectionView(){
        collectionViewPets.indicatorStyle = .white
    }
    
    func setupSideBarColor(){
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = sideBar.frame.size
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors =
            [UIColor.init(hexString: "2a2928").cgColor, UIColor.init(hexString: "242021").cgColor]
        sideBar.layer.insertSublayer(gradientLayer, at: 0)
        
        sideBar.layer.masksToBounds = true
        sideBar.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        sideBar.layer.shadowRadius = 5
        sideBar.layer.shadowOpacity = 0.8
        sideBar.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        sideBar.layer.cornerRadius = 8
    }
    
    func subrayarBoton(_ button : UIButton) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: button.bounds.maxY, width: button.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.orange.cgColor
        button.layer.addSublayer(bottomLine)
    }
    
    @IBAction func openSideBar(_ sender: Any) {
//        print("open")
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.6,initialSpringVelocity: 1, options: [.curveEaseIn,.curveEaseOut], animations: {
            self.leftMargin.constant = self.leftMargin.constant == -10 ?  -self.sideBar.frame.width :  -10
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcionesMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text  = opcionesMenu[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font =  cell.textLabel?.font.withSize(15.5)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.6,initialSpringVelocity: 1, options: [.curveEaseIn,.curveEaseOut], animations: {
            self.leftMargin.constant = self.leftMargin.constant == -10 ?  -self.sideBar.frame.width :  -10
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mascotasTest.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mascotaCell", for: indexPath)
        
        if let imageView = cell.viewWithTag(100) as? UIImageView{
            imageView.image = UIImage.init(named: mascotasTest[indexPath.row])
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 40
        }
        
        return cell
    }
    
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
