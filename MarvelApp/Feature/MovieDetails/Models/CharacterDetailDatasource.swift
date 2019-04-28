//
//  CharacterDetailDatasource.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import GenericDataSources

class CharacterDetailDatasource: CompositeDataSource {
    
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

            
            let categoryDataSource = CategoryDataSource()
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

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CharacterInfoViewCell, with item: CharacterInfoViewModelType, at indexPath: IndexPath) {
        cell.configure(viewModel: item)
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

class CategoryDataSource: BasicDataSource<CategorySection, CategoryViewCell> {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CategoryViewCell, with item: CategorySection, at indexPath: IndexPath) {
        cell.dataSource.items = item.category?.items ?? []
        cell.collectionView.reloadData()

        
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 178)
    }
}



class RelatedLinkLabelDataSource: BasicDataSource<String, RelatedLinkLabelViewCell> {
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: RelatedLinkLabelViewCell, with item: String, at indexPath: IndexPath) {
        // cell.label.text = item

    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

class RelatedLinkDataSource: BasicDataSource<URLElement, RelatedLinkViewCell> {
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: RelatedLinkViewCell, with item: URLElement, at indexPath: IndexPath) {
        //cell.label.text = item.name
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, didSelectItemAt indexPath: IndexPath) {
       // let item = self.item(at: indexPath)
        //UIApplication.shared.openURL(item.url)
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

