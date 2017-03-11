//
//  LoginViewModel.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 20/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift
import TmdbApi

final class LoginViewModel: BaseViewModel<LoginInput, LoginModelOutput> {
    
    let disposeBag = DisposeBag()
    
    var auth = Tmdb.shared.auth
    
    required init(input: LoginInput?) {
        super.init(input: input)
        
        guard let input = input else { return }
        
        let eventSubject = PublishSubject<LoginEvent>()
        let event = eventSubject.asObservable()

        let messageSubject = PublishSubject<String>()
        let message = messageSubject.asObservable()

        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
        //MARK: Cancel taps
        let cancelTap =
            input.cancelTap
            .map{ LoginEvent.Cancel }
            .bindTo(eventSubject)
        
        //MARK: Register taps
        let registerTap =
            input.registerTap
            .map{ LoginEvent.Register }
            .bindTo(eventSubject)
        
        //MARK: Login taps
        let loginTap =
            input
            .loginTap
            .retry()
            .withLatestFrom(usernameAndPassword)
            .flatMap {
                self.auth.login(username: $0.username, password: $0.password) }
            .subscribe { (event) in
                
                if let requestError = (event.error as? RequestError) {
                    
                    switch requestError{
                        
                    case .RequestUnsuccesful(httpCode:_, tmdbCode:_, message: let tmdbMessage):
                        messageSubject.onNext(tmdbMessage)
                        
                    default: break;
                    }
                }
                
                guard let result = event.element else { return }
                
                if result == .Success {
                    
                    eventSubject.onNext(.Success)
                    
                }
        }
        
        //disable button if fields are empty
        let buttonState = usernameAndPassword
            .map{ !$0.0.isEmpty && !$0.1.isEmpty }
        
        output = LoginModelOutput(
            buttonState: buttonState,
            message: message,
            event: event)
        
        disposeBag.insert(loginTap)
        disposeBag.insert(cancelTap)
        disposeBag.insert(registerTap)
    }
}
