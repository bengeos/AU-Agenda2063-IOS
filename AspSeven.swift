//
//  AspSeven.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspSeven {
    
    var sevenTitle: String!
    var sevenLocation: String?
    var sevenDetail: String?
    var sevenAuthor: String?
    var sevenPhotoURL: String!
    var sevenTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        sevenTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        sevenLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        sevenDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        sevenAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        sevenTime = (snapshot.value! as! NSDictionary)["time"] as? String
        sevenPhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
