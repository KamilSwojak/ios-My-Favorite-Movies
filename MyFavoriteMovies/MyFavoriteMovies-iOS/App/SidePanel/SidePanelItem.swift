//
//  SidePanelContract.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 10/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

enum SidePanelItem: Int{
    case Movies = 0
    case TvShows = 1
    case Watchlist = 2
    case Ratings = 3
    case Favorites = 4
    case UserLists = 5
    case History = 6
    
    static func from(indexPath: IndexPath) -> SidePanelItem?{
        let rawValue: Int = indexPath.section == 1 ? indexPath.row + 2 : indexPath.row
        return SidePanelItem(rawValue: rawValue)
    }
    
    var imageNameNormal: String{
        switch self {
        case .Movies:return "movie_primary"
        case .TvShows: return "tv_primary"
        case .Watchlist: return "bookmark_primary"
        case .Ratings: return "star_primary"
        case .Favorites: return "heart_primary"
        case .UserLists: return "list_primary"
        case .History: return "history_primary"
        }
    }
    
    var imageNameSelected: String{
        switch self {
        case .Movies:return "movie_secondary_filled"
        case .TvShows: return "tv_secondary_filled"
        case .Watchlist: return "bookmark_secondary_filled"
        case .Ratings: return "star_secondary_filled"
        case .Favorites: return "heart_secondary_filled"
        case .UserLists: return "list_secondary_filled"
        case .History: return "history_secondary_filled"
        }
    }
}
