//
//  AnchorModel.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/13.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    var room_id: Int = 0
    var vertical_src: String = ""
    // 0:computer 1:phone
    var isVertical: Int = 0
    var room_name: String = ""
    var nickname: String = ""
    var online: Int = 0
    var anchor_city: String = ""
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {}
}
