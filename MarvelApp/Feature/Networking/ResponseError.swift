//
//  ResponseError.swift
//  Ryaheen-ios
//
//  Created by Abdelahad on 3/23/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Foundation

struct ResponseError: Decodable {
    let error: String
}

// MARK: Convenience initializers and mutators

extension ResponseError {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ResponseError.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
   }
}
