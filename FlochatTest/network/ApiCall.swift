//
//  ApiCall.swift
//  retailerapp
//
//  Created by Rushabh Bhatt on 28/04/17.
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper



class EndPoint{

    static let appUrl="http://12.2.2.2/"

}

class ApiEndPoints{
    
    var apiCall:ApiCall
    var sessionManager:SessionManager=SessionManager()
    init(){
        apiCall=ApiCall()
    }
   
    func call<T:Mappable,R:Mappable>(requestObject:T?,endPoint:String,
        method:HTTPMethod,responseType:R.Type)->Observable<Array<R>>{
        let parameters=requestObject?.toJSON();
        
        return apiCall.callApi(parameters: parameters, method: method, url: endPoint,
                               responseType: R.self)
    }
    
    func call<T:Mappable,R:Mappable>(requestObject:T?,endPoint:String,
              method:HTTPMethod,responseType:R.Type)->Observable<R>{
        let parameters=requestObject?.toJSON();
        return apiCall.callApi(parameters: parameters, method: method, url: endPoint,
                               responseType: R.self)
    }
    

}
class ApiCall{
    
    
    var sessionManager=SessionManager()
    init() {
        
    }
    
    func callApi<T:Mappable>(parameters:[String:Any]?,method:HTTPMethod,url:String,
                 responseType:T.Type)->Observable<Array<T>>{
        
        
        let requestInformation=prepareRequestData(url: url)
        return RxAlamofire.requestJSON(method, requestInformation.url,parameters: parameters,
                                       headers:requestInformation.headers)
            .mapArray(type: responseType)
            .subscribeOn(MainScheduler.instance)
    }

    

    func callApi<T:Mappable>(parameters:[String:Any]?,method:HTTPMethod,url:String,
                 responseType:T.Type)->Observable<T>{
        print(parameters)
        let requestInformation=prepareRequestData(url: url)
        
        let request : Observable<T> = RxAlamofire.requestJSON(method, requestInformation.url,parameters: parameters,
                                                              encoding: JSONEncoding.default,
                                                       headers:requestInformation.headers).mapObject(type: responseType).subscribeOn(MainScheduler.instance)
        return request
        
    
    }
    
    
    func prepareRequestData(url:String)->(headers:[String:String],url:String){
        let url=(EndPoint.appUrl+url).encodeUrl()
        print(url)
        return (headers:[:],url:url);
        
    }
}
