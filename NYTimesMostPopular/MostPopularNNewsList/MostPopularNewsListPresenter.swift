//
//  MostPopularNewsListPresenter.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/18/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import Foundation


class MostPopularNewsListPresenter: BasePresenter {

    enum NewsBackDays:Int {
        case lastDay = 1
        case lastWeek = 7
        case lastMonth = 30
    }
    
    private var newsDataSource = [MPNewsResult]()
    
    
    private var viewDelegate: MostPopularNewsListViewControllerProtocol?{
        return getView() as? MostPopularNewsListViewControllerProtocol
    }
    
    
    func getNews(backDays:NewsBackDays){
        NewsAPIClient.getMostPopularNews(backDays: backDays.rawValue, onSuccess: { (responseModel) in
            if let model = responseModel.results  {
                self.viewDelegate?.hideLoadingView()
                self.newsDataSource = model
                if self.newsDataSource.isEmpty{
                    self.viewDelegate?.didGetEmptyNewsList()
                }else{
                    self.viewDelegate?.didGetNewsList()
                }
            }else{
                self.viewDelegate?.didFailGetNewsList()
            }
            
        }) { (error) in
            self.viewDelegate?.didFailGetNewsList()
        }
    }
    
    func getNewsCount() -> Int {
        return newsDataSource.count
    }
    
    func getNewsItemAt(index:Int) ->  MPNewsResult{
        return newsDataSource[index]
    }
}
