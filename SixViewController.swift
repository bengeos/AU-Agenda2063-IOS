//
//  SixViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/11/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import Firebase

class SixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayAspSix = [AspSix]()
    
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
            var fetchedDevotionals = [AspSix]()
            
            for user in snapshot.children {
                
                let user = AspSix(snapshot: user as! DataSnapshot)
                
                fetchedDevotionals.append(user)
                
                
            }
            
            self.arrayAspSix = fetchedDevotionals.sorted(by: { (u1, u2) -> Bool in
                u1.sixTitle < u2.sixTitle
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
        return arrayAspSix.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAspSix", for: indexPath) as! SixTableViewCell
        
        // Configure the cell...
        
        cell.sixDetail.text = arrayAspSix[indexPath.row].sixDetail
        cell.sixTitle.text = arrayAspSix[indexPath.row].sixTitle
        cell.sixCountry.text = arrayAspSix[indexPath.row].sixLocation
        cell.sixAuthor.text = arrayAspSix[indexPath.row].sixAuthor
        cell.sixTime.text = arrayAspSix[indexPath.row].sixTime
        
        
        let imageURL = arrayAspSix[indexPath.row].sixPhotoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.sixImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailaspsix") {
            
            let VC = segue.destination as! SixDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = arrayAspSix[indexpath.row].sixTitle as String
                VC.SentData1 = Title
                
                let detailLoc = arrayAspSix[indexpath.row].sixLocation! as String
                VC.SentData2 = detailLoc
                
                let Imageview = arrayAspSix[indexpath.row].sixPhotoURL as String
                VC.SentData3 = Imageview
                
                let detailDesc = arrayAspSix[indexpath.row].sixDetail! as String
                VC.SentData4 = detailDesc
                
                let detailTime = arrayAspSix[indexpath.row].sixTime! as String
                VC.SentData5 = detailTime
                
                let detailAuthor = arrayAspSix[indexpath.row].sixAuthor! as String
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
