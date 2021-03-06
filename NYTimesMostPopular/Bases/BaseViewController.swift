//
//  BaseViewController.swift
//  Adahi
//
//  Created by aboushady on 3/27/19.
//  Copyright © 2019 LinkDevelopment. All rights reserved.
//

import Foundation
import UIKit


class BaseViewController: UIViewController , BaseViewControllerProtocol {
    private var viewTitle: String?
    private var loadingIndicator: UIActivityIndicatorView?
    private var navigationBarImage: UIImage?
    
    private lazy var activityIndicatorView:UIView  = {
        let centerPointX = self.view.center.x - 30
        let centerPointY = self.view.center.y - 30
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: centerPointX, y: centerPointY, width: 60, height: 60))
        loadingIndicator?.color = .MainColor
        loadingIndicator?.style = .large
        containerView.backgroundColor = .clear
        loadingIndicator?.startAnimating()
        loadingIndicator?.color = UIColor.MainColor
        containerView.addSubview(loadingIndicator!)
        return containerView
    }()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        styleNavigationBar()
    }
    
    
    func styleNavigationBar()  {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .MainColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.appBoldFontWith(size: 18)]
        navigationController?.navigationBar.barStyle = .default
        navigationItem.title = viewTitle
    }
    
    
    
    func showAlertMessage( title:String? ,message: String? , okBtnTitle:String? = nil , cancelBtnTitle:String? = nil , okBtnAction: (()->Void)? ,  cancelBtnAction: (()->Void)? , preferredStyle: UIAlertController.Style? = .alert) {
        let alert = UIAlertController(title: title ?? viewTitle, message: message, preferredStyle: preferredStyle ?? UIAlertController.Style.alert)
        
        //default titles for buttons if not passed
        let okTitle = okBtnTitle ?? "alert.okBtnTitle".localized
        let cancelTitle = cancelBtnTitle ?? "alert.cancelBtnTitle".localized
        
        //alert ok button with deafault title and action
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
            okBtnAction?()
        }))
        
        //add cancel button only in case it is required
        if cancelBtnTitle != nil{
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
                cancelBtnAction?()
            }))
        }
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showPlainAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title ?? viewTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "alert.okBtnTitle".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showLoadingView() {
        
        self.view.addSubview(self.activityIndicatorView)
    }
    
    func hideLoadingView() {
        self.activityIndicatorView.removeFromSuperview()
    }
    
    func hideKeyboard()  {
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardSelector))
        viewTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(viewTapGesture)
    }
    
    @objc
    private func hideKeyboardSelector(){
        view.endEditing(true)
    }
    
    func setTitle(title: String?) {
        viewTitle = title
    }
    
    func setNavigationBarVisibility(isHidden:Bool)  {
        navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }
    
    
 
}
