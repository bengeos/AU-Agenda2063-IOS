//
//  AspirationOneViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class AspirationOneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrayAspOne = [AspOne]()
    
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
            var fetchedDevotionals = [AspOne]()
            
            for user in snapshot.children {
                
                let user = AspOne(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspOne = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.oneTitle < u2.oneTitle
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
        return arrayAspOne.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspOne", for: indexPath) as! OneTableViewCell
        
        // Configure the cell...
        
        cell.oneDetail.text = arrayAspOne[indexPath.row].oneDetail
        cell.oneTitle.text = arrayAspOne[indexPath.row].oneTitle
        cell.oneCountry.text = arrayAspOne[indexPath.row].oneLocation
        cell.oneAuthor.text = arrayAspOne[indexPath.row].oneAuthor
        cell.oneTime.text = arrayAspOne[indexPath.row].oneTime

        
                let imageURL = arrayAspOne[indexPath.row].onePhotoURL!
        
                cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
        
                    if error == nil {
                        DispatchQueue.main.async {
                            if let data = imgData {
                                cell.oneImage.image = UIImage(data: data)
                            }
                        }
        
                    }else {
                        print(error!.localizedDescription)
        
                    }
        
        
                })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailagenda") {
            
            let VC = segue.destination as! OneDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspOne[indexpath.row].oneTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspOne[indexpath.row].oneLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspOne[indexpath.row].onePhotoURL as String
                VC.SentData3 = Imageview
               
                let detailDesc = arrayAspOne[indexpath.row].oneDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspOne[indexpath.row].oneTime! as String
                VC.SentData5 = detailTime
               
                let detailAuthor = arrayAspOne[indexpath.row].oneAuthor! as String
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
