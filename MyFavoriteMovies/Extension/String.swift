//
//  String.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 31/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

//MARK: Dimensions
extension String {
    
    func heightWithFixedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)

        return boundingBox.height
    }
}

//MARK: Format
enum StringFormatType {
    
    case Date(format: DateFormatter.Format, style: DateFormatter.Style)
    
}

extension String {
    
    func format(as format: StringFormatType) -> String? {
        switch format {
        case .Date(format: let format, let style):

            let formatter = DateFormatter()
            formatter.dateFormat = format.rawValue
            
            guard let date = formatter.date(from: self) else { return nil }
            
            formatter.dateStyle = style
            
            return formatter.string(from: date)
        }
    }
}


//MARK: Substring
extension String {
    
    func substring(to: Int) -> String {
        return (self as NSString).substring(to: 4)
    }
}
