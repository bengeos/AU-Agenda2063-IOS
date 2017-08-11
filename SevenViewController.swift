//
//  SevenViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class SevenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayAspSeven = [AspSeven]()
    
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
            var fetchedDevotionals = [AspSeven]()
            
            for user in snapshot.children {
                
                let user = AspSeven(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspSeven = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.sevenTitle < u2.sevenTitle
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
        return arrayAspSeven.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspSeven", for: indexPath) as! SevenTableViewCell
        
        // Configure the cell...
        
        cell.sevenDetail.text = arrayAspSeven[indexPath.row].sevenDetail
        cell.sevenTitle.text = arrayAspSeven[indexPath.row].sevenTitle
        cell.sevenCountry.text = arrayAspSeven[indexPath.row].sevenLocation
        cell.sevenAuthor.text = arrayAspSeven[indexPath.row].sevenAuthor
        cell.sevenTime.text = arrayAspSeven[indexPath.row].sevenTime
        
        
        let imageURL = arrayAspSeven[indexPath.row].sevenPhotoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.sevenImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailaspseven") {
            
            let VC = segue.destination as! SevenDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspSeven[indexpath.row].sevenTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspSeven[indexpath.row].sevenLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspSeven[indexpath.row].sevenPhotoURL as String
                VC.SentData3 = Imageview
                
                let detailDesc = arrayAspSeven[indexpath.row].sevenDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspSeven[indexpath.row].sevenTime! as String
                VC.SentData5 = detailTime
                
                let detailAuthor = arrayAspSeven[indexpath.row].sevenAuthor! as String
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
