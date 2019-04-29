//
//  CharacterListDatasource.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import GenericDataSources

final class CharacterListDatasource: SegmentedDataSource {
    
    private let loading = LoadingDataSource()
    private let charactersItems = CharactersDataSource()
    
    // reload data on index change
    override var selectedDataSourceIndex: Int {
        didSet {
            ds_reusableViewDelegate?.ds_reloadData()
        }
    }
    
    override init() {
        super.init()
        loading.items = [Void()]
        add(loading)
        add(charactersItems)
    }
    
    func setCharactersItems(items:[CharacterViewModelType]) {
        charactersItems.items = items
    }
}

final class LoadingDataSource: BasicDataSource<Void, LoadingViewCell> {
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
}

final class CharactersDataSource: BasicDataSource<CharacterViewModelType,MarvelCharacterViewCell> {
   
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: MarvelCharacterViewCell, with item: CharacterViewModelType, at indexPath: IndexPath) {
        cell.configure(cellViewModel: item)
    }
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: UITableView.automaticDimension)
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}



