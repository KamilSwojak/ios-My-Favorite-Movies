//
//  Disposable.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 16/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

extension DisposeBag {
    
    func insert(_ disposables: Disposable...) {
        for d in disposables {
            insert(d)
        }
    }
    
}
