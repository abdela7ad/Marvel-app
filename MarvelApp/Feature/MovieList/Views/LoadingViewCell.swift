//
//  LoadingViewCell.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class LoadingViewCell: UITableViewCell {
    @IBOutlet private weak var indicator : UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicator.startAnimating()
    }
}
