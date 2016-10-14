
//
//  BaseViewModel.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/13.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    lazy var anchorGroup: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func  loadAnchorData(URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters){
            (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            
            for dict in dataArray{
                self.anchorGroup.append(AnchorGroup(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
