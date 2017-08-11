//
//  AspTwo.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspTwo {
    
    var twoTitle: String!
    var twoLocation: String?
    var twoDetail: String?
    var twoAuthor: String?
    var twoPhotoURL: String!
    var twoTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        twoTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        twoLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        twoDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        twoAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        twoTime = (snapshot.value! as! NSDictionary)["time"] as? String
        twoPhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
