//
//  KlassAPI.swift
//  Ryaheen-ios
//
//  Created by Abdelahad on 3/24/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Moya

enum CharactersAPI {
    case characters(offset:Int , limit: Int)
    case searchCharacters(nameStartsWith:String)
}

extension CharactersAPI : MarvelPublicAPIService{
    var path: String {
        switch self {
        case .characters,.searchCharacters:
            return "/characters"
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        let stringToHash = ts + AppConfig.PRIVATEKEY + AppConfig.APIKEY
        
        switch self {
        case let .characters(offset, limit):
            return.requestParameters(parameters: ["apikey":AppConfig.APIKEY,"hash" : stringToHash.hashed(.md5)! ,"ts" :ts ,"limit":limit,"offset" : offset], encoding: URLEncoding.default)
            
        case let.searchCharacters(nameStartsWith):
            return.requestParameters(parameters: ["apikey":AppConfig.APIKEY,"hash" : stringToHash.hashed(.md5)! ,"ts" :ts ,"nameStartsWith":nameStartsWith], encoding: URLEncoding.default)

        }
    }
}
