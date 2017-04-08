//
//  MeViewController.swift
//  LocalDemo
//
//  Created by gongkai on 15/6/4.
//  Copyright (c) 2015年 gongkai. All rights reserved.
//

import UIKit


//MARK:APP语言
let APPLanguages = [
    "中文" : "zh-Hans",
    "English" :"en"
]

class MeViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    fileprivate var languageBgView: UIButton?
    fileprivate var pickerView: UIPickerView?
    
    @IBOutlet weak var languageBtn: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hide()
    }
    
    //MARK:event
    @IBAction func onLanguage(_ sender: UIButton) {
        if(languageBgView == nil){
            languageBgView = UIButton(frame: UIScreen.main.bounds)
            languageBgView?.backgroundColor = UIColor(red:0.000 , green:0.000 , blue:0.000, alpha:0.8)
            languageBgView?.addTarget(self, action: #selector(MeViewController.hide), for: .touchUpInside)
            
            let languageView = UIView(frame: CGRect(x: 0, y: languageBgView!.frame.size.height - 200, width: languageBgView!.frame.size.width, height: 200))
            self.languageBgView?.addSubview(languageView)
            languageView.backgroundColor = UIColor.white
            
            let topView = UIView(frame: CGRect(x: 0, y: 0, width: languageView.frame.size.width, height: 40))
            languageView.addSubview(topView)
            
            let cancelBtn = UIButton(frame: CGRect(x: 10, y: 0, width: 60, height: 40))
            cancelBtn.tag = 10
            cancelBtn.setTitleColor(UIColor(red:0.949 , green:0.349 , blue:0.122, alpha:1.0)
                , for: UIControlState())
            cancelBtn.addTarget(self, action: #selector(MeViewController.hide), for: .touchUpInside)
            topView.addSubview(cancelBtn)
            
            let changeBtn = UIButton(frame: CGRect(x: topView.frame.size.width-70, y: 0, width: 70, height: 40))
            changeBtn.tag = 11
            changeBtn.setTitleColor(UIColor(red:0.949 , green:0.349 , blue:0.122, alpha:1.0)
                , for: UIControlState())
            changeBtn.addTarget(self, action: #selector(MeViewController.change), for: .touchUpInside)
            topView.addSubview(changeBtn)
            
            self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 40, width: languageView.frame.size.width, height: languageView.frame.size.height-40))
            self.pickerView!.dataSource = self
            self.pickerView!.delegate = self
            languageView.addSubview(self.pickerView!)
        }
        let languagesVal = Array(APPLanguages.values)
        self.pickerView?.selectRow(languagesVal.index(of: Languager.standardLanguager().currentLanguage)!, inComponent: 0, animated: false)
        
        (languageBgView?.viewWithTag(10) as! UIButton).setTitle(localized("取消"), for: UIControlState())
        (languageBgView?.viewWithTag(11) as! UIButton).setTitle(localized("切换"), for: UIControlState())
        UIApplication.shared.keyWindow?.addSubview(self.languageBgView!)
        
        
        
    }
    
    func hide(){
        self.languageBgView?.removeFromSuperview()
    }
    
    //MARK: 切换语言
    func change() {
        let row = self.pickerView!.selectedRow(inComponent: 0)
        let key = Array(APPLanguages.keys)[row]
        
        //切换语言
        Languager.standardLanguager().currentLanguage = APPLanguages[key]!
        
        self.languageBtn.setTitle(key, for: UIControlState())
        self.hide()
        
        
        //重新设置root viewcontroller，重新加载时会加载切换后的语言资源
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        let rootViewC = mainSb.instantiateInitialViewController() as! UITabBarController
        rootViewC.selectedIndex = 1  //回到设置页面
        UIApplication.shared.delegate!.window!!.rootViewController = rootViewC
    }
    
    
    //MARK:delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return APPLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row:Int,forComponent component:Int) -> String? {
        return Array(APPLanguages.values)[row]
    }
}
