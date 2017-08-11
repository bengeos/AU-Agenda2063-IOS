//
//  FiveTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class FiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fiveImage: UIImageView!
    @IBOutlet weak var fiveTitle: UILabel!
    
    @IBOutlet weak var fiveDetail: UILabel!
    
    @IBOutlet weak var fiveAuthor: UILabel!
    
    @IBOutlet weak var fiveTime: UILabel!
    
    @IBOutlet weak var fiveCountry: UILabel!
    
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
    
    func configureCell(asp: AspFive){
        
        self.fiveDetail.text = asp.fiveDetail
        self.fiveTitle.text = asp.fiveTitle
        self.fiveCountry.text = asp.fiveLocation
        self.fiveAuthor.text = asp.fiveAuthor
        self.fiveTime.text = asp.fiveTime
        
        
        let imageURL = asp.fivePhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.fiveImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
