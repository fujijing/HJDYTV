//
//  RecommendViewModel.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/13.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyDataGroup: AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    
    //request the recommend info
    func requestData(_ finishCallback : @escaping () -> ()) {
        
        let parameters = ["limit": "4", "offset": "0", "time": Date.getCurrentTime()]
        let dGroup = DispatchGroup()
        
        //请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]){
            (result) in
            guard let resultDict = result as? [String: NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            
            self.bigDataGroup.tag_name = "最热"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        //请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters){
            (result) in
            guard let resultDict = result as? [String: NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        //请求其他剩余的数据
        dGroup.enter()
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        //得到所有数据之后对数据进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroup.insert(self.prettyDataGroup, at: 0)
            self.anchorGroup.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
    }
}
