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
}

extension CharactersAPI : MarvelPublicAPIService{
    var path: String {
        switch self {
        case .characters:
            return "/characters"
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        
        switch self {
        case let .characters(offset, limit):
            
            let ts = "\(Date().timeIntervalSinceNow)"
            let stringToHash = ts + AppConfig.PRIVATEKEY + AppConfig.APIKEY 
            
            return.requestParameters(parameters: ["apikey":AppConfig.APIKEY,"hash" : stringToHash.hashed(.md5)! ,"ts" :ts ,"limit":limit,"offset" : offset], encoding: URLEncoding.default)
        }
    }
}
