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
extension UIImageView{
    var locale:String{
        get{
            return ""
        }
        set(newlocale){
            self.image = localizedImage(newlocale)
        }
    }
}
