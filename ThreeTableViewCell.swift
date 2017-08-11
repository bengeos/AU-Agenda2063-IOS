//
//  ThreeTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class ThreeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var threeImage: UIImageView!
    @IBOutlet weak var threeTitle: UILabel!
    
    @IBOutlet weak var threeDetail: UILabel!
    
    @IBOutlet weak var threeAuthor: UILabel!
    
    @IBOutlet weak var threeTime: UILabel!
    
    @IBOutlet weak var threeCountry: UILabel!
    
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
    
    func configureCell(asp: AspThree){
        
        self.threeDetail.text = asp.threeDetail
        self.threeTitle.text = asp.threeTitle
        self.threeCountry.text = asp.threeLocation
        self.threeAuthor.text = asp.threeAuthor
        self.threeTime.text = asp.threeTime
        
        
        let imageURL = asp.threePhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.threeImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
