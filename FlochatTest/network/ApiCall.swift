//
//  ApiCall.swift
//  retailerapp
//
// 
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper



class EndPoint{
    static let appUrl="https://api.myjson.com/bins/"
    static let foodItems="9wn11"
}

class ApiEndPoints{
    
    var apiCall:ApiCall
    var sessionManager:SessionManager=SessionManager()
    
    init(){
        apiCall=ApiCall()
    }
   
    func fetchFoodItems()->Observable<FoodModel>{
        return call(endPoint: EndPoint.foodItems, method: .get, responseType: FoodModel.self)
    }
    
    func call<R:Mappable>(endPoint:String,
              method:HTTPMethod,responseType:R.Type)->Observable<R>{
        return apiCall.callApi(method: method, url: endPoint,
                               responseType: R.self)
    }
    

}
class ApiCall{
    
    
    var sessionManager=SessionManager()
    init() {
        
    }

    func callApi<T:Mappable>(method:HTTPMethod,url:String,
                 responseType:T.Type)->Observable<T>{
        
        let requestInformation=prepareRequestData(url: url)
        let request : Observable<T> = RxAlamofire.requestJSON(method, requestInformation.url,parameters: [:],
                                                              encoding: JSONEncoding.default,
                                                       headers:requestInformation.headers).mapObject(type: responseType).subscribeOn(MainScheduler.instance)
        return request
        
    
    }
    
    
    func prepareRequestData(url:String)->(headers:[String:String],url:String){
        let url=(EndPoint.appUrl+url).encodeUrl()
    
        return (headers:[:],url:url);
        
    }
}
