//
//  AspSix.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct AspSix {
    
    var sixTitle: String!
    var sixLocation: String?
    var sixDetail: String?
    var sixAuthor: String?
    var sixPhotoURL: String!
    var sixTime: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        sixTitle = (snapshot.value! as! NSDictionary)["newstitle"] as! String
        sixLocation = (snapshot.value! as! NSDictionary)["location"] as? String
        sixDetail = (snapshot.value! as! NSDictionary)["newsdetail"] as? String
        sixAuthor = (snapshot.value! as! NSDictionary)["publisher"] as? String
        sixTime = (snapshot.value! as! NSDictionary)["time"] as? String
        sixPhotoURL = (snapshot.value! as! NSDictionary)["newsimg"] as! String
        
        
        
        
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
