//
//  AnchorGroup.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/13.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

    var room_list: [[String: NSObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    var icon_name: String = "home_header_normal"
    //定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
}
