//
//  TmdbUser.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 18/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

struct TmdbUser{
    
    var id: Int
    var name: String
    var username: String
    var includeAdult: Bool
    var gravatarHash: String?
    
    var favoriteMovies: Variable<[Movie]>
    var favoriteTvShows: Variable<[TVShow]>
    
    var ratedMovies: Variable<[RatedMovie]>
    var ratedTVShows: Variable<[RatedTVShow]>
    var ratedTVEpisodes: Variable<[RatedTVEpisode]>
    
    var movieWatchlist: Variable<[Movie]>
    var tvShowsWatchlist: Variable<[TVShow]>
    
    var syncSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var syncing: Observable<Bool>{
        return syncSubject.startWith(false)
    }
    
    init(id: Int, name: String, username: String, gravatarHash: String?, includeAdult: Bool) {
        self.id = id
        self.name = name
        self.username = username
        self.gravatarHash = gravatarHash
        self.includeAdult = includeAdult
        
        favoriteMovies = Variable<[Movie]>([])
        favoriteTvShows = Variable<[TVShow]>([])
        ratedMovies = Variable<[RatedMovie]>([])
        ratedTVShows = Variable<[RatedTVShow]>([])
        ratedTVEpisodes = Variable<[RatedTVEpisode]>([])
        movieWatchlist = Variable<[Movie]>([])
        tvShowsWatchlist = Variable<[TVShow]>([])
        
        sync()
    }
    
    func sync() {
        syncSubject.onNext(true)
        syncFavoriteMovies()
        sycFavoriteTVShows()
        syncRatedMovies()
        syncRatedTVShows()
        syncRatedTVEpisodes()
        syncMovieWatchlist()
        syncTVShowWatchlist()
        syncSubject.onNext(false)
    }
}


//MARK: Helper methods related to sync
fileprivate extension TmdbUser{
    func syncFavoriteMovies(){
        Tmdb.shared.api.getFavoriteMovies(accountId: self.id) { favorites in
            
            guard let favorites = favorites else { return }
            guard let totalPages = favorites.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getFavoriteMovies(accountId: self.id, page: page) { tvShows in
                        
                        guard let tvShows = tvShows else { return }
                        guard let results = tvShows.results else { return }
                        
                        self.favoriteMovies.value.append(contentsOf: results)
                        
                }
            }
        }
    }
    
    func sycFavoriteTVShows(){
        Tmdb.shared.api.getFavoriteTVShows(accountId: self.id) { favorites in
            
            guard let favorites = favorites else { return }
            guard let totalPages = favorites.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getFavoriteTVShows(accountId: self.id, page: page) { tvShows in
                        
                        guard let tvShows = tvShows else { return }
                        guard let results = tvShows.results else { return }
                        
                        self.favoriteTvShows.value.append(contentsOf: results)
                        
                }
            }
        }
    }
    
    func syncRatedMovies(){
        Tmdb.shared.api.getRatedMovies(accountId: self.id) { rated in
            
            guard let rated = rated else { return }
            guard let totalPages = rated.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getRatedMovies(accountId: self.id, page: page) { movies in
                        
                        guard let movies = movies else { return }
                        guard let results = movies.results else { return }
                        
                        self.ratedMovies.value.append(contentsOf: results)
                        
                }
            }
        }
    }
    
    func syncRatedTVShows(){
        Tmdb.shared.api.getRatedTVShows(accountId: self.id) { rated in
            
            guard let rated = rated else { return }
            guard let totalPages = rated.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getRatedTVShows(accountId: self.id, page: page) { tvShows in
                        
                        guard let tvShows = tvShows else { return }
                        guard let results = tvShows.results else { return }
                        
                        self.ratedTVShows.value.append(contentsOf: results)
                        
                }
            }
        }
    }
    
    func syncRatedTVEpisodes(){
        Tmdb.shared.api.getRatedTVEpisodes(accountId: self.id) { rated in
            
            guard let rated = rated else { return }
            guard let totalPages = rated.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getRatedTVEpisodes(accountId: self.id, page: page) { tvEpisodes in
                        
                        guard let tvEpisodes = tvEpisodes else { return }
                        guard let results = tvEpisodes.results else { return }
                        
                        self.ratedTVEpisodes.value.append(contentsOf: results)
                        
                }
            }
        }
    }
    
    func syncMovieWatchlist(){
        Tmdb.shared.api.getMovieWatchlist(accountId: self.id) { watchlist in
            
            guard let watchlist = watchlist else { return }
            guard let totalPages = watchlist.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getMovieWatchlist(accountId: self.id, page: page) { movies in
                        
                        guard let movies = movies else { return }
                        guard let results = movies.results else { return }
                        
                        self.movieWatchlist.value.append(contentsOf: results)
                        
                }
            }
        }
    }
    
    func syncTVShowWatchlist(){
        Tmdb.shared.api.getTVShowWatchlist(accountId: self.id) { watchlist in
            
            guard let watchlist = watchlist else { return }
            guard let totalPages = watchlist.total_pages, totalPages > 0 else { return }
            
            for page in 1...totalPages {
                
                Tmdb.shared.api
                    .getTVShowWatchlist(accountId: self.id, page: page) { tvShows in
                        
                        guard let tvShows = tvShows else { return }
                        guard let results = tvShows.results else { return }
                        
                        self.tvShowsWatchlist.value.append(contentsOf: results)
                        
                }
            }
        }
    }
}
