//
//  FourTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class FourTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fourImage: UIImageView!
    @IBOutlet weak var fourTitle: UILabel!
    
    @IBOutlet weak var fourDetail: UILabel!
    
    @IBOutlet weak var fourAuthor: UILabel!
    
    @IBOutlet weak var fourTime: UILabel!
    
    @IBOutlet weak var fourCountry: UILabel!
    
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
    
    func configureCell(asp: AspFour){
        
        self.fourDetail.text = asp.fourDetail
        self.fourTitle.text = asp.fourTitle
        self.fourCountry.text = asp.fourLocation
        self.fourAuthor.text = asp.fourAuthor
        self.fourTime.text = asp.fourTime
        
        
        let imageURL = asp.fourPhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.fourImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
