//
//  NewsTableViewCell.swift
//  YAT2063
//
//  Created by Muluken on 8/9/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var newsDetail: UILabel!
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
    
    func configureCell(news: News){
        
        self.newsDetail.text = news.summary
        self.newsTitle.text = news.title
        self.author.text = news.author
        self.time.text = news.time
        self.country.text = news.country
        
        let imageURL = news.photoURL!
        
        self.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
}
