//
//  UITextView+Language.swift
//  icar
//
//  Created by gongkai on 15/6/2.
//  Copyright (c) 2015年 anytracking. All rights reserved.
//

import UIKit

/**
*  解决IB中uitextview不lcoalization的bug
*/
@IBDesignable
extension UITextView {
    
    @IBInspectable
    var local:Bool {
        get{
            return true
        }
        set(newlocal) {
            self.text = localized(self.text)
        }
    }
}