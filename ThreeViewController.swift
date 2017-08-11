//
//  ThreeViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class ThreeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayAspThree = [AspThree]()
    
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
            var fetchedDevotionals = [AspThree]()
            
            for user in snapshot.children {
                
                let user = AspThree(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspThree = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.threeTitle < u2.threeTitle
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
        return arrayAspThree.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspThree", for: indexPath) as! ThreeTableViewCell
        
        // Configure the cell...
        
        cell.threeDetail.text = arrayAspThree[indexPath.row].threeDetail
        cell.threeTitle.text = arrayAspThree[indexPath.row].threeTitle
        cell.threeCountry.text = arrayAspThree[indexPath.row].threeLocation
        cell.threeAuthor.text = arrayAspThree[indexPath.row].threeAuthor
        cell.threeTime.text = arrayAspThree[indexPath.row].threeTime
        
        
        let imageURL = arrayAspThree[indexPath.row].threePhotoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.threeImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailaspthree") {
            
            let VC = segue.destination as! ThreeDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspThree[indexpath.row].threeTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspThree[indexpath.row].threeLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspThree[indexpath.row].threePhotoURL as String
                VC.SentData3 = Imageview
                
                let detailDesc = arrayAspThree[indexpath.row].threeDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspThree[indexpath.row].threeTime! as String
                VC.SentData5 = detailTime
                
                let detailAuthor = arrayAspThree[indexpath.row].threeAuthor! as String
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
