//
//  TmdbAuth.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 18/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

class TmdbAuth{
    
    static let shared = TmdbAuth()
    fileprivate init(){}
    
    private var authState: Variable<TmdbAuthState> = Variable(.NotSignedIn)
    var sessionId: Variable<String?> = Variable(nil)
    
    var authStateObservable: Observable<TmdbAuthState> {
        return authState.asObservable()
    }
    
    var currentState: TmdbAuthState{
        return authState.value
    }

    private var ongoingRequest: Disposable?
    
    func login(username: String, password: String) -> Observable<LoginResult>{
        return
            TmdbService.shared
            .createRequestToken()
            .validateRequestToken(username: username, password: password)
            .createSession()
            .map { response -> LoginResult in
                guard let success = response.success, let sessionId = response.session_id else {
                    self.sessionId.value = nil
                    self.authState.value = .NotSignedIn
                    
                    return .Failure
                }
                
                guard success == true else {
                    self.sessionId.value = nil
                    self.authState.value = .NotSignedIn
                    
                    return .Failure
                }
                
                self.sessionId.value = sessionId
                self.authState.value = .SignedIn
                
                return .Success
            }
    }
    
    func logout(){
        self.ongoingRequest?.dispose()
        self.sessionId.value = nil
        self.authState.value = .NotSignedIn
    }
}

enum LoginResult{
    case Success
    case Failure
}
enum TmdbAuthState{
    case SignedIn
    case NotSignedIn
}
