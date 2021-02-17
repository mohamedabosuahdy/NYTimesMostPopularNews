//
//  BasePresenter.swift
//  arapety
//
//  Created by mohamed aboushady on 10/2/19.
//  Copyright © 2019 approc. All rights reserved.
//

import Foundation

class BasePresenter {
    private weak var view: BaseViewControllerProtocol?
    init(view: BaseViewControllerProtocol) {
        self.view = view
    }
    func getView() ->  BaseViewControllerProtocol?{
        return view
    }
}
