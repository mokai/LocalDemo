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
    private static var __once: () = {
            Static.staticInstance = Languager()
        }()
    fileprivate struct Static {
        static var onceToken : Int = 0
        static var staticInstance : Languager? = nil
    }
    fileprivate var _currentLanguage:String?
    
    override init() {
        super.init()
        self.initLanguages()
    }
    
    //当前语言Bundle
    internal var currentLanguageBundle:Bundle?
    
    // 当前语言获取与切换
    var currentLanguage:String {
        get{
            if(self._currentLanguage==nil){
                self._currentLanguage = (UserDefaults.standard.value(forKey: kUserLanguage) as! Array<String>)[0]
            }
            return self._currentLanguage!
        }
        set(newLanguage){
            if(self._currentLanguage == newLanguage){
                return
            }
            if let path = Bundle.main.path(forResource: newLanguage, ofType: "lproj" ),let bundel = Bundle(path:path){
                self.currentLanguageBundle = bundel
                self._currentLanguage = newLanguage
            }else{
                //如果不支持当前语言则加载info中Localization native development region中的值的lporj
                let defaultLanguage = (Bundle.main.infoDictionary! as NSDictionary).value(forKey: kCFBundleDevelopmentRegionKey as String) as! String
                self.currentLanguageBundle =  Bundle(path:Bundle.main.path(forResource: defaultLanguage, ofType: "lproj" )!)
                self._currentLanguage = defaultLanguage
            }
            let def = UserDefaults.standard
            def.setValue([self._currentLanguage!], forKey:kUserLanguage)
            def.synchronize()
            
            Bundle.main.onLanguage()
        }
    }
    
    // 单列
    class func standardLanguager()->Languager{
        _ = Languager.__once
        return Static.staticInstance!
    }
    
    //初始化
    func initLanguages(){
        let language = (UserDefaults.standard.object(forKey: kUserLanguage) as! Array<String>)[0]
        if let path = Bundle.main.path(forResource: language, ofType: "lproj" ),let bundel = Bundle(path:path) {
            self.currentLanguageBundle = bundel
            self._currentLanguage = language
        } else {
            //如果不支持当前语言则加载info中Localization native development region中的值的lporj,设置为当前语言
            self.currentLanguage = (Bundle.main.infoDictionary! as NSDictionary).value(forKey: kCFBundleDevelopmentRegionKey as String) as! String
            print("Languager:\(language)不支持，切换成默认语言\(self._currentLanguage!)")
        }
    }
    
    /**
     获取当前语言的storyboard
     */
    func storyboard(_ name:String)->UIStoryboard{
        return UIStoryboard(name: name, bundle: self.currentLanguageBundle)
    }
    
    /**
     获取当前语言的nib
     */
    func nib(_ name:String)->UINib{
        return UINib(nibName: name, bundle: self.currentLanguageBundle)
    }
    
    /**
     获取当前语言的string
     */
    func string(_ key:String) -> String {
        if let str = self.currentLanguageBundle?.localizedString(forKey: key, value: nil, table: nil){
            return str
        }
        return key
    }
    
    /**
     获取当前语言的image,注意，此处加载的是2x图片
     */
    func image(_ name:String) -> UIImage? {
        let path = self.currentLanguageBundle?.path(forResource: name + "@2x", ofType: "png")
        return UIImage(contentsOfFile: path!)
    }
}

func localized(_ key:String) -> String {
    return Languager.standardLanguager().string(key)
}

func localizedImage(_ key:String)->UIImage? {
    return Languager.standardLanguager().image(key)
}



