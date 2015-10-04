//
//  SearchViewController.swift
//  LocalDemo
//
//  Created by gongkai on 15/6/4.
//  Copyright (c) 2015年 gongkai. All rights reserved.
//

import UIKit


let baidu = "https://www.baidu.com/s?wd="
let google = "https://www.google.co.jp/?gfe_rd=cr&ei=J79vVePnIoqT8QeiqoDACw#q="

class SearchViewController: UIViewController {
    var text:String?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //判断当前语言是否为中文
        var url:String?
        if(Languager.standardLanguager().currentLanguage != "en"){
            url = baidu + text!
        }else{
            url = google + text!
        }
        let req = NSURLRequest(URL: NSURL(string: url!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!)
        webView.loadRequest(req)
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
