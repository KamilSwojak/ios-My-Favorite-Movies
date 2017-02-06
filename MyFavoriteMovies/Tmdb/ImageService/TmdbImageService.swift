//
//  TmdbImageService.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 21/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

class TmdbImageService{
    
    static let shared = TmdbImageService()
    fileprivate init(){}
    
    func getBackdrop(path: String, size: TmdbBackdropSize, completion: @escaping(_ data: Data?) -> Void) {
        requestImage(path: path, size: size.rawValue, completion: completion)
    }
    
    func getLogo(path: String, size: TmdbLogoSize, completion: @escaping(_ data: Data?) -> Void) {
        requestImage(path: path, size: size.rawValue, completion: completion)
    }
    
    func getPoster(path: String, size: TmdbPosterSize, completion: @escaping(_ data: Data?) -> Void) {
        requestImage(path: path, size: size.rawValue, completion: completion)
    }
    
    func getProfile(path: String, size: TmdbProfileSize, completion: @escaping(_ data: Data?) -> Void) {
        requestImage(path: path, size: size.rawValue, completion: completion)
    }
    
    func getStill(path: String, size: TmdbStillSize, completion: @escaping(_ data: Data?) -> Void) {
        requestImage(path: path, size: size.rawValue, completion: completion)
    }
}


extension TmdbImageService{
    
    func getBackdrop(path: String, size: TmdbBackdropSize) -> Observable<Data> {
        return requestImage(path: path, size: size.rawValue)
    }
    
    func getLogo(path: String, size: TmdbLogoSize) -> Observable<Data> {
        return requestImage(path: path, size: size.rawValue)
    }
    
    func getPoster(path: String, size: TmdbPosterSize) -> Observable<Data> {
        return requestImage(path: path, size: size.rawValue)
    }
    
    func getProfile(path: String, size: TmdbProfileSize) -> Observable<Data> {
        return requestImage(path: path, size: size.rawValue)
    }
    
    func getStill(path: String, size: TmdbStillSize) -> Observable<Data> {
        return requestImage(path: path, size: size.rawValue)
    }
    
}


