//
//  CharacterItemViewModel.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation



protocol CharacterViewModelType : CharacterItemViewModelType {
    var charachterItem : CharacterItem {set get}
}

protocol CharacterItemViewModelType {
    var displayName : String {get}
    var thumbnailUrl : URL? {get}
}
class CharacterViewModel : CharacterViewModelType{
    
    internal var  charachterItem : CharacterItem
    
    init(charachterItem : CharacterItem) {
        self.charachterItem = charachterItem
    }
}


extension CharacterViewModel : CharacterItemViewModelType {
    var displayName: String {
        return charachterItem.name
    }
    
    var thumbnailUrl: URL? {
        let thumbnail = charachterItem.thumbnail
        let fullPath  = thumbnail.path + "." + thumbnail.thumbnailExtension
        guard let fullPuth = fullPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            else {return nil}
        return URL(string: fullPuth)
    }
    
}


