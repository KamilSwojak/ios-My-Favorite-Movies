//
//  UIBarButton.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 20/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

extension UIBarButtonItem {
    
    var tap: Observable<Void> {
        return rx.tap.asObservable()
    }
    
}
