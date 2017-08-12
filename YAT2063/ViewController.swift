//
//  ViewController.swift
//  YAT2063
//
//  Created by Muluken on 8/9/17.
//  Copyright © 2017 butyam. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        let attributes: [String: AnyObject] = [NSFontAttributeName:UIFont(name: "helvetica neue", size: 20)!, NSForegroundColorAttributeName: UIColor.black]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        let attributes2: [String: AnyObject] = [NSFontAttributeName:UIFont(name: "helvetica neue", size: 20)!, NSForegroundColorAttributeName: UIColor.white]
        appearance.setTitleTextAttributes(attributes2, for: .selected)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

