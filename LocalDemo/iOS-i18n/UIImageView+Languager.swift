//
//  UIImageView+Language.swift
//  icar
//
//  Created by gongkai on 15/6/3.
//  Copyright (c) 2015年 anytracking. All rights reserved.
//

import UIKit

/**
*  解决IB中image不lcoalization的bug
*/
@IBDesignable
extension UIImageView {
    
    @IBInspectable
    var local:String {
        get {
            return ""
        }
        set(newlocal) {
            self.image = localizedImage(newlocal)
        }
    }
}
