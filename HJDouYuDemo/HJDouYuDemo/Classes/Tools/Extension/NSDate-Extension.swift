//
//  NSDate-Extension.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/14.
//  Copyright © 2016年 HJing. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSinceNow)
        return "\(interval)"
    }
}
