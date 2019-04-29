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
    
    private var items = [CharacterViewModelType]()
    private var offset = 0
    private let limit = 20
    private var total = 0

    func getMovieList(){
        NetworkAdapter<CharacterItems>().request(targetType: CharactersAPI.characters(offset: offset, limit: limit), success: { (characterItems) in
            self.total = characterItems.total
            self.items += characterItems.results.map{CharacterViewModel(charachterItem: $0)}
            self.mentorViewState.fire(.loaded(items: self.items))
        }) { (error) in
        }
    }
    
    func next(){
        offset = offset + limit
        guard total < offset else {
            return
        }
        getMovieList()
    }
    func showCharacter(characterViewModel:CharacterViewModelType){
       didSelectCharacter.fire(characterViewModel)
    }
}
