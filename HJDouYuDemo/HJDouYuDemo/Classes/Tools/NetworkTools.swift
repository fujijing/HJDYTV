//
//  NetworkTools.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/13.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result : Any) -> ()){
        
        //get the request type
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON{
            (response) in
            
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            
            finishedCallback(result)
        }
        
    }
}
