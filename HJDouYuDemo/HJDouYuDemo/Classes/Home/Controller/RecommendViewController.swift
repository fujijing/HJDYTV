//
//  RecommendViewController.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/27.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

private let HJItemMargin: CGFloat = 10
private let HJItemW: CGFloat  = (HJScreenW - 3 * HJItemMargin) / 2
private let HJNormalItemH: CGFloat = HJItemW * 3 / 4
private let HJPrettyItemH: CGFloat = HJItemW * 4 / 3
private let HJHeaderViewH: CGFloat = 50


class RecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: HJItemW, height: HJNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = HJItemMargin
        layout.headerReferenceSize = CGSize(width: HJScreenW, height: HJHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: HJItemMargin, bottom: 0, right: HJItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//        collectionView.dataSource = self
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
