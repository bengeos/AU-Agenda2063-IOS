//
//  FourViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class FourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayAspFour = [AspFour]()
    
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
            var fetchedDevotionals = [AspFour]()
            
            for user in snapshot.children {
                
                let user = AspFour(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspFour = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.fourTitle < u2.fourTitle
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
        return arrayAspFour.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspFour", for: indexPath) as! FourTableViewCell
        
        // Configure the cell...
        
        cell.fourDetail.text = arrayAspFour[indexPath.row].fourDetail
        cell.fourTitle.text = arrayAspFour[indexPath.row].fourTitle
        cell.fourCountry.text = arrayAspFour[indexPath.row].fourLocation
        cell.fourAuthor.text = arrayAspFour[indexPath.row].fourAuthor
        cell.fourTime.text = arrayAspFour[indexPath.row].fourTime
        
        
        let imageURL = arrayAspFour[indexPath.row].fourPhotoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.fourImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailaspfour") {
            
            let VC = segue.destination as! FourDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspFour[indexpath.row].fourTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspFour[indexpath.row].fourLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspFour[indexpath.row].fourPhotoURL as String
                VC.SentData3 = Imageview
                
                let detailDesc = arrayAspFour[indexpath.row].fourDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspFour[indexpath.row].fourTime! as String
                VC.SentData5 = detailTime
                
                let detailAuthor = arrayAspFour[indexpath.row].fourAuthor! as String
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
