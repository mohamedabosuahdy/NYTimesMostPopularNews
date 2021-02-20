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
    private let backDays:NewsBackDays = .lastMonth
    
    private var viewDelegate: MostPopularNewsListViewControllerProtocol?{
        return getView() as? MostPopularNewsListViewControllerProtocol
    }
    
    
    func getNews(){
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
            self.viewDelegate?.hideLoadingView()
            self.viewDelegate?.didFailGetNewsList()
        }
    }
    
    func getNewsCount() -> Int {
        return newsDataSource.count
    }
    
    func getNewsItemAt(index:Int) ->  NewsCellUIModel{
        let newsItem = newsDataSource[index]
        var url = ""
        if let media = newsItem.media , !media.isEmpty , let meta = media[0].mediametadata , !meta.isEmpty ,let imageUrl = meta[0].url{
            url = imageUrl
        }
        
        let model = NewsCellUIModel(title: newsItem.title ?? "" , subTitle: newsItem.abstractField ?? "", thumbImageURL:  url, publishDate: newsItem.publishedDate ?? "")
        
        return model
    }
    
    func showNewsItemDetailsAt(index: Int){
        let item = newsDataSource[index]
        var url = ""
        if let media = item.media , !media.isEmpty , let meta = media[0].mediametadata , !meta.isEmpty ,let imageUrl = meta[2].url{
            url = imageUrl
        }
        var caption = ""
        if let media = item.media , !media.isEmpty , let captionString = media[0].caption{
            caption = captionString
        }
        var copyright = ""
        if let media = item.media , !media.isEmpty , let copyrightString = media[0].copyright{
            copyright = copyrightString
        }
        let model = NewsDetailsUIModel(title: item.title ?? "", desc: item.abstractField ?? "", mediaImageURL: url, publishDate: item.publishedDate ?? "", publishers: item.byline ?? "", caption: caption , copyright: copyright)
        Router.navigateTo(target: .newsItemDetails(model: model))
    }
    
}
