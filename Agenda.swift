//
//  Agenda.swift
//  YAT2063
//
//  Created by Muluken on 8/10/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


struct Agenda {
    
    var devoTitle: String!
    var devoSummary: String?
//    var devoDetailnews: String?
//    var devoPhotoURL: String!
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        devoTitle = (snapshot.value! as! NSDictionary)["agendatitle"] as! String
        devoSummary = (snapshot.value! as! NSDictionary)["agendadetail"] as? String
//        devoDetailnews = (snapshot.value! as! NSDictionary)["devodetail"] as? String
//        devoPhotoURL = (snapshot.value! as! NSDictionary)["devoimg"] as! String
        
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
