//
//  CharacterDetailDatasource.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import GenericDataSources
import Signals

class CharacterDetailDatasource: CompositeDataSource {
    
    var onDidSelectBack =  Signal<Void>()

    init() {
        super.init(sectionType: .single)
    }
    
    var characterDetails: CharacterDetailViewModel? {
        didSet {
            
            // remove all existing data sources
            removeAllDataSources()
            guard let characterDetails = characterDetails else {
                return
            }
            
            // Add Character Info
            let characterInfo = CharacterInfoDataSource()
            characterInfo.setSelectionHandler(UnselectableSelectionHandler())
            characterInfo.items = [characterDetails.characterInfo]
            add(characterInfo)

            characterInfo.onBack.subscribe(with: self) { (_) in
                self.onDidSelectBack.fire(Void())
            }
            
            let categoryDataSource = CategoryDataSource()
            categoryDataSource.setSelectionHandler(UnselectableSelectionHandler())
            categoryDataSource.items = characterDetails.categorySection
            add(categoryDataSource)
            
            
            
            // add quick link label
            let relatedLinkLabelDataSource = RelatedLinkLabelDataSource()
            relatedLinkLabelDataSource.setSelectionHandler(UnselectableSelectionHandler())
            relatedLinkLabelDataSource.items = [characterDetails.relatedLinkLabel]
            add(relatedLinkLabelDataSource)
            
            let relatedLinkDataSource = RelatedLinkDataSource()
            relatedLinkDataSource.items = characterDetails.urlElement
            add(relatedLinkDataSource)

        }
    }
}



class CharacterInfoDataSource: BasicDataSource<CharacterInfoViewModelType, CharacterInfoViewCell> {

     var onBack =  Signal<Void>()
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CharacterInfoViewCell, with item: CharacterInfoViewModelType, at indexPath: IndexPath) {
        cell.configure(viewModel: item)
        cell.onBackHandler = {[weak self] in
            self?.onBack.fire(Void())
        }
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

class CategoryDataSource: BasicDataSource<CategoryViewModelType, CategoryViewCell> {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CategoryViewCell, with item: CategoryViewModelType, at indexPath: IndexPath) {
        cell.configure(viewModel: item)        
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 178)
    }
}



class RelatedLinkLabelDataSource: BasicDataSource<String, RelatedLinkLabelViewCell> {
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: RelatedLinkLabelViewCell, with item: String, at indexPath: IndexPath) {
         cell.titleLabel.text = item

    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

class RelatedLinkDataSource: BasicDataSource<URLElement, RelatedLinkViewCell> {
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: RelatedLinkViewCell, with item: URLElement, at indexPath: IndexPath) {
        cell.configure(item:item)
    }
    
   
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

