//
//  FoodModel.swift
//  FlochatTest
//
//  Created by Rushabh Bhatt on 31/01/18.
//  Copyright © 2018 Rushabh. All rights reserved.
//

import Foundation
import ObjectMapper
class FoodModel:Mappable{
    
    var collection:Array<Collection>!
    
    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        collection<-map["collections"]
    }
}
class Collection:Mappable{
    var collectionItem:CollectionItem!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        collectionItem<-map["collection"]
    }
}
class CollectionItem:Mappable{
    var collectionId:Int!
    var resCount:Int!
    var imageUrl:String!
    var url:String!
    var title:String!
    var description:String!
    var shareUrl:String!
    
    var attributedTitle:NSAttributedString!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        collectionId<-map["collection_id"]
        resCount<-map["res_count"]
        imageUrl<-map["image_url"]
        url<-map["url"]
        title<-map["title"]
        description<-map["description"]
        shareUrl<-map["shareUrl"]        
    }
}
