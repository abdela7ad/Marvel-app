//
//  CategoryViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    let dataSource = CharacterItemDataSource()
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.ds_register(cellNib: ItemViewCell.self)
        collectionView.ds_useDataSource(dataSource)
    }
    
    override var layoutMargins: UIEdgeInsets {
        get {
            let layoutMargins = super.layoutMargins
            return UIEdgeInsets(top: layoutMargins.top, left: 15, bottom: layoutMargins.bottom, right: layoutMargins.right)
        } set {
            super.layoutMargins = newValue
        }
    }
    
}
