//
//  Languager.swift
//  icar
//
//  Created by gongkai on 15/5/18.
//  Copyright (c) 2015年 anytracking. All rights reserved.
//
import UIKit
private let kUserLanguage = "AppleLanguages"

/**
*  国际化工具
*/
class Languager: NSObject {
    private struct Static {
        static var onceToken : dispatch_once_t = 0
        static var staticInstance : Languager? = nil
    }
    private var _currentLanguage:String?
    
    override init() {
        super.init()
        self.initLanguage()
    }
    
    //当前语言Bundle
    internal var currentLanguageBundle:NSBundle?
    
    
    // 当前语言获取与切换
    var currentLanguage:String{
        get{
            if(self._currentLanguage==nil){
                self._currentLanguage = (NSUserDefaults.standardUserDefaults().valueForKey(kUserLanguage) as! Array<String>)[0]
            }
            return self._currentLanguage!
        }
        set(newLanguage){
            if(self._currentLanguage == newLanguage){
                return
            }
            if let path = NSBundle.mainBundle().pathForResource(newLanguage, ofType: "lproj" ),let bundel = NSBundle(path:path){
                self.currentLanguageBundle = bundel
                self._currentLanguage = newLanguage
            }else{//如果当前语言的lproj则加载base.lproj
                self.currentLanguageBundle =  NSBundle(path:NSBundle.mainBundle().pathForResource("Base", ofType: "lproj" )!)
                self._currentLanguage = "Base"
            }
            var def = NSUserDefaults.standardUserDefaults()
            def.setValue([self._currentLanguage!], forKey:kUserLanguage)
            def.synchronize()
            
            NSBundle.mainBundle().onLanguage()
        }
    }

    // 单列
    class func standardLanguager()->Languager{
        dispatch_once(&Static.onceToken) {
            Static.staticInstance = Languager()
        }
        return Static.staticInstance!
    }
    
    //初始化
    private func initLanguage(){
        self._currentLanguage = (NSUserDefaults.standardUserDefaults().objectForKey(kUserLanguage) as! Array<String>)[0]
        if let path = NSBundle.mainBundle().pathForResource(self._currentLanguage, ofType: "lproj" ),let bundel = NSBundle(path:path){
            self.currentLanguageBundle = bundel
        }else{ //如果当前语言的lproj则加载base.lproj
            self.currentLanguageBundle =  NSBundle(path:NSBundle.mainBundle().pathForResource("Base", ofType: "lproj" )!)
            self._currentLanguage = "Base"
        }
    }
    
    /**
    获取当前语言的storyboard
    */
    func storyboard(name:String)->UIStoryboard{
        return UIStoryboard(name: name, bundle: self.currentLanguageBundle)
    }
    
    /**
    获取当前语言的nib
    */
    func nib(name:String)->UINib{
        return UINib(nibName: name, bundle: self.currentLanguageBundle)
    }
    
    /**
    获取当前语言的string
    */
    func string(key:String)->String{
        if let str = self.currentLanguageBundle?.localizedStringForKey(key, value: nil, table: nil){
            return str
        }
        return key
    }
    
    /**
    获取当前语言的image
    */
    func image(name:String)->UIImage?{
        var path = self.currentLanguageBundle?.pathForResource(name+"@2x", ofType: "png")
        return UIImage(contentsOfFile: path!)
    }
}

func localized(key:String)->String{
    return Languager.standardLanguager().string(key)
}

func localizedImage(key:String)->UIImage?{
    return Languager.standardLanguager().image(key)
}



