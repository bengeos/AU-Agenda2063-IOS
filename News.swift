//
//  News.swift
//  YAT2063
//
//  Created by Muluken on 8/9/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct News {
    
    var title: String!
    var summary: String?
    var detailnews: String?
    var photoURL: String!
    var author: String!
    var time: String!
    var country: String!
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        title = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        summary = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        detailnews = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        author = (snapshot.value! as! NSDictionary)["publisher"] as? String
        time = (snapshot.value! as! NSDictionary)["time"] as? String
        country = (snapshot.value! as! NSDictionary)["location"] as? String
        photoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
