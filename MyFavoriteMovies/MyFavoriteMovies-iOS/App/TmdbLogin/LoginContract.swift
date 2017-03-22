//
//  Contract.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 20/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

struct LoginInput: ViewModelInputType{
    var username: Observable<String>
    var password: Observable<String>
    var loginTap: Observable<Void>
    var registerTap: Observable<Void>
    var cancelTap: Observable<Void>
}

struct LoginModelOutput: ViewModelOutputType{
    var buttonState: Observable<Bool>
    var message: Observable<String>
    var event: Observable<LoginEvent>
}

enum LoginEvent: Equatable{
    case Success
    case Register
    case Cancel
}
