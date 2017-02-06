//
//  String.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 31/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

extension String {
    func heightWithFixedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
