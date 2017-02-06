//
//  Internet.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 14/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

//MARK: GET

func requestJson<MAPPABLE: Mappable>(path: String, queries: [String : Any]? = [:],  completion: @escaping(_ result: MAPPABLE?) -> Void) {
    guard let url = TmdbServerConfig.shared.url(path: path, queries: queries) else {
        print(RequestError.InvalidUrl)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) {
            completion(getJson(data: $0, urlResponse: $1, error: $2))
    }
    task.resume()
}

func requestJson<MAPPABLE: Mappable>(path: String, queries: [String : Any]? = [:]) -> Observable<MAPPABLE>{
    return Observable<MAPPABLE>.create{ observer in
        
        guard let url = TmdbServerConfig.shared.url(path: path, queries: queries) else {
            observer.onError(RequestError.InvalidUrl)
            return Disposables.create()
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            getJsonWithObserver(observer, data: $0, urlResponse: $1, error: $2)
        }
        
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}

//MARK: POST

func postJson<MAPPABLE: Mappable>(path: String, queries: [String : Any]! = [:], body: Mappable? = nil) -> Observable<MAPPABLE>{
    return Observable<MAPPABLE>.create { observer in
        
        guard let url = TmdbServerConfig.shared.url(path: path, queries: queries) else {
            observer.onError(RequestError.InvalidUrl)
            return Disposables.create()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if let body = body {
            guard let bodyString = body.toJSONString() else {
                observer.onError(PostRequestError.ErrorParsingBodyToString)
                return Disposables.create()
            }
            
            guard let body = bodyString.data(using: .utf8) else {
                observer.onError(PostRequestError.ErrorParsingBodyToData)
                return Disposables.create()
            }
            
            request.httpBody = body
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            getJsonWithObserver(observer, data: $0, urlResponse: $1, error: $2)
        }
        
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}

func postJson<MAPPABLE: Mappable>(path: String, queries: [String : Any]! = [:], body: Mappable? = nil, completion: @escaping(_ result: MAPPABLE?) -> Void){
    guard let url = TmdbServerConfig.shared.url(path: path, queries: queries) else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    if let body = body {
        guard let bodyString = body.toJSONString() else {
            return
        }
        
        guard let body = bodyString.data(using: .utf8) else {
            return
        }
        
        request.httpBody = body
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
    
    let task = URLSession.shared.dataTask(with: request) {
        completion(getJson(data: $0, urlResponse: $1, error: $2))
    }
    
    task.resume()
}


//MARK: DELETE

func delete<MAPPABLE: Mappable>(path: String, queries: [String : Any]! = [:]) -> Observable<MAPPABLE>{
    return Observable<MAPPABLE>.create { observer in
        
        guard let url = TmdbServerConfig.shared.url(path: path, queries: queries) else {
            observer.onError(RequestError.InvalidUrl)
            return Disposables.create()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) {
            getJsonWithObserver(observer, data: $0, urlResponse: $1, error: $2)
        }
        
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}

func delete<MAPPABLE: Mappable>(path: String, queries: [String : Any]! = [:], completion: @escaping(_ result: MAPPABLE?) -> Void) {
        guard let url = TmdbServerConfig.shared.url(path: path, queries: queries) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) {
            completion(getJson(data: $0, urlResponse: $1, error: $2))
        }
        
        task.resume()
}


// MARK: Raw Image

func requestImage(path: String, size: String,  completion: @escaping(_ result: Data?) -> Void) {
    guard let url = TmdbServerConfig.shared.imageUrl(path: path, size: size) else {
        print(RequestError.InvalidUrl)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) {
        completion(getData(data: $0, urlResponse: $1, error: $2))
    }
    task.resume()
}

func requestImage(path: String, size: String) -> Observable<Data>{
    return Observable<Data>.create{ observer in
        
        guard let url = TmdbServerConfig.shared.imageUrl(path: path, size: size) else {
            observer.onError(RequestError.InvalidUrl)
            return Disposables.create()
        }

        
        let task = URLSession.shared.dataTask(with: url) {
            getDataWithObserver(observer, data: $0, urlResponse: $1, error: $2)
        }
        
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}


//MARK: JSON from URLSession

private func getJson<MAPPABLE: Mappable>(data: Data?, urlResponse: URLResponse?, error: Error?) -> MAPPABLE?{
    guard error == nil else {
        return nil
    }
    
    guard urlResponse != nil else {
        return nil
    }
    
    guard let data = data else {
        return nil
    }
    
    let parsed: Any!
    do {
        parsed = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    } catch {
        return nil
    }
    
    guard let json = parsed as? [String : Any] else {
        return nil
    }
    
    guard let mappable = MAPPABLE(JSON: json) else {
        return nil
    }
    
    guard let code = (urlResponse as? HTTPURLResponse)?.statusCode else {
        return nil
    }
    
    guard HttpStatusCode.from(code: code) != nil else {
        return nil
    }

    return mappable
}


//MARK: JSON from URLSession RxSwift

private func getJsonWithObserver<MAPPABLE: Mappable>(_ observer: AnyObserver<MAPPABLE>, data: Data?, urlResponse: URLResponse?, error: Error?) {
    guard error == nil else {
        observer.onError(RequestError.Error(error!))
        return
    }
    
    guard urlResponse != nil else {
        observer.onError(RequestError.NoResponse)
        return
    }
    
    guard let data = data else {
        observer.onError(RequestError.NoDataReturned)
        return
    }
    
    let parsed: Any!
    do {
        parsed = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    } catch {
        observer.onError(RequestError.ErrorParsingData)
        return
    }
    
    guard let json = parsed as? [String : Any] else {
        observer.onError(RequestError.ErrorParsingJson)
        return
    }
    
    guard let mappable = MAPPABLE(JSON: json) else {
        observer.onError(RequestError.MappableError)
        return
    }
    
    guard let code = (urlResponse as? HTTPURLResponse)?.statusCode else {
        observer.onError(RequestError.NoHttpResponse)
        return
    }
    
    guard let httpCode = HttpStatusCode.from(code: code) else {
        observer.onError(RequestError.Failure(statusCode: .InvalidHttpStatusCode))
        return
    }
    
    guard httpCode.isSuccess == true else {
        
        // if response is unsuccesful try casting to TmdbResponse
        guard let tmdbResponse = (mappable as? TmdbResponse) else {
            observer.onError(RequestError.Failure(statusCode: httpCode))
            return
        }
        
        // get tmdb_message and tmdb_status_code from TmdbResponse
        guard let tmdbCode = tmdbResponse.status_code, let tmdbMessage = tmdbResponse.status_message else {
            observer.onError(RequestError.Failure(statusCode: httpCode))
            return
        }
        
        observer.onError(RequestError.RequestUnsuccesful(httpCode: httpCode, tmdbCode: tmdbCode, message: tmdbMessage))
        return
    }
    
    observer.onNext(mappable)
}


//MARK: Data from URLSession

private func getData(data: Data?, urlResponse: URLResponse?, error: Error?) -> Data?{
    
    guard error == nil else {
        return nil
    }
    
    guard urlResponse != nil else {
        return nil
    }
    
    guard let data = data else {
        return nil
    }
    
    return data
}


//MARK: Data from URLSession RxSwift

private func getDataWithObserver(_ observer: AnyObserver<Data>, data: Data?, urlResponse: URLResponse?, error: Error?) {
    
    guard error == nil else {
        observer.onError(RequestError.Error(error!))
        return
    }
    
    guard urlResponse != nil else {
        observer.onError(RequestError.NoResponse)
        return
    }
    
    guard let data = data else {
        observer.onError(RequestError.NoDataReturned)
        return
    }
    
    observer.onNext(data)
}


//MARK: Errors

enum RequestError: Error{
    case NoResponse
    case NoHttpResponse
    case NoHttpCodeResponse
    case InvalidUrl
    case Error(_: Error)
    case ErrorParsingData
    case ErrorParsingJson
    case MappableError
    case NoDataReturned
    case Failure(statusCode: HttpStatusCode)
    case RequestUnsuccesful(httpCode: HttpStatusCode, tmdbCode: TmdbStatusCode, message: String)
}

enum PostRequestError: Error{
    case ErrorParsingBodyToString
    case ErrorParsingBodyToData
}
