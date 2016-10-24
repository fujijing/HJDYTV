//
//  RecommendViewController.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/27.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class RecommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecommendViewController{
    override func loadData() {
        baseVM = recommendVM
        
        recommendVM.requestData {
            self.collectionView.reloadData()
            
//            var groups = self.recommendVM.anchorGroup
            
            
        }
    }
}

