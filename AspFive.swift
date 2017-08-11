//
//  AspFive.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspFive {
    
    var fiveTitle: String!
    var fiveLocation: String?
    var fiveDetail: String?
    var fiveAuthor: String?
    var fivePhotoURL: String!
    var fiveTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        fiveTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        fiveLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        fiveDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        fiveAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        fiveTime = (snapshot.value! as! NSDictionary)["time"] as? String
        fivePhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
