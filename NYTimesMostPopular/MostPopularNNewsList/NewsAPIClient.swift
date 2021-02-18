//
//  NewsAPIClient.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/18/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import Foundation

class NewsAPIClient: BaseAPIClient {
    public static func getMostPopularNews(backDays:Int , onSuccess: ((MPNewsResponseModel)->Void)? , onFailure: ((Error)->Void)?){
        performRequest(route: NewsAPIRouter.mostPopular(backDays: backDays), onSuccess: onSuccess, onFailure: onFailure)
    }
}
