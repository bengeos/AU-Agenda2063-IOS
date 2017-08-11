//
//  AspFour.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspFour {
    
    var fourTitle: String!
    var fourLocation: String?
    var fourDetail: String?
    var fourAuthor: String?
    var fourPhotoURL: String!
    var fourTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        fourTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        fourLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        fourDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        fourAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        fourTime = (snapshot.value! as! NSDictionary)["time"] as? String
        fourPhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
