//
//  ViewController.swift
//  LocalDemo
//
//  Created by gongkai on 15/5/27.
//  Copyright (c) 2015年 gongkai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(NSLocalizedString("首页",comment: ""))
        println(NSLocalizedString("好友",comment: ""))
        println(NSLocalizedString("我",comment: ""))
        
        UIImage(named: NSLocalizedString("ic_home",comment: ""))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
        
    }


}

