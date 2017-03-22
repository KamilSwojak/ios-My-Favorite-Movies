//
//  TableInterface.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

protocol TableSectionType {
    var title: String? { get }
    var cell: UITableViewCell { get }
    var height: CGFloat { get }
    
    func reload()
}

extension TableSectionType {
    func reload(){}
}

protocol TableSectionsType {
    var sections: [TableSectionType] { get }
    subscript(index: Int) -> TableSectionType { get }
    var count: Int { get }
}
