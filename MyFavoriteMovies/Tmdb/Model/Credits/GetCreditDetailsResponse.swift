//
//  GetCreditDetailsResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 14/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCreditDetailsResponse: TmdbResponse{
    var credit_type: String?
    var department: String?
    var job: String?
    var media: CreditMedia?
    var media_type: String?
    var id: String?
    var person: Person?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        credit_type <- map["credit_type"]
        department <- map["department"]
        job <- map["job"]
        media <- map["media"]
        media_type <- map["media_type"]
        id <- map["id"]
        person <- map["person"]
    }
}

class CreditMedia: Mappable{
    
    var id: Int?
    var name: String?
    var original_name: String?
    var character: String?
    var seasons: [Season]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        original_name <- map["original_name"]
        character <- map["character"]
        seasons <- map["seasons"]
    }
}
