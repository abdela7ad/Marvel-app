//
//  DataResponse.swift
//  Ryaheen-ios
//
//  Created by Abdelahad on 3/23/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation

struct APIDataResponse<T:Decodable> : Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String
    let data: T
}

extension APIDataResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(APIDataResponse.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
  }
}
