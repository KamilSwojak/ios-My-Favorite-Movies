//
//  TVGenre.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

enum TVGenre : Int {
    
    case ActionAndAdventure = 10759
    
    case Animation = 16
    
    case Comedy = 35
    
    case Crime = 80
    
    case Documentary = 99
    
    case Drama = 18
    
    case Family = 10751
    
    case Kids = 10762
    
    case Mystery = 9648
    
    case News = 10763
    
    case Reality = 10764
    
    case SciFiAndFantasy = 10765
    
    case Soap = 10766
    
    case Talk = 10767
    
    case WarAndPolitics = 10768
    
    case Western = 37
    
    var description: String{
        
        switch self {
            
        case .ActionAndAdventure:
            return "Action & Adventure"
            
        case .Animation:
            return "Animation"
            
        case .Comedy:
            return "Comedy"
            
        case .Crime:
            return "Crime"
            
        case .Documentary:
            return "Documentary"
            
        case .Drama:
            return "Drama"
            
        case .Family:
            return "Family"
            
        case .Kids:
            return "Kids"
            
        case .Mystery:
            return "Mystery"
            
        case .News:
            return "News"
            
        case .Reality:
            return "Reality"
            
        case .SciFiAndFantasy:
            return "Sci-Fi & Fantasy"
            
        case .Soap:
            return "Soap"
            
        case .Talk:
            return "Talk"
            
        case .WarAndPolitics:
            return "War & Politics"
            
        case .Western:
            return "Western"
        }
    }
}
