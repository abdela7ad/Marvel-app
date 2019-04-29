//
//  RelatedLinkViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class RelatedLinkViewCell: UITableViewCell {

    @IBOutlet weak var linkLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func configure(item:URLElement) {
        linkLabel.text = item.type.rawValue.capitalized
    }
    
}
