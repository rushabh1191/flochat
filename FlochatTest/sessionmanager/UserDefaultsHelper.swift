//
//  UserDefaultsHelper.swift
//  retailerapp
//
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation
struct SessionKeys{
    static let isUserLoggedIn="is_user_logged_in"
    
}
class SessionHelper{
    var userDefaultHelper=UserDefaultsHelper()
    init() {
        
    }
    func isUserLoggedIn()->Bool{
        return userDefaultHelper.get(sessionKey: SessionKeys.isUserLoggedIn, defValue: false)
    }
    func setUserLoggedIn(isLoggedIn:Bool){
        return userDefaultHelper.set(sessionKey: SessionKeys.isUserLoggedIn, value: isLoggedIn)
    }
    
}
class UserDefaultsHelper{
    
    let defaults = UserDefaults.standard
    init(){
        
    }
    func set(sessionKey:String,value:String){
        defaults.set(value,forKey:sessionKey)
        defaults.synchronize()
    }
    func set(sessionKey:String,value:Int) {
        defaults.set(value,forKey:sessionKey)
    }
    func set(sessionKey:String,value:Any?){
        defaults.set(value,forKey:sessionKey)
    }
    func get(sessionKey:String,defValue:Bool)->Bool{
        let v = defaults.object(forKey: sessionKey)
        if let _=v{
            return v as! Bool
        }
        return defValue
    }
    func get(key:String)->String?{
        let value=defaults.object(forKey:key)
           return value as? String
    }
    
    func get(key:String)->Int{
        let value=defaults.object(forKey:key)
        if let _=value{
            return value as! Int
        }
        return -1
    }
    func resetUserDefaults(){
        let dict = defaults.dictionaryRepresentation() as NSDictionary
        for key in dict.allKeys {
            defaults.removeObject(forKey:key as! String)
        }
        defaults.synchronize()
        
    }
    
    
}
