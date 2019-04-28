//
//  MovieListViewModel.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Signals




enum CharachterListViewState {
    case empty
    case loaded(items:[CharacterViewModelType])
}

class CharachterListViewModel  {
    
   
    var mentorViewState  = Signal<CharachterListViewState>()
    var didSelectCharacter  = Signal<CharacterViewModelType>()

    func getMovieList(){
        NetworkAdapter<CharacterItems>().request(targetType: CharactersAPI.characters(offset: 0, limit: 10), success: { (characterItems) in
            let list = characterItems.results.map({CharacterViewModel(charachterItem: $0)})
            self.mentorViewState.fire(.loaded(items: list))
        }) { (error) in
        }
    }
    
    func showCharacter(characterViewModel:CharacterViewModelType){
       didSelectCharacter.fire(characterViewModel)
    }
}
