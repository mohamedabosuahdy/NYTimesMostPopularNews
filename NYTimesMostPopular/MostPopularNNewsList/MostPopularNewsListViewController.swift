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
        setTitle(title: "newslist.title".localized)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getNews()
    }

}


extension MostPopularNewsListViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MostPopulatNewsTableViewCell.self, for: indexPath)
        let newsItem = presenter.getNewsItemAt(index: indexPath.row)
        
        cell.setCellData(cellModel: newsItem)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showNewsItemDetailsAt(index: indexPath.row)
    }
}


extension MostPopularNewsListViewController: MostPopularNewsListViewControllerProtocol{
    func didGetNewsList() {
        newsTableView.reloadData()
    }
    
    func didFailGetNewsList() {
        showAlertMessage(title: "newslist.failure.message".localized, message: "newslist.failure.title".localized, okBtnAction: {
            self.presenter.getNews()
        }, cancelBtnAction: nil)
    }
    
    func didGetEmptyNewsList() {
        newsTableView.showEmptyDataSetView()
    }
    
    
}
