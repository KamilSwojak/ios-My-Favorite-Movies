//
//  UITextField.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 08/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UITextField{
    
    var textChanges: Observable<String> {
        return self.rx.text.orEmpty.asObservable()
    }
}
