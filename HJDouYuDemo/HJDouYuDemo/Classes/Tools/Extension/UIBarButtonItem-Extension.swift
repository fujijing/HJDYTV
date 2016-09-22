//
//  UIBarButtonItem-Extension.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/22.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    //便利构造函数
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSizeZero) {
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: .Normal)
        if highImageName != "" {
            button.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        if size == CGSizeZero {
            button.sizeToFit()
        }else{
            button.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        self.init(customView: button)
        
    }
}