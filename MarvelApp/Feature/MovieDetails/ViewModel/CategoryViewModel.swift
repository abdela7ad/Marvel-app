//
//  CategoryViewModel\.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation

protocol CategoryViewModelType {
    var sectionName : String {get}
    var items : [ItemViewModelType] {get}
}

protocol ItemViewModelType {
    var imageURL : URL? {get}
    var characterName : String {get}
}


class CategoryViewModel: CategoryViewModelType {

    private  var category : Category?
    private  var type : CategoryType

    init(type:CategoryType ,category:Category?) {
        self.type = type
        self.category = category
    }
    
    var sectionName: String {
        return type.rawValue
    }
    
    var items: [ItemViewModelType] {
        guard let category = category else {
            return []
        }
        return  category.items.map({ItemViewModel(item: $0)})
    }
}



class ItemViewModel: ItemViewModelType {
    private  var item : Item
    
    init(item:Item) {
        self.item = item
    }
    
    var imageURL: URL?{
     return URL(string: "https://static.comicvine.com/uploads/scale_small/11125/111253019/6532464-return_of_wolverine_vol_1_2_textless.jpg")
    }
    
    var characterName: String{
     return item.name
    }
    
}
