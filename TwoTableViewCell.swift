//
//  TwoTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class TwoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var twoImage: UIImageView!
    @IBOutlet weak var twoTitle: UILabel!
    
    @IBOutlet weak var twoDetail: UILabel!
    
    @IBOutlet weak var twoAuthor: UILabel!
    
    @IBOutlet weak var twoTime: UILabel!
    
    @IBOutlet weak var twoCountry: UILabel!
    
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
    
    func configureCell(asp: AspTwo){
        
        self.twoDetail.text = asp.twoDetail
        self.twoTitle.text = asp.twoTitle
        self.twoCountry.text = asp.twoLocation
        self.twoAuthor.text = asp.twoAuthor
        self.twoTime.text = asp.twoTime
        
        
        let imageURL = asp.twoPhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.twoImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
