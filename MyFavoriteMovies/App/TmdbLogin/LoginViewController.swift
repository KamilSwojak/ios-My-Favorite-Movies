//
//  LoginViewController.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 20/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
   
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var ai_progress: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ai_progress.hidesWhenStopped = true

        let loginOutput = LoginInput(
            username: tf_username.textChanges,
            password: tf_password.textChanges,
            loginTap: btn_login.tap.throttle(0.5, scheduler: MainScheduler.instance),
            registerTap: btn_register.tap.throttle(0.5, scheduler: MainScheduler.instance),
            cancelTap: btn_cancel.tap.throttle(0.5, scheduler: MainScheduler.instance))
        
        let model = LoginViewModel(input: loginOutput)
        
        guard let output = model.output else { return }
        
        let buttonState = output.buttonState
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
            guard let enabled = event.element else { return }
            self.btn_login.isEnabled = enabled
        }
        
        let alert = output.message
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
            guard let msg = event.element else { return }
            
            self.showMessage(title: "The Movie Db", msg: msg)
        }
        
        let event = output.event
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in

            guard let event = event.element else { return }
                
                switch event{
                    
                case .Success:
                    
                    self.dismiss(animated: true, completion: nil)
                    
                case .Register:
                    
                    self.openUrl(url: URL(string: "https://www.themoviedb.org/account/signup")!)
                    
                case .Cancel:
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
        }
        
        let progress =
            model
                .activityIndicator
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe { (event) in
            guard let enabled = event.element else { return }
            
            if enabled {
                self.ai_progress.startAnimating()
            } else{
                self.ai_progress.stopAnimating()
            }
        }

        disposeBag.insert(progress)
        disposeBag.insert(buttonState)
        disposeBag.insert(buttonState)
        disposeBag.insert(alert)
        disposeBag.insert(event)
    }
}
