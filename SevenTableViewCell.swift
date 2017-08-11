//
//  SevenTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class SevenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sevenImage: UIImageView!
    @IBOutlet weak var sevenTitle: UILabel!
    
    @IBOutlet weak var sevenDetail: UILabel!
    
    @IBOutlet weak var sevenAuthor: UILabel!
    
    @IBOutlet weak var sevenTime: UILabel!
    
    @IBOutlet weak var sevenCountry: UILabel!
    
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
    
    func configureCell(asp: AspSeven){
        
        self.sevenDetail.text = asp.sevenDetail
        self.sevenTitle.text = asp.sevenTitle
        self.sevenCountry.text = asp.sevenLocation
        self.sevenAuthor.text = asp.sevenAuthor
        self.sevenTime.text = asp.sevenTime
        
        
        let imageURL = asp.sevenPhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.sevenImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
