//
//  TmdbImageView.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import TmdbApi
import KSConcurrency

class TmdbImageView: UIImageView{
    
    enum ImageType {
        case Backdrop(path: String, size: TmdbBackdropSize)
        case Poster(path: String, size: TmdbPosterSize)
        case Profile(path: String, size: TmdbProfileSize)
    }
    
    private let service = Tmdb.shared.images
    private let ai_progress = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addSubview(ai_progress)
        ai_progress.hidesWhenStopped = true
        ai_progress.center.y = self.center.y
        ai_progress.center.x = self.center.x
        
        self.backgroundColor = UIColor.clear
        
        self.image = nil
    }
    
    func setImage(_ image: ImageType){
        self.image = nil
        self.ai_progress.startAnimating()
        
        switch image {
        case .Backdrop(path: let path, size: let size):
            service.getBackdrop(path: path, size: size) { data in
                self.setImageFrom(data: data)
            }
            
        case .Poster(path: let path, size: let size):
            service.getPoster(path: path, size: size) { data in
                self.setImageFrom(data: data)
            }
            
        case .Profile(path: let path, size: let size):
            service.getProfile(path: path, size: size) { data in
                self.setImageFrom(data: data)
            }
        }
    }
    
    private func setImageFrom(data: Data?){
        
        guard let data = data, let image = UIImage(data: data) else {
            mainAsync {
                self.ai_progress.stopAnimating()
            }
            return
        }
        
        mainAsync {
            self.ai_progress.stopAnimating()
            self.image = image
            
            self.alpha = 0.0
            
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1.0
            }
        }
    }
    
    
}
