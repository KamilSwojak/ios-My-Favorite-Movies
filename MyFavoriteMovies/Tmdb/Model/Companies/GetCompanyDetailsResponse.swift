//
//  GetCompanyDetailsResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 14/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCompanyDetailsResponse: TmdbResponse{
    
    var description: String?
    var headquarters: String?
    var homepage: String?
    var id: Int?
    var logo_path: String?
    var name: String?
    var parent_company: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        description <- map["description"]
        headquarters <- map["headquarters"]
        homepage <- map["homepage"]
        id <- map["id"]
        logo_path <- map["logo_path"]
        name <- map["name"]
        parent_company <- map["parent_company"]
    }
}
