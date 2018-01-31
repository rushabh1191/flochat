//
//  GeneralExtension.swift
//  retailerapp
//
//  Copyright © 2017 Rushabh Bhatt. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func count()->Int{
        return self.count
    }
    func trim()->String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func encodeUrl()->String{
        return self.trim().addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!
    }
    
    func createGetUrl(values:[String:String])->String{
        
        var url=self.trim()
        
        url.append("?")
    
        for (key,value) in values {
            url.append(key + "=" + value+"&")
        }
        return url
    }
}
