//
//  TmdbResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TmdbResponse: Mappable{
    var status_code: TmdbStatusCode?
    var status_message: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status_message <- map["status_message"]
        
        var code: Int?
        code <- map["status_code"]
        guard let statusCode = code else {
            return
        }
        status_code = TmdbStatusCode(rawValue: statusCode)
    }
}

extension TmdbResponse{
    func debug(){
        let mirror = Mirror(reflecting: self)
        
        print("")
        print(mirror.description)
        
        for child in mirror.children{
            
            print("\t", child.label ?? "no-label", "=", child.value)
            
            if child.value is TmdbResponse{
                (child.value as! TmdbResponse).debug()
            }
            
            if child.value is Array<TmdbResponse>{
                
                if !(child.value as! Array<TmdbResponse>).isEmpty{
                    print(child.label ?? "no-label", "[")
                }
                
                for element in (child.value as! Array<TmdbResponse>){
                    element.debug()
                }
                
                if !(child.value as! Array<TmdbResponse>).isEmpty{
                    print("]")
                }
                
            }
        }
        
        guard let superclass = mirror.superclassMirror else { return }
        
        print("")
        print(superclass.description)
        for child in superclass.children{
            if let label = child.label{
                print(label, child.value)
            }
        }
        
    }
}

class TmdbResponseUtil {
    
    // if element has 'release_date' it's movie
    // if element has 'first_air_date' it's tv
    // if element has 'profile_path' it's a person
    
    /// Helper method to determine whether this TmdbResponse is a Movie
    static func isMovie(item: Dictionary<String, AnyObject>) -> Bool {
        return item.contains(where: { (key: String, value: AnyObject) -> Bool in
            key == "release_date"
        })
    }
    
    /// Helper method to determine whether this TmdbResponse is a TVShow
    static func isTVShow(item: Dictionary<String, AnyObject>) -> Bool {
        return item.contains(where: { (key: String, value: AnyObject) -> Bool in
            key == "first_air_date"
        })
    }
    
    /// Helper method to determine whether this TmdbResponse is a Person
    static func isPerson(item: Dictionary<String, AnyObject>) -> Bool {
        return item.contains(where: { (key: String, value: AnyObject) -> Bool in
            key == "profile_path"
        })
    }
}
