//
//  NewsTableViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/9/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit
import SystemConfiguration
import Firebase
import FirebaseDatabase
import FirebaseStorage


class NewsTableViewController: UITableViewController {
    
    
    let emailField = "yatcafrica@gmail.com"
    let pwdField = "abc12345678"
    
    
    var newsArray = [News]()
    
    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    
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
        
        Auth.auth().signIn(withEmail: emailField, password: pwdField, completion: { (user, error) in
            if error == nil {
                print("Buty: Email user authenticated with Firebase")
                
            } else {
                print("Buty: Unable to authenticate with Firebase using email")
                
                
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNews()
    }
    
    func fetchNews(){
        //        dataBaseRef.child("News").queryOrdered(byChild: "newstitle").queryEqual(toValue: "agenda").observe(.value, with: { (snapshot) in

        
        dataBaseRef.child("News").observe(.value, with: { (snapshot) in
            var results = [News]()
            
            for user in snapshot.children {
                
                let user = News(snapshot: user as! DataSnapshot)
                print(user)
                results.append(user)
                
                
            }
            
            self.newsArray = results.sorted(by: { (u1, u2) -> Bool in
                u1.title < u2.title
            })
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        // Configure the cell...
        if isInternetAvailable(){
        cell.newsDetail.text = newsArray[indexPath.row].summary
        cell.newsTitle.text = newsArray[indexPath.row].title
            cell.time.text = newsArray[indexPath.row].time
            cell.country.text = newsArray[indexPath.row].country
            cell.author.text = newsArray[indexPath.row].author
        
        let imageURL = newsArray[indexPath.row].photoURL!
        
        cell.storageRef.reference(forURL: imageURL).getData(maxSize: 15 * 1024 * 1024, completion: { (imgData, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let data = imgData {
                        cell.newsImage.image = UIImage(data: data)
                    }
                }
                
            }else {
                print(error!.localizedDescription)
                
            }
            
            
        })
        } else {
            cell.newsTitle.text = "news"
            cell.newsDetail.text = "detail"
            

        }
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "newsdetail") {
            
            let VC = segue.destination as! DetailNewsViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = newsArray[indexpath.row].title as String
                VC.SentData1 = Title
                let Country = newsArray[indexpath.row].country as String
                VC.SentData2 = Country
                let Imageview = newsArray[indexpath.row].photoURL as String
                VC.SentData3 = Imageview
                let detailDesc = newsArray[indexpath.row].detailnews! as String
                VC.SentData4 = detailDesc
                let Author = newsArray[indexpath.row].author as String
                VC.SentData5 = Author
                let Time = newsArray[indexpath.row].time as String
                VC.SentData6 = Time
                
                //                let Imageview2 = imageGoalBot[indexpath.row] as String
                //                VC.SentData5 = Imageview2
                
            }
            
            
        }
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
}
