//
//  CharacterItemDataSource.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import GenericDataSources

class CharacterItemDataSource: BasicDataSource<ItemViewModelType, ItemViewCell> {
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: ItemViewCell, with item: ItemViewModelType, at indexPath: IndexPath) {
        cell.configure(viewModel: item)
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 178)
    }
}
