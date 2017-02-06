//
//  Queries.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

protocol DiscoverQuery {}
extension DiscoverQuery{
    /// Maps all fields to [String : String]
    func mapQueries() -> [String : Any] {
        var queries: [String : String] = [:]
        
        let mirror = Mirror(reflecting: self)
        
        let children =
            mirror.children
                .filter { $0.label != nil }
                .map { (label: $0.label!, value: "\($0.value)") }
                .filter { $0.value != "nil" }
                .map { child -> (label: String, value: String) in
                    
                    // change '_lte', '_gte' to ".lte", ".gte"
                    var label = child.label
                    if label.contains("_lte") || label.contains("_gte"){
                        label = child.label.replacingOccurrences(of: "_lte", with: ".lte")
                        label = child.label.replacingOccurrences(of: "_gte", with: ".gte")
                    }
                    
                    //remove 'Optional()' from value
                    var value = child.value
                    if value.contains("Optional"){
                        //for strings
                        value = value.replacingOccurrences(of: "Optional(\"", with: "")
                        value = value.replacingOccurrences(of: "\")", with: "")
                        
                        //other
                        value = value.replacingOccurrences(of: "Optional(", with: "")
                        value = value.replacingOccurrences(of: ")", with: "")
                    }
                    
                    return (label: label, value: value)
        }
        
        for child in children{
            queries[child.label] = child.value
        }
        
        return queries
    }
}
