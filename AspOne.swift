//
//  AspOne.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspOne {
    
    var oneTitle: String!
    var oneLocation: String?
    var oneDetail: String?
    var oneAuthor: String?
    var onePhotoURL: String!
    var oneTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        oneTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        oneLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        oneDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        oneAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        oneTime = (snapshot.value! as! NSDictionary)["time"] as? String
        onePhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String

        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
