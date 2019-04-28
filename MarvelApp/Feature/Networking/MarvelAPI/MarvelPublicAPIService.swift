//
//  MOIAPIServices.swift
//  SocialAPP
//
//  Created by Abdelahad on 3/1/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Moya

protocol MarvelPublicAPIService :TargetType{}

extension MarvelPublicAPIService  {
    var baseURL: URL {
        guard  let url = URL(string: AppConfig.MarvelBaseURL) else {
            fatalError("Corrupted Base URL please check it\(AppConfig.MarvelBaseURL)")
        }
        return url
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String : String]? {
        return ["accept" : "application/json"]
    }
}
