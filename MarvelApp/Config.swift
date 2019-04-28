//
//  Config.swift
//  SocialAPP
//
//  Created by Abdelahad on 3/2/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import CommonCrypto



struct AppConfig {
    static let MarvelBaseURL = "https://gateway.marvel.com:443/v1/public"
    static let APIKEY = "9dc92a8baf54c551b4cfce57be2129f5"
    static let PRIVATEKEY = "bc9da9414c52bbc703417cdbbd18c4c0ca107356"

    
    static var hash :String {
        guard let md5 = ("1" + APIKEY + PRIVATEKEY).hashed(.md5)   else {
            return ""
        }
        return md5
    }
    
   
}


