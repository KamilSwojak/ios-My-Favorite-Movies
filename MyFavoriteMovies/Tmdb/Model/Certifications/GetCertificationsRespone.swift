//
//  GetCertificationsRespone.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCertificationsResponse: TmdbResponse{
    
    var US: [Certification]?
    var CA: [Certification]?
    var DE: [Certification]?
    var GB: [Certification]?
    var AU: [Certification]?
    var BR: [Certification]?
    var FR: [Certification]?
    var NZ: [Certification]?
    var IN: [Certification]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        US <- map["certifications.US"]
        CA <- map["certifications.CA"]
        DE <- map["certifications.DE"]
        GB <- map["certifications.GB"]
        AU <- map["certifications.AU"]
        BR <- map["certifications.BR"]
        FR <- map["certifications.FR"]
        NZ <- map["certifications.NZ"]
        IN <- map["certifications.IN"]
    }
}
