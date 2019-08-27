//
//  MascotaSectionController.swift
//  EasyPet
//
//  Created by Jorge on 8/27/19.
//  Copyright © 2019 EasyPet. All rights reserved.
//

import UIKit
import IGListKit

class MascotaSectionController: ListSectionController {
    var entry: Animal!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 130, height: 150)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "NibSelfSizingCell",
                                                                   bundle: nil,
                                                                   for: self,
                                                                   at: index) as? NibSelfSizingCell else {
                                                                    fatalError() }
        
        nibCell.contentLabel.text = entry.nombreAnimal
        nibCell.image.image = UIImage(named: "img1")
        nibCell.image.layer.masksToBounds = true
        nibCell.image.layer.cornerRadius = nibCell.image.frame.width/2

        cell = nibCell
        return cell
    }
    
    override func didUpdate(to object: Any) {
        entry = object as? Animal
    }
}
