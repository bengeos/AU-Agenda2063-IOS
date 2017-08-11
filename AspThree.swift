//
//  AspThree.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspThree {
    
    var threeTitle: String!
    var threeLocation: String?
    var threeDetail: String?
    var threeAuthor: String?
    var threePhotoURL: String!
    var threeTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        threeTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        threeLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        threeDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        threeAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        threeTime = (snapshot.value! as! NSDictionary)["time"] as? String
        threePhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
