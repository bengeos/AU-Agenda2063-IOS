//
//  ThreeDetailViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class ThreeDetailViewController: UIViewController {
    
    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    
    var storageRef: Storage {
        
        return Storage.storage()
    }
    
    @IBOutlet weak var threeDetailTitle: UILabel!
    @IBOutlet weak var threeDetailTime: UILabel!
    
    @IBOutlet weak var threeDetailCountry: UILabel!
    @IBOutlet weak var threeDetailAuthor: UILabel!
    
    @IBOutlet weak var threeDetailImage: UIImageView!
    
    @IBOutlet weak var threeDetailDesc: UITextView!
    
    
    
    var SentData1:String!
    var SentData2:String!
    var SentData3:String!
    var SentData4:String!
    var SentData5:String!
    var SentData6:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let nav = self.navigationController?.navigationBar
        //        nav?.barStyle = UIBarStyle.black
        //        nav?.tintColor = UIColor.white
        //        nav?.backgroundColor = UIColor(red: 38.0/255.0, green: 64.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        //        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        configureCellNews()
        
    }
    func configureCellNews(){
        
        self.threeDetailTitle.text = SentData1
        self.threeDetailCountry.text = SentData2
        self.threeDetailDesc.text = SentData4
        self.threeDetailTime.text = SentData5
        self.threeDetailAuthor.text = SentData6
        
        let imageURL = SentData3
        
        self.storageRef.reference(forURL: imageURL!).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        self.threeDetailImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}