//
//  Views.swift
//  NetworkingLayer
//
//  Created by aboushady on 3/17/19.
//  Copyright © 2019 aboushady. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self? {
        func instanceFromNib<T: UIView>() ->T? {
            return nib.instantiate() as? T
        }
        return instanceFromNib()
    }
    
    func drawDashedBorder(color:UIColor)  {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.frame = self.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(borderLayer)
    }
    
}


extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}

protocol IdentifiableCell: class {
    static var identifier: String { get }
}

extension UITableViewCell: IdentifiableCell {
    static var identifier: String {
        return "\(self)"
    }
}


public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType.self)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type.self), for: indexPath) as! T
    }
}


public extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func register(reusableViewType: UICollectionReusableView.Type,
                         ofKind kind: String = UICollectionView.elementKindSectionHeader,
                         bundle: Bundle? = nil) {
        let className = String(describing: reusableViewType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func register(reusableViewTypes: [UICollectionReusableView.Type],
                         ofKind kind: String = UICollectionView.elementKindSectionHeader,
                         bundle: Bundle? = nil) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type) , for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    func setupTwoColumnsCollectionView(interSpace: CGFloat , insets:UIEdgeInsets , itemHeight:CGFloat , padding:CGFloat) {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = interSpace 
            layout.sectionInset = insets
            let size = CGSize(width: (UIScreen.main.bounds.width - (padding*2)) / 2, height: itemHeight)
            layout.itemSize = size
            self.collectionViewLayout = layout
        }
    }

    
}




extension UIView{
    
