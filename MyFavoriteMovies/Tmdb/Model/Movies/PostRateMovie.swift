//
//  PostRateMovie.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostRateMovieBody: Mappable{
    
    var value: Float!
    
    init?(map: Map) {}
    
    init(value: RatingScale) {
        self.value = value.rawValue
    }
    
    mutating func mapping(map: Map) {
        value <- map["value"]
    }
}

enum RatingScale: Float {
    case Half = 0.5
    case One = 1
    case OneAndHalf = 1.5
    case Two = 2
    case TwoAndHalf = 2.5
    case Three = 3
    case ThreeAndHalf = 3.5
    case Four = 4
    case FourAndHalf = 4.5
    case Five = 5
    case FiveAndHalf = 5.5
    case Six = 6
    case SixAndHalf = 6.5
    case Seven = 7
    case SevenAndHalf = 7.5
    case Eight = 8
    case EightAndHalf = 8.5
    case Nine = 9
    case NineAndHalf = 9.5
    case Ten = 10
}
