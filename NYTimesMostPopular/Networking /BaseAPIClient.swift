//
//  BaseAPIClient.swift
//  NetworkLayerSample
//
//  Created by Ismail Ahmed on 12/18/18.
//  Copyright © 2018 LinkDev. All rights reserved.
//
import Alamofire

class BaseAPIClient: NSObject {
    
   
    private static let sessionManager = SessionManager()
    
    
    private static func handleResponse<T:Decodable>(_ response: DataResponse<Any>, decoder: JSONDecoder = JSONDecoder(), completion: ((_ result: Result<T>) -> Void)?) {
        switch response.result {
        case .success:
            do {
                let variable = try decoder.decode(T.self, from: response.data!)
                completion?(.success(variable))
            } catch {
                completion?(.failure(error))
            }
            
        case .failure(let error):
            completion?(.failure(error))
        }
    }
    
    static func performRequest<T:Decodable>(route: BaseAPIConfiguration, decoder: JSONDecoder = JSONDecoder(), completion: ((_ result: Result<T>) -> Void)?) {
        
        if Connectivity.isConnectedToInternet {
               sessionManager.request(route).validate().responseJSON(completionHandler: { (response: DataResponse<Any>) in
                   handleResponse(response, decoder: decoder, completion: completion)
               })
        }else{
            ViewUtility.showAlert(title: "network.error.noConnection.title".localized, message: "network.error.noConnection.message".localized, okBtnTitle: "network.error.retryBtnTitle".localized, cancelBtnTitle: nil, okBtnAction: {
                self.performRequest(route: route, completion: completion)
            }, cancelBtnAction: nil)
        }
        
        
    }
    

}


