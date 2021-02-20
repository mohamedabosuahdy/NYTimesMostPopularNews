//
//  NewsDetailsViewController.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/20/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import UIKit
import Kingfisher

class NewsDetailsViewController: BaseViewController {

    @IBOutlet private weak var publishDateLbl: UILabel!
    @IBOutlet private weak var publishersLbl: UILabel!
    @IBOutlet private weak var mediaImage: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descLbl: UILabel!
    @IBOutlet private weak var captionLbl: UILabel!
    @IBOutlet weak var copyrightLbl: UILabel!
    
    private var model: NewsDetailsUIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(title: "newsDetails.title".localized)
        
        guard let model = self.model else {
            return
        }
        titleLbl.text = model.title
        descLbl.text = model.desc
        mediaImage.kf.setImage(with: URL(string: model.mediaImageURL), placeholder: UIImage(named: "news-details-placeholder"), options: nil, progressBlock: nil, completionHandler: {Result in
        })
        captionLbl.text = model.caption
        publishersLbl.text = model.publishers
        publishDateLbl.text = model.publishDate
        copyrightLbl.text = model.copyright
    }
    
    func setViewData(model:NewsDetailsUIModel)  {
        self.model = model
    }

}
