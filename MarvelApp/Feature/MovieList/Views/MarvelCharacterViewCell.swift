//
//  MarvelCharacterViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit
import Kingfisher

class MarvelCharacterViewCell: UITableViewCell {

    @IBOutlet private weak var characterImage : UIImageView!
    @IBOutlet private weak var characterName : PaddingLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(cellViewModel:CharacterItemViewModelType) {
        characterName.text = cellViewModel.displayName
        characterImage.kf.setImage(with: cellViewModel.thumbnailUrl)
    }
}
