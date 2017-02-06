//
//  UIViewController+View.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 03/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController{
    
    func showMessage(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let a = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(a)
        
        present(alert, animated: true, completion: nil)
    }
    
    func openUrl(url: URL) {
        if #available(iOS 10, *){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
