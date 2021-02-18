//
//  MostPopularNNewsListViewController.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/17/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import UIKit

protocol MostPopularNewsListViewControllerProtocol:BaseViewControllerProtocol {
    func didGetNewsList()
    func didFailGetNewsList()
    func didGetEmptyNewsList()
}


class MostPopularNewsListViewController: BaseViewController {

    @IBOutlet private weak var newsTableView: UITableView!
    private var presenter = MostPopularNewsListPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        newsTableView.register(cellType: MostPopulatNewsTableViewCell.self)
        showLoadingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getNews(backDays: .lastMonth)
    }

}


extension MostPopularNewsListViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MostPopulatNewsTableViewCell.self, for: indexPath)
        let newsItem = presenter.getNewsItemAt(index: indexPath.row)
        var url = ""
        if let media = newsItem.media , !media.isEmpty , let meta = media[0].mediametadata , !meta.isEmpty ,let imageUrl = meta[0].url{
            url = imageUrl
        }
        cell.setCellData(cellModel: NewsCellUIModel(title: newsItem.title ?? "" , subTitle: newsItem.abstractField ?? "", thumbImageURL:  url, publishDate: newsItem.publishedDate ?? ""))
        return cell
    }
    
}


extension MostPopularNewsListViewController: MostPopularNewsListViewControllerProtocol{
    func didGetNewsList() {
        newsTableView.reloadData()
    }
    
    func didFailGetNewsList() {
        showPlainAlert(title: "newslist.failure.message".localized, message: "newslist.failure.title".localized)
    }
    
    func didGetEmptyNewsList() {
        newsTableView.showEmptyDataSetView()
    }
    
    
}
