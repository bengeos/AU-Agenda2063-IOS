//
//  TwoViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class TwoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayAspTwo = [AspTwo]()
    
    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    var storageRef: Storage {
        
        return Storage.storage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let nav = self.navigationController?.navigationBar
        //        nav?.barStyle = UIBarStyle.black
        //        nav?.tintColor = UIColor.white
        //        nav?.backgroundColor = UIColor(red: 38.0/255.0, green: 64.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        //        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        dataBaseRef.child("News").observe(.value, with: { (snapshot) in
            var fetchedDevotionals = [AspTwo]()
            
            for user in snapshot.children {
                
                let user = AspTwo(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspTwo = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.twoTitle < u2.twoTitle
            })
            self.tableView.reloadData()
            print(fetchedDevotionals)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayAspTwo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspTwo", for: indexPath) as! TwoTableViewCell
        
        // Configure the cell...
        
        cell.twoDetail.text = arrayAspTwo[indexPath.row].twoDetail
        cell.twoTitle.text = arrayAspTwo[indexPath.row].twoTitle
        cell.twoCountry.text = arrayAspTwo[indexPath.row].twoLocation
        cell.twoAuthor.text = arrayAspTwo[indexPath.row].twoAuthor
        cell.twoTime.text = arrayAspTwo[indexPath.row].twoTime
        
        
        let imageURL = arrayAspTwo[indexPath.row].twoPhotoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.twoImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailasptwo") {
            
            let VC = segue.destination as! TwoDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspTwo[indexpath.row].twoTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspTwo[indexpath.row].twoLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspTwo[indexpath.row].twoPhotoURL as String
                VC.SentData3 = Imageview
                
                let detailDesc = arrayAspTwo[indexpath.row].twoDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspTwo[indexpath.row].twoTime! as String
                VC.SentData5 = detailTime
                
                let detailAuthor = arrayAspTwo[indexpath.row].twoAuthor! as String
                VC.SentData6 = detailAuthor
                //                let Imageview2 = imageGoalBot[indexpath.row] as String
                //                VC.SentData5 = Imageview2
                
            }
            
            
        }
    }
    
    //    @IBAction func back(_ sender: Any) {
    //        self.dismiss(animated: true, completion: nil)
    //    }
    //
    
}
