//
//  NSBundle+Lanauage.swift
//  LocalDemo
//
//  Created by gongkai on 15/6/4.
//  Copyright (c) 2015年 gongkai. All rights reserved.
//

import Foundation

/**
*  当调用onLanguage后替换掉mainBundle为当前语言的bundle
*/
private  let _bundle:UnsafePointer<Void> =  unsafeBitCast(0,UnsafePointer<Void>.self)
class BundleEx: NSBundle {
    override func localizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        if let bundle = languageBundle() {
            return bundle.localizedStringForKey(key, value: value, table: tableName)
        }else{
            return super.localizedStringForKey(key, value: value, table: tableName)
        }
    }
}

extension NSBundle{
    private struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    func onLanguage(){
        //替换NSBundle.mainBundle()为自定义的BundleEx
        dispatch_once(&Static.onceToken) {
            object_setClass(NSBundle.mainBundle(), BundleEx.self)
        }
    }
    
    //当前语言的bundle
    func languageBundle()->NSBundle?{
        return Languager.standardLanguager().currentLanguageBundle
    }
}