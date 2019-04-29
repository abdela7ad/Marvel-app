//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Signals


protocol CharacterInfoViewModelType : CharacterItemViewModelType {
   var characterDescription : String {get}
}



struct ChararcterInfo: CharacterInfoViewModelType {
    var characterDescription: String
    
    var displayName: String
    
    var thumbnailUrl: URL?
}




enum CategoryType : String {
    case comics = "Comics"
    case series = "Series"
    case event  = "Event"
    case stories = "Stories"
}
struct CategorySection {
    let categoryName :CategoryType
    let category : Category?
}

class CharacterDetailViewModel {
    
    private var characterViewModel :CharacterViewModelType
    var onDidSelectBack = Signal<Void>()
    init(characterViewModel:CharacterViewModelType) {
        self.characterViewModel = characterViewModel
    }
    
    var characterInfo : CharacterInfoViewModelType {
        return ChararcterInfo(characterDescription: (characterViewModel.charachterItem.description).isEmpty ? "-" :characterViewModel.charachterItem.description, displayName: characterViewModel.displayName, thumbnailUrl: characterViewModel.thumbnailUrl)
    }
    
    var urlElement : [URLElement] {
        return characterViewModel.charachterItem.urls
    }
    
    var categorySection : [CategoryViewModelType] {
        
         return
            [CategoryViewModel(type: .comics, category:  characterViewModel.charachterItem.comics),
            CategoryViewModel(type: .series, category:  characterViewModel.charachterItem.series),
            CategoryViewModel(type: .event, category:  characterViewModel.charachterItem.event),
            CategoryViewModel(type: .stories, category:  characterViewModel.charachterItem.stories)].filter({$0.items.count > 0})
    
          }
   
    
    var relatedLinkLabel: String {
        return "RELATED LINKS"
    }
    
    
    
}
