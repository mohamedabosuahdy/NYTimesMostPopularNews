//
//  Router.swift
//  masaar
//
//  Created by Mohamed Aboushady on 12/12/18.
//  Copyright © 2018 Mohamed Aboushady. All rights reserved.
//

import Foundation
import UIKit

enum NavigationTarget{
    case newsList
    case newsItemDetails(model:NewsDetailsUIModel)
    
    var viewController: UIViewController?{
        var targetViewController: UIViewController?
        switch self {
        case .newsList:
            targetViewController = MostPopularNewsListViewController.instantiate(fromAppStoryboard: .main)
        case .newsItemDetails(let model):
            targetViewController = NewsDetailsViewController.instantiate(fromAppStoryboard: .newsDetails)
            (targetViewController as! NewsDetailsViewController).setViewData(model: model)
        }
        
        return targetViewController
    }
    
}

class Router{
    //Navigate to view controllers using navigation controller
    class func navigateTo(target: NavigationTarget ){
        let rootViewController = UIApplication.shared.topMostViewController() as? UINavigationController
        if let targetVC = target.viewController{
            rootViewController?.pushViewController(targetVC, animated: true)
        }
    }
    
    class func pop(){
        let rootViewController = UIApplication.shared.topMostViewController() as? UINavigationController
        rootViewController?.popViewController(animated: true)
    }
    
    
}
