//
//  TmdbBarButtonItem.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 01/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class TmdbBarButtonItem: UIBarButtonItem{
    
    private let disposeBag = DisposeBag()
    
    //used to display login/logout images
    private var imageView: UIImageView?
    
    //login/logout
    func onClick(){
        
        switch Tmdb.shared.auth.currentState {
            
        case .SignedIn:
            Tmdb.shared.auth.logout()
            
        default:
            UIApplication.shared.keyWindow?.rootViewController?.present(UIStoryboard.tmdbLogin, animated: true, completion: nil)

        }
    }
    
    private func subscribeToSessionStates(){
        
        let state = Tmdb.shared.auth.authStateObservable
        
        //change image based on login state
        let loginState = state.subscribe { (event) in
            
            guard let state = event.element else { return }
            
            switch state {
                
            case .SignedIn:
                self.imageView?.image = UIImage(named: "user_primary_filled")
                
            default:
                self.imageView?.image = UIImage(named: "user_primary")
            }
        }
        
        //react to taps on image view
        let tap = UITapGestureRecognizer(target: self, action: #selector(TmdbBarButtonItem.onClick))
        self.imageView?.addGestureRecognizer(tap)
        self.imageView?.isUserInteractionEnabled = true
        
        disposeBag.insert(loginState)
    }
    
    static let instance = TmdbBarButtonItem.get
    
    private static var get: UIBarButtonItem {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let barButton = TmdbBarButtonItem(customView: imageView)

        barButton.imageView = imageView
        barButton.subscribeToSessionStates()
        
        return barButton
    }
}
