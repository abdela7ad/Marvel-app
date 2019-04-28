//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation


protocol CharacterInfoViewModelType : CharacterItemViewModelType {
   var characterDescription : String {get}
}

struct ChararcterInfo: CharacterInfoViewModelType {
    var characterDescription: String
    
    var displayName: String
    
    var thumbnailUrl: URL?
}




enum CategoryType:String {
    case comics
    case series
    case event
    case stories
}
struct CategorySection {
    let categoryName :CategoryType
    let category : Category?
}

class CharacterDetailViewModel {
    
    private var characterViewModel :CharacterViewModelType
    
    init(characterViewModel:CharacterViewModelType) {
        self.characterViewModel = characterViewModel
    }
    
    var characterInfo : CharacterInfoViewModelType {
        return ChararcterInfo(characterDescription: characterViewModel.charachterItem.description, displayName: characterViewModel.displayName, thumbnailUrl: characterViewModel.thumbnailUrl)
    }
    var urlElement : [URLElement] {
        return characterViewModel.charachterItem.urls
    }
    
    var categorySection : [CategorySection] {
        
        return [CategorySection(categoryName: .comics, category: characterViewModel.charachterItem.comics),
                CategorySection(categoryName: .event, category: characterViewModel.charachterItem.event),
         CategorySection(categoryName: .series, category: characterViewModel.charachterItem.series),
         CategorySection(categoryName: .stories, category: characterViewModel.charachterItem.stories)
            ].filter({ (section) -> Bool in
                return (section.category != nil  && (section.category?.items.count) ?? 0 > 0)
            })
    }
    
    var relatedLinkLabel: String {
        
        return "RELATED LINKS"
    }
}
