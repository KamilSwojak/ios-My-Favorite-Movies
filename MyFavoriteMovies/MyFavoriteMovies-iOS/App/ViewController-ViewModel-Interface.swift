//
//  ViewController-ViewModel-Interface.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 03/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewModelInputType{}
protocol ViewModelOutputType{}

struct NoInput: ViewModelInputType{}
struct NoOutput: ViewModelOutputType{}

protocol ViewModelType: class {
    associatedtype ViewOutput: ViewModelInputType
    init(input: ViewOutput?)
}

class BaseViewModel<IN: ViewModelInputType, OUT: ViewModelOutputType>: ViewModelType {
    
    let input: IN?
    var output: OUT?
    
    var activityIndicator = ReplaySubject<Bool>.create(bufferSize: 1)
    
    internal required init(input: IN?) {
        self.input = input
    }
}