    @available(iOS 11.0, *)
    @IBInspectable
     var twoRoundedCorner: CGFloat{
        set{
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        get{return self.layer.cornerRadius}
    }
    
    @IBInspectable
     var viewCornerRadius: CGFloat{
        set{self.layer.cornerRadius = newValue
            self.clipsToBounds = true}
        get{return self.layer.cornerRadius}
    }
    
    @IBInspectable
    var borderColor: UIColor{
        set{self.layer.borderColor = newValue.cgColor}
        get{return self.borderColor}
    }
    @IBInspectable
    var layerColor: UIColor{
        set{self.layer.backgroundColor = newValue.cgColor}
        get{return self.layerColor}
    }
    @IBInspectable
    var borderWidth: CGFloat{
        set{self.layer.borderWidth = newValue}
        get{return self.layer.borderWidth}
    }
    
    @IBInspectable
    var dropShadow: Bool{
        set{
            let shadowRadius:CGFloat = self.viewCornerRadius
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = shadowRadius
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
        get{return self.dropShadow}
    }
    @IBInspectable
    var allsidesShadow: Bool{
        set{
            self.layer.cornerRadius = self.viewCornerRadius
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = .zero
            }
        get{return self.dropShadow}
    }
    
    
    @IBInspectable
    var topShadow: Bool{
        set{
            let shadowRadius:CGFloat = 5
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.6
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = shadowRadius
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
        get{return self.topShadow}
    }
    
    @IBInspectable
    var circulate: Bool{
        set{self.layer.cornerRadius = self.frame.height / 2}
        get{return self.circulate}
    }
    
    
    
    var dropShadowAndCornerRadius: CGFloat{
        set{
            layer.cornerRadius = newValue
            clipsToBounds = true
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = newValue
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.masksToBounds = false
            layer.rasterizationScale = UIScreen.main.scale
        }
        get{return 0.0}
    }
    
    
    
    
}

extension UILabel{
    @IBInspectable
    var isUnderlined:Bool{
        get{
            return self.isUnderlined
        }
        set{
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.attributedText = attributedText
        }
    }
    
    @IBInspectable
    var localizedText:String{
        get{
            return text ?? ""
        }
        set{
            text = NSLocalizedString(newValue, tableName: nil, bundle: Bundle.main, value: "Dummy", comment: "")
        }
    }
    @IBInspectable
    var appRegularFontWithSize: CGFloat{
        set{
            self.font = UIFont.appRegularFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appBoldFontWithSize: CGFloat{
        set{
            self.font = UIFont.appBoldFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appSemiBoldFontWithSize: CGFloat{
        set{
            self.font = UIFont.appSemiBoldFontWith(size: newValue)
        }
        get{
            return self.appSemiBoldFontWithSize
        }
    }
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Bd") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Bd") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }

    
}


extension UITextField {
    // add under line to textField.
      func addUnderLine(){
          let bottomLayer = CALayer()
          bottomLayer.frame = CGRect(x: 0.0, y: self.frame.height, width: self.frame.width, height: 0.5)
          bottomLayer.backgroundColor = UIColor.gray.cgColor
          self.borderStyle = .none
          self.layer.addSublayer(bottomLayer)
      }
    
    @IBInspectable
    var appRegularFontWithSize: CGFloat{
        set{
            self.font = UIFont.appRegularFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appBoldFontWithSize: CGFloat{
        set{
            self.font = UIFont.appBoldFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appSemiBoldFontWithSize: CGFloat{
        set{
            self.font = UIFont.appSemiBoldFontWith(size: newValue)
        }
        get{
            return self.appSemiBoldFontWithSize
        }
    }
    
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
    
    @IBInspectable
    var localizedPlaceholder:String{
        get{
            return placeholder ?? ""
        }
        set{
            placeholder = NSLocalizedString(newValue, tableName: nil, bundle: Bundle.main, value: "Dummy", comment: "")
        }
    }
    @IBInspectable
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}


extension UIButton{
    
    @IBInspectable
    var localizedTitle: String{
        get{
            return titleLabel?.text ?? ""
        }
        set{
            self.setTitle(NSLocalizedString(newValue, tableName: nil, bundle: Bundle.main, value: "Dummy", comment: ""), for: .normal)
        }
    }
    @IBInspectable
    var appRegularFontWithSize: CGFloat{
        set{
            self.titleLabel?.font = UIFont.appRegularFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appBoldFontWithSize: CGFloat{
        set{
            self.titleLabel?.font = UIFont.appBoldFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appSemiBoldFontWithSize: CGFloat{
        set{
            self.titleLabel?.font = UIFont.appSemiBoldFontWith(size: newValue)
        }
        get{
            return self.appSemiBoldFontWithSize
        }
    }
    
    @IBInspectable
    var isUnderlined:Bool{
        get{
            return self.isUnderlined
        }
        set{
            guard let text = titleLabel?.text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.setAttributedTitle(attributedText, for: .normal)
        }
    }
    
    
    
}


extension CAGradientLayer {
    
    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custion(point: CGPoint)
        
        var point: CGPoint {
            switch self {
            case .topRight: return CGPoint(x: 1, y: 0)
            case .topLeft: return CGPoint(x: 0, y: 0)
            case .bottomRight: return CGPoint(x: 1, y: 1)
            case .bottomLeft: return CGPoint(x: 0, y: 1)
            case .custion(let point): return point
            }
        }
    }
    
    convenience init(frame: CGRect, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.init()
        self.frame = frame
        self.colors = colors.map { $0.cgColor }
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    convenience init(frame: CGRect, colors: [UIColor], startPoint: Point, endPoint: Point) {
        self.init(frame: frame, colors: colors, startPoint: startPoint.point, endPoint: endPoint.point)
    }
    
    func createGradientImage() -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor], startPoint: CAGradientLayer.Point = .topLeft, endPoint: CAGradientLayer.Point = .bottomRight) {
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors, startPoint: startPoint, endPoint: endPoint)
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension UITabBarItem{
    @IBInspectable
    var localizedItemTitle: String{
        get{
            return title ?? ""
        }
        set{
            title =  NSLocalizedString(newValue, tableName: nil, bundle: Bundle.main, value: "Dummy", comment: "")
        }
    }
}


extension UIImageView{
    func setGradientBackground(colors: [UIColor], startPoint: CAGradientLayer.Point = .topRight, endPoint: CAGradientLayer.Point = .bottomLeft) {
        var updatedFrame = self.bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors, startPoint: startPoint, endPoint: endPoint)
        self.image = gradientLayer.createGradientImage()
    }
}



extension UITextView{
    @IBInspectable
    var appRegularFontWithSize: CGFloat{
        set{
            self.font = UIFont.appRegularFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appBoldFontWithSize: CGFloat{
        set{
            self.font = UIFont.appBoldFontWith(size: newValue)
        }
        get{
            return self.appBoldFontWithSize
        }
    }
    
    @IBInspectable
    var appSemiBoldFontWithSize: CGFloat{
        set{
            self.font = UIFont.appSemiBoldFontWith(size: newValue)
        }
        get{
            return self.appSemiBoldFontWithSize
        }
    }
    
    func underlinedText(){
        guard let text = text else { return }
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
      
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.appBoldFontWith(size: 13) , .underlineStyle : NSUnderlineStyle.single.rawValue]

        attributedText.addAttributes(attributes, range: textRange)
        
        self.attributedText = attributedText
    }
}


extension UIViewController {
    
    // top displayed view controller
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
