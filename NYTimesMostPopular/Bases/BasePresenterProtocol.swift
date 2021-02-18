//
//  BasePresenterProtocol.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/18/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import Foundation

protocol BasePresenterProtocol {
    func attachView(view: BaseViewControllerProtocol)
    func getView() ->  BaseViewControllerProtocol?
}
