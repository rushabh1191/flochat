//
//  NetworkExtensions.swift
//  retailerapp
//
// 
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation

import RxSwift
import RxAlamofire
import RxAlamofire.Swift
import ObjectMapper
import Alamofire



extension ObservableType{
    
    public func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return flatMap { (data) -> Observable<T> in
            
        
            let d=data as! (HTTPURLResponse,Any)
        

            if(d.0.statusCode != 200){
                let json = d.1 as! [String:Any]
                
                throw Mapper<ErrorResponse>().map(JSON: json)!
            }
            else{
                
                var json:[String:Any] = [:]
                if(d.1 is String){
                    json=["message":d.1]
                }else{
                    json = d.1 as! [String:Any]
                }
                
                    guard let object = Mapper<T>().map(JSON:json)else {
                        throw ErrorResponse(
                            message: "Something went wrong",
                            code: -1,
                            userInf: [NSLocalizedDescriptionKey: "Something went wrong"]
                        )
                    }
                    return Observable.just(object)
                

                }
            }
            
        }
    
    public func mapArray<T: Mappable>(type: T.Type) -> Observable<Array<T>> {
        return flatMap { (data) -> Observable<Array<T>> in
            
            
            let d=data as! (HTTPURLResponse,Any)
            
            
            if(d.0.statusCode != 200){
                let json = d.1 as! [String:Any]
                throw Mapper<ErrorResponse>().map(JSON: json)!
            }
            else{


                let jsonArray = d.1 as! [[String:Any]]
                print(jsonArray)
                   let  listOfObjets=Mapper<T>().mapArray(JSONArray : jsonArray)
                
                
                    return Observable.just(listOfObjets)
                }
            }
            
        }
    }
