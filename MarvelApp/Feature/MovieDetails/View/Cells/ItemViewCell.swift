//
//  ItemViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class ItemViewCell: UICollectionViewCell {

    @IBOutlet weak var charaterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(viewModel:ItemViewModelType){
        charaterName.text = viewModel.characterName
        characterImage.kf.setImage(with: viewModel.imageURL)
    }

    
}
