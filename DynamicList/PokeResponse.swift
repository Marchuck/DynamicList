//
//  PokeResponse.swift
//  DynamicList
//
//  Created by Łukasz Marczak on 15.04.2017.
//  Copyright © 2017 Łukasz Marczak. All rights reserved.
//

import Foundation

import Alamofire


struct Poke{
    let name: String
    
    init(name: String){
        self.name=name;
    }
}


protocol  Receiver {
    func onReceive(pokes: [Poke] );
}
typealias JSONStandard = [String: AnyObject]
typealias PokeResponse = ((_ failed: Bool, _ errorMessage: String?, _ pokedex: [Poke]? ) -> ())

class PokeFetcher{
    
    static let errorMessageDefault = "Something went wrong"
    static let errorMessageNoInternet = "No internet"
    static let errorMessageNoStatusResponse = "No response"
    
    static  func fetch(url: String, completion: PokeResponse?){
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                // 1. check for server reachibility
                guard response.result.isSuccess else {
                    if let errorCode = response.result.error?._code,
                        errorCode == HTTPStatusCode.noInternet.rawValue {    // When there's no internet
                        completion?(true,  self.errorMessageNoInternet,nil)
                        return
                    }
                    completion?(true,  self.errorMessageNoStatusResponse,nil)
                    return
                }
                
                // 2. check for responseJSON
                guard let responseJSON = response.result.value as? JSONStandard,
                    let pokesAsJson = responseJSON["pokemon"] as? [JSONStandard]
                    else {
                        completion?(true,  self.errorMessageNoStatusResponse,nil)
                        return
                }
                
                var pokes = [Poke]()
                
                for j in pokesAsJson{
                    pokes.append(Poke(name: j["name"] as! String))
                }
                completion?(false,  nil, pokes)
        }
    }
}
