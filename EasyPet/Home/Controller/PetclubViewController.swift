//
//  PetclubViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/20/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit

class PetclubViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var sideBar: UIView!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var sideBarTableView: UITableView!
    
    
    
    let opcionesMenu = [0:"Mi cuenta",
                        1:"Favoritos",
                        2:"Promociones",
                        3:"Recomendaciones",
                        4:"Ayuda",
                        5:"¿Quiéres ser proveedor?",
                        6:"Pet People"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideBarColor()
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
    
    @IBAction func openSideBar(_ sender: Any) {
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
