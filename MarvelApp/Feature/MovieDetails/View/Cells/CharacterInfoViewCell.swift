//
//  CharacterInfoViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class CharacterInfoViewCell: UITableViewCell {
    
    @IBOutlet private weak var characterImage : UIImageView!
    @IBOutlet private weak var title : UILabel!
    @IBOutlet private weak var content : UILabel!
    
    var onBackHandler  = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func backHandler(sender:UIButton) {
        onBackHandler()
    }
    
    func configure(viewModel:CharacterInfoViewModelType){
        characterImage.kf.setImage(with: viewModel.thumbnailUrl)
        title.text = viewModel.displayName
        content.text = viewModel.characterDescription
    }
    
}
