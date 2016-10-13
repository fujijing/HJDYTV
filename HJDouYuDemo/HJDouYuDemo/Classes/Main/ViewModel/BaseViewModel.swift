
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
        NetworkTools.requestData(MethodType, URLString: <#T##String#>, parameters: <#T##[String : Any]?#>, finishedCallBack: <#T##(Any) -> ()#>)
    }
}
