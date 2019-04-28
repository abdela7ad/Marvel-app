//
//  Network.swift
//  SocialAPP
//
//  Created by Abdelahad on 3/1/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Moya



protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy =    cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}

struct Network {
    
    init() {}
    
    private  var  provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true) , CachePolicyPlugin()], trackInflights: true)

    @discardableResult
    func request<T: TargetType>(_ target: T, success successCallback: @escaping (Response) -> Void,
                                error errorCallback : @escaping (ResponseError?)->Void ,
                                failure failureCallback: @escaping(MoyaError)->Void) -> Cancellable {
        let task = provider.requestNormal(MultiTarget(target), callbackQueue: DispatchQueue.main, progress: nil) { (result) in
            switch result {
            case  .success(let response):
                
                do {
                    // filter succes code from 200...299
                    let response = try response.filterSuccessfulStatusCodes()
                    successCallback(response)
                    // success code
                } catch  {
                    errorCallback(try? response.map(ResponseError.self))
                }
                
               // print(value.map(response)!)
                
            case let .failure(error):
                // catch error from Moya
                failureCallback(error)
            }
        }
        return task
    }
    
    
    
    
    @discardableResult
    func requestComposit<T: TargetType>(_ target: T, success successCallback: @escaping (Response) -> Void,
                                error errorCallback : @escaping (ResponseError?)->Void ,
                                failure failureCallback: @escaping(MoyaError)->Void,
                                progress progressCallback: @escaping(ProgressResponse)->Void) -> Cancellable {
        
        let task = provider.requestNormal(MultiTarget(target), callbackQueue: DispatchQueue.main, progress: { (progressResponse) in
            progressCallback(progressResponse)
        }) { (result) in
            switch result {
            case  .success(let response):
                
                do {
                    // filter succes code from 200...299
                    let response = try response.filterSuccessfulStatusCodes()
                    successCallback(response)
                    // success code
                } catch  {
                    errorCallback(try? response.map(ResponseError.self))
                }
                
                // print(value.map(response)!)
                
            case let .failure(error):
                // catch error from Moya
                failureCallback(error)
             }
          }
        
        return task
    }
    
}
