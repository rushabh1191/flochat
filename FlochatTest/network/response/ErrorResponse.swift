//
//  ErrorResponse.swift
//  retailerapp
//
//  Created by Rushabh Bhatt on 29/04/17.
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorResponse:NSError,Mappable{

    var message:String?
    var name:String?
    var status:Int?
    
    init(message:String,code:Int,userInf:[String:Any]) {
        super.init(domain: message, code: code, userInfo: userInf)
        self.message=message
        self.status=code
    }
    
    required init?(map: Map) {
        super.init(domain: "",code: 0,userInfo: nil)
        mapping(map: map)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func mapping(map: Map) {

        message<-map["Message"]
    }
}
