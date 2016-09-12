//
//  MeViewController.swift
//  LocalDemo
//
//  Created by gongkai on 15/6/4.
//  Copyright (c) 2015年 gongkai. All rights reserved.
//

import UIKit


//MARK:APP语言
let APPLanguages:NSDictionary = ["中文":"zh-Hans","English":"en"]

class MeViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    private var languageBgView: UIButton?
    private var pickerView: UIPickerView?
    
    @IBOutlet weak var languageBtn: UIButton!
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hide()
    }
    
    //MARK:event
    @IBAction func onLanguage(sender: UIButton) {
        if(languageBgView == nil){
            languageBgView = UIButton(frame: UIScreen.mainScreen().bounds)
            languageBgView?.backgroundColor = UIColor(red:0.000 , green:0.000 , blue:0.000, alpha:0.8)
            languageBgView?.addTarget(self, action: #selector(MeViewController.hide), forControlEvents: .TouchUpInside)
            
            let languageView = UIView(frame: CGRectMake(0, languageBgView!.frame.size.height - 200, languageBgView!.frame.size.width, 200))
            self.languageBgView?.addSubview(languageView)
            languageView.backgroundColor = UIColor.whiteColor()
            
            let topView = UIView(frame: CGRectMake(0, 0, languageView.frame.size.width, 40))
            languageView.addSubview(topView)
            
            let cancelBtn = UIButton(frame: CGRectMake(10, 0, 60, 40))
            cancelBtn.tag = 10
            cancelBtn.setTitleColor(UIColor(red:0.949 , green:0.349 , blue:0.122, alpha:1.0)
                , forState: .Normal)
            cancelBtn.addTarget(self, action: #selector(MeViewController.hide), forControlEvents: .TouchUpInside)
            topView.addSubview(cancelBtn)
            
            let changeBtn = UIButton(frame: CGRectMake(topView.frame.size.width-70, 0, 70, 40))
            changeBtn.tag = 11
            changeBtn.setTitleColor(UIColor(red:0.949 , green:0.349 , blue:0.122, alpha:1.0)
                , forState: .Normal)
            changeBtn.addTarget(self, action: #selector(MeViewController.change), forControlEvents: .TouchUpInside)
            topView.addSubview(changeBtn)
            
            self.pickerView = UIPickerView(frame: CGRectMake(0, 40, languageView.frame.size.width, languageView.frame.size.height-40))
            self.pickerView!.dataSource = self
            self.pickerView!.delegate = self
            languageView.addSubview(self.pickerView!)
        }
        let languagesVal:NSArray = APPLanguages.allValues
        self.pickerView?.selectRow(languagesVal.indexOfObject(Languager.standardLanguager().currentLanguage), inComponent: 0, animated: false)
        
        (languageBgView?.viewWithTag(10) as! UIButton).setTitle(localized("取消"), forState: .Normal)
        (languageBgView?.viewWithTag(11) as! UIButton).setTitle(localized("切换"), forState: .Normal)
        UIApplication.sharedApplication().keyWindow?.addSubview(self.languageBgView!)
        
        
        
    }
    
    func hide(){
        self.languageBgView?.removeFromSuperview()
    }
    
    //MARK: 切换语言
    func change() {
        let row = self.pickerView!.selectedRowInComponent(0)
        let key = APPLanguages.allKeys[row] as! String
        
        //切换语言
        Languager.standardLanguager().currentLanguage = APPLanguages.objectForKey(key) as! String
        
        
        self.languageBtn.setTitle(key, forState: .Normal)
        self.hide()
        
        
        //重新设置root viewcontroller，重新加载时会加载切换后的语言资源
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        let rootViewC = mainSb.instantiateInitialViewController() as! UITabBarController
        rootViewC.selectedIndex = 1  //回到设置页面
        UIApplication.sharedApplication().delegate!.window!!.rootViewController = rootViewC
    }
    
    
    //MARK:delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return APPLanguages.count
    }
    
    func pickerView(pickerView: UIPickerView,titleForRow row:Int,forComponent component:Int) -> String? {
        return APPLanguages.allKeys[row] as? String
    }
}
