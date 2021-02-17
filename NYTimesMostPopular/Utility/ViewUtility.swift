//
//  ViewUtility.swift
//  NetworkingLayer
//
//  Created by aboushady on 2/24/19.
//  Copyright © 2019 aboushady. All rights reserved.
//

import Foundation
import UIKit

class ViewUtility {
    
    class func showAlert( title:String? ,message: String , okBtnTitle:String? , cancelBtnTitle:String? , okBtnAction: (()->())? ,  cancelBtnAction: (()->())?) {
        
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return  }
        
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //default titles for buttons if not passed
        let okTitle = okBtnTitle ?? "network.error.retryBtnTitle".localized
        let cancelTitle = cancelBtnTitle ?? "network.error.dismissBtnTitle".localized
        
        //alert ok button with deafault title and action
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
            okBtnAction?()
        }))
        
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: cancelBtnAction)
            (((UIApplication.shared.topMostViewController() as? UINavigationController)?.topViewController) as? BaseViewController)?.hideLoadingView()
        }))
        
        topViewController.present(alert, animated: true, completion: nil)
    }
}
