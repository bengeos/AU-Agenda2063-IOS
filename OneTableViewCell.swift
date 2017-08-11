//
//  OneTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class OneTableViewCell: UITableViewCell {

    @IBOutlet weak var oneImage: UIImageView!
    @IBOutlet weak var oneTitle: UILabel!
  
    @IBOutlet weak var oneDetail: UILabel!
    
    @IBOutlet weak var oneAuthor: UILabel!
    
    @IBOutlet weak var oneTime: UILabel!
    
    @IBOutlet weak var oneCountry: UILabel!
    
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
    
    func configureCell(asp1: AspOne){
        
        self.oneDetail.text = asp1.oneDetail
        self.oneTitle.text = asp1.oneTitle
        self.oneCountry.text = asp1.oneLocation
        self.oneAuthor.text = asp1.oneAuthor
        self.oneTime.text = asp1.oneTime

        
        let imageURL = asp1.onePhotoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.oneImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
