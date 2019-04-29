//
//  SearchViewModel.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Signals


class SearchViewModel {
    
    var onDidSelect  = Signal<CharacterViewModelType>()
    var onDismiss  = Signal<Void>()

    var items  = Signal<[CharacterViewModelType]>()

    func searchCharacter(query:String){
        NetworkAdapter<CharacterItems>().request(targetType: CharactersAPI.searchCharacters(nameStartsWith: query), success: { (characterItems) in
            self.items.fire(characterItems.results.map{CharacterViewModel(charachterItem: $0)})
        }) { (error) in
        }
    }
}
