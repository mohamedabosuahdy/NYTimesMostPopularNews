//
//  RouterRequestConvertible.swift
//  NetworkLayerSample
//
//  Created by Ismail Ahmed on 12/18/18.
//  Copyright © 2018 LinkDev. All rights reserved.
//

import Alamofire
typealias QueryItems = [String : String]
protocol BaseAPIConfiguration: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var environment : Environment { get }
    
}

extension BaseAPIConfiguration {
    
    private var baseHeaders : [String : String] {
        return [
           "Content-Type" : "application/json",
           "Accept" : "application/json"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        // URL Components
        var components = environment.components
        components.path = path
        
        // Query Items
        components.queryItems = [URLQueryItem(name: AppConstants.apiKeyName, value: AppConstants.NYTimesAPIKey)]
        // Request
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        let reqHeaders = baseHeaders + environment.headers + headers
        reqHeaders.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    var environment : Environment {
        return .staging
    }
}



