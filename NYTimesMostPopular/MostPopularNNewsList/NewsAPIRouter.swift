//
//  NewsAPIRouter.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/18/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import Foundation
import Alamofire

enum NewsAPIRouter: BaseAPIConfiguration{
    case mostPopular(backDays:Int)
    
    var method: HTTPMethod{
        return .get
    }
    
    var path: String{
        switch self {
        case .mostPopular(let backDays):
            return "/svc/mostpopular/v2/viewed/\(backDays).json"
        }
    }
    
    var headers: HTTPHeaders?{
        return nil
    }
    
    var parameters: Parameters?{
        return nil
    }
    
}
