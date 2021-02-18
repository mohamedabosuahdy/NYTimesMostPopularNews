//
//  MostPopulatNewsTableViewCell.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/17/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import UIKit
import Kingfisher

class MostPopulatNewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var subTitleLbl: UILabel!
    @IBOutlet private weak var thumImage: UIImageView!
    @IBOutlet private weak var publishDateLbl: UILabel!
    private var cellModel:NewsCellUIModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    func setCellData(cellModel:NewsCellUIModel)  {
        self.cellModel = cellModel
        guard let model = self.cellModel else {
                   return
               }
        titleLbl.text = model.title
        subTitleLbl.text = model.subTitle
    

        thumImage.kf.setImage(with: URL(string: model.thumbImageURL), placeholder: UIImage(named: "Times-logo"), options: nil, progressBlock: nil, completionHandler: {Result in
            
        })
        publishDateLbl.text = model.publishDate
    }
    
}
