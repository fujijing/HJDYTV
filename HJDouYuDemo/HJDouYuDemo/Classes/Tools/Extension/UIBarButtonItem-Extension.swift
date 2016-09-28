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
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: UIControlState())
        if highImageName != "" {
            button.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            button.sizeToFit()
        }else{
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: button)
        
    }
}
