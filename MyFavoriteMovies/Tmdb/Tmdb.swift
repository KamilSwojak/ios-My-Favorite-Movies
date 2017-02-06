//
//  TMDB.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 18/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

public final class Tmdb{
    
    public static let shared = Tmdb()

    let api = TmdbService.shared
    let images = TmdbImageService.shared
    let auth = TmdbAuth.shared
    var user: Variable<TmdbUser?> = Variable(nil)
    
    private let serverConfig = TmdbServerConfig.shared

    private var stateChangesSubject = ReplaySubject<TmdbAuthState>.create(bufferSize: 1)
    var stateChanges: Observable<TmdbAuthState>{
        return stateChangesSubject.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    fileprivate init(){

        let authState =
            auth
            .authStateObservable
            .subscribe { (event) in
                guard let state = event.element else { return }
                
                if state == TmdbAuthState.SignedIn{
                    
                    // download account details and create user
                    self.api.getAccountDetails() { account in
                        guard let account = account else { return }
                        guard
                            let id = account.id,
                            let name = account.name,
                            let username = account.username,
                            let includeAdult = account.include_adult
                        else { return }
                        
                        self.user.value = TmdbUser(id: id, name: name, username: username, gravatarHash: account.gravatar_hash, includeAdult: includeAdult)
                    }
                    
                } else {
                    self.user.value = nil
                }
        }
        
        disposeBag.insert(authState)
    }
    
    func requestSync() {
        user.value?.sync()
    }
    
    public func configure(apiKey: String){
        serverConfig.setApiKey(apiKey)
    }
}

