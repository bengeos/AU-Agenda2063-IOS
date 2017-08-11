//
//  FiveViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class FiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayAspFive = [AspFive]()
    
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
            var fetchedDevotionals = [AspFive]()
            
            for user in snapshot.children {
                
                let user = AspFive(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspFive = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.fiveTitle < u2.fiveTitle
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
        return arrayAspFive.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspFive", for: indexPath) as! FiveTableViewCell
        
        // Configure the cell...
        
        cell.fiveDetail.text = arrayAspFive[indexPath.row].fiveDetail
        cell.fiveTitle.text = arrayAspFive[indexPath.row].fiveTitle
        cell.fiveCountry.text = arrayAspFive[indexPath.row].fiveLocation
        cell.fiveAuthor.text = arrayAspFive[indexPath.row].fiveAuthor
        cell.fiveTime.text = arrayAspFive[indexPath.row].fiveTime
        
        
        let imageURL = arrayAspFive[indexPath.row].fivePhotoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.fiveImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailaspfive") {
            
            let VC = segue.destination as! FiveDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspFive[indexpath.row].fiveTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspFive[indexpath.row].fiveLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspFive[indexpath.row].fivePhotoURL as String
                VC.SentData3 = Imageview
                
                let detailDesc = arrayAspFive[indexpath.row].fiveDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspFive[indexpath.row].fiveTime! as String
                VC.SentData5 = detailTime
                
                let detailAuthor = arrayAspFive[indexpath.row].fiveAuthor! as String
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
