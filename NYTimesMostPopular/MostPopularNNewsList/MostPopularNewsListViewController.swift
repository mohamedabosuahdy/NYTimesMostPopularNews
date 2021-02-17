//
//  MostPopularNNewsListViewController.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/17/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import UIKit

class MostPopularNewsListViewController: UIViewController {

    @IBOutlet private weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.register(cellType: MostPopulatNewsTableViewCell.self)
    }
    

}


extension MostPopularNewsListViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MostPopulatNewsTableViewCell.self, for: indexPath)
        cell.setCellData(cellModel: NewsCellUIModel(title: "kjhgkhgkjgh", subTitle: "lkhulkhjlkh", thumbImageURL: "kjhgkghkg", publishDate: "khljhljh"))
        return cell
    }
    
}
