//
//  DataTypesExtensions.swift
//  NetworkingLayer
//
//  Created by aboushady on 2/10/19.
//  Copyright © 2019 aboushady. All rights reserved.
//

import Foundation
import UIKit
extension Dictionary {
    static func +(lhs: Dictionary, rhs: Dictionary?) -> Dictionary {
        if rhs == nil {
            return lhs
        } else {
            var dic = lhs
            rhs!.forEach { dic[$0] = $1 }
            return dic
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
