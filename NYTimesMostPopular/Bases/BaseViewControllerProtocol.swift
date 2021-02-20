//
//  BaseViewControllerProtocol.swift
//  arapety
//
//  Created by mohamed aboushady on 11/10/19.
//  Copyright © 2019 approc. All rights reserved.
//

import Foundation
import UIKit
protocol BaseViewControllerProtocol:class {
    func showAlertMessage( title:String? ,message: String? , okBtnTitle:String?  , cancelBtnTitle:String?  , okBtnAction: (()->Void)? ,  cancelBtnAction: (()->Void)? , preferredStyle: UIAlertController.Style? )
    func showPlainAlert(title:String? ,message: String? )
    func showLoadingView()
    func hideLoadingView()
}
