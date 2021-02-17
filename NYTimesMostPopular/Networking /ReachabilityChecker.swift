//
//  ReachabilityChecker.swift
//  NYTimesMostPopular
//
//  Created by mohamed aboushady on 2/17/21.
//  Copyright © 2021 Boubyan. All rights reserved.
//

import Foundation
import Alamofire


class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
