//
//  NetworkAdapter.swift
//  Ryaheen-ios
//
//  Created by Abdelahad on 3/23/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Moya

enum MarvelAPIError:Error {
    case message(String)
    case network
    case mapping
}
struct NetworkAdapter<T:Decodable> {
    
    private let network = Network()
    
    @discardableResult
    func request<R:TargetType>(targetType :R , success  successCallback: @escaping (T) -> Void ,
                                                 error errorCallback : @escaping (MarvelAPIError) -> Void) -> Cancellable{
        
       let task =  network.request(targetType, success: { (response) in
        DispatchQueue.main.async {
            do {
                let  dataResponse = try response.map(APIDataResponse<T>.self)
                successCallback(dataResponse.data)
            }catch {
                if  let object = try? response.map(T.self){
                    successCallback(object)
                }else{
                    errorCallback(.message(""))

                }
            }
        }
        
       
        
        }, error: { (responseError) in
            DispatchQueue.main.async {
                errorCallback(.mapping)

            }

        }
        , failure: { (moyaError) in
            DispatchQueue.main.async {
                errorCallback(.network)

            }

        })
        
        return task
    }
}
