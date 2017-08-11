//
//  AgendaTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/10/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class AgendaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var devoDetail: UILabel!
    @IBOutlet weak var devoTItle: UILabel!
    //@IBOutlet weak var devoImage: UIImageView!

    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: Storage {
        
        return Storage.storage()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // newsimage.layer.cornerRadius = 54
        
    }
    
    func configureCell(user: Agenda){
        
        self.devoDetail.text = user.devoSummary
        self.devoTItle.text = user.devoTitle
        
        
//        let imageURL = user.devoPhotoURL!
//        
//        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
//            
//            if error == nil {
//                DispatchQueue.main.async {
//                    if let data = imgData {
//                        self.devoImage.image = UIImage(data: data)
//                    }
//                }
//                
//            }else {
//                print(error!.localizedDescription)
//                
//            }
//            
//            
//        })
    }
    
}
