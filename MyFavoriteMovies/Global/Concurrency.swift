//
//  Concurrency.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

func backgroundAsync(_ execute: @escaping () -> Void){
    DispatchQueue(label: "com.myfavoritemovies", qos: .background).async {
        execute()
    }
}

func backgroundSync(_ execute: @escaping () -> Void) {
    DispatchQueue(label: "com.myfavoritemovies", qos: .background).sync {
        execute()
    }
}

func mainAsync(_ execute: @escaping () -> Void ) {
    DispatchQueue.main.async {
        execute()
    }
}

func mainSync(_ execute: @escaping () -> Void ) {
    DispatchQueue.main.sync {
        execute()
    }
}
