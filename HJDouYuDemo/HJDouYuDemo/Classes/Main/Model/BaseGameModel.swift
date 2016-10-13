//
//  BaseGameModel.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/13.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init(){
    
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
}
