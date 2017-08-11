//
//  SixTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class SixTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sixImage: UIImageView!
    @IBOutlet weak var sixTitle: UILabel!
    
    @IBOutlet weak var sixDetail: UILabel!
    
    @IBOutlet weak var sixAuthor: UILabel!
    
    @IBOutlet weak var sixTime: UILabel!
    
    @IBOutlet weak var sixCountry: UILabel!
    
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
    
    func configureCell(asp: AspSix){
        
        self.sixDetail.text = asp.sixDetail
        self.sixTitle.text = asp.sixTitle
        self.sixCountry.text = asp.sixLocation
        self.sixAuthor.text = asp.sixAuthor
        self.sixTime.text = asp.sixTime
        
        
        let imageURL = asp.sixPhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.sixImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
