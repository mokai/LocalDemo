//
//  HomeViewController.swift
//  LocalDemo
//
//  Created by gongkai on 15/6/4.
//  Copyright (c) 2015年 gongkai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var searchText: UITextField!

    @IBOutlet weak var logoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.image = UIImage(named: localized("search_logo"))
    }
    
    /**
    传递参数
    :param: segue
    :param: sender
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let searchVC = segue.destinationViewController as? SearchViewController {
            searchVC.text = searchText.text
        }
    }
}
