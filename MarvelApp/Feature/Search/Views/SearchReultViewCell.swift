//
//  SearchReultViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class SearchReultViewCell: UITableViewCell {

    @IBOutlet private weak var characterImage : UIImageView!
    @IBOutlet private weak var characterName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
    func configure(cellViewModel:CharacterItemViewModelType) {
        characterName.text = cellViewModel.displayName
        characterImage.kf.setImage(with: cellViewModel.thumbnailUrl)
    }
    
}
