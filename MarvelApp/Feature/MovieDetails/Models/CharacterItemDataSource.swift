//
//  CharacterItemDataSource.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import GenericDataSources

class CharacterItemDataSource: BasicDataSource<Item, ItemViewCell> {
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: ItemViewCell, with item: Item, at indexPath: IndexPath) {
        
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 136, height: 178)
    }
}
