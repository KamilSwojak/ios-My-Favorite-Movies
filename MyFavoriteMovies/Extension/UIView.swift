//
//  UIView.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

extension UIView {
    
    func sizeOfSubviews() -> CGRect {
        var rect = CGRect()
        for view in subviews {
            rect = rect.union(view.frame)
        }
        return rect
    }
    
}
