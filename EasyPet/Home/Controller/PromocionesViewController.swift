//
//  PromocionesViewController.swift
//  EasyPet
//
//  Created by Jorge on 8/21/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit

class PromocionesViewController: UIViewController {
    
    @IBOutlet weak var collectionPromociones: UICollectionView!
    
    let mascotasTest = ["demo1",
                        "demo2",
                        "demo3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PromocionesViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mascotasTest.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promoCell", for: indexPath)
        
        if let imageView = cell.viewWithTag(100) as? UIImageView{
            imageView.image = UIImage.init(named: mascotasTest[indexPath.row])
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 8
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selecciono item")
    }
    
    
}
