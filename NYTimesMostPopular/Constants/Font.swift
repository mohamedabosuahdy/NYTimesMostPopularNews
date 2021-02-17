//
//  Font.swift
//  NetworkingLayer
//
//  Created by aboushady on 3/17/19.
//  Copyright © 2019 aboushady. All rights reserved.
//

import Foundation
import UIKit


enum AppFontStyle{
    case bold
    case regular
    case italic
}


class FontsManager{

    private var bold:String
    private var regular:String
    private var italic:String
    
    init( bold : String? ,  regular : String? , italic : String? ) {
        self.bold = bold ?? "default"
        self.regular = regular ?? "default"
        self.italic = regular ?? "default"
    }
    
    func getFontWith(style:AppFontStyle , size:CGFloat) -> UIFont {
        switch style {
        case .bold:
            return UIFont(name: bold, size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular:
            return UIFont(name: regular, size: size) ?? UIFont.systemFont(ofSize: size)
        case .italic:
            return UIFont(name: italic, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}

extension UIFont {
    static func customAppFont(name: AppFontNames, size: AppFontSize) -> UIFont {
        let font = UIFont(name: name.rawValue, size: size.rawValue)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size.rawValue)
    }
    
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        let font = UIFont(name: AppFontNames.SFUIDisplayLight.rawValue , size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        let font = UIFont(name: AppFontNames.SFUIDisplayBold.rawValue , size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    class func appSemiBoldFontWith( size:CGFloat ) -> UIFont{
        let font = UIFont(name: AppFontNames.SFUIDisplaySemibold.rawValue , size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
}


