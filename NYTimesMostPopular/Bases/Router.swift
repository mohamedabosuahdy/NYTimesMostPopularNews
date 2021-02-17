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
    case newsListItemDetails
    
    var viewController: UIViewController?{
        var targetViewController: UIViewController?
        
        return targetViewController
    }
    
}

class Router{
    //Navigate to view controllers using navigation controller
    class func navigateTo(target: NavigationTarget ){
        let rootViewController = UIApplication.shared.topMostViewController()?.children[0] as? UINavigationController
        if let targetVC = target.viewController{
            rootViewController?.pushViewController(targetVC, animated: true)
        }
    }
    
    class func pop(){
        let rootViewController = UIApplication.shared.topMostViewController()?.children[0] as? UINavigationController
        rootViewController?.popViewController(animated: true)
    }
    
    class func present(target: NavigationTarget ){
        let rootViewController = UIApplication.shared.topMostViewController()?.children[0] as? UINavigationController
        if let targetVC = target.viewController{
            rootViewController?.present(targetVC, animated: true)
        }
    }
    
    class func setRootView(target: NavigationTarget ){
        let rootViewController = UIApplication.shared.topMostViewController()?.children[0] as? UINavigationController
        if let targetVC = target.viewController{
            rootViewController?.setViewControllers([targetVC], animated: false)
        }
    }
    
}
