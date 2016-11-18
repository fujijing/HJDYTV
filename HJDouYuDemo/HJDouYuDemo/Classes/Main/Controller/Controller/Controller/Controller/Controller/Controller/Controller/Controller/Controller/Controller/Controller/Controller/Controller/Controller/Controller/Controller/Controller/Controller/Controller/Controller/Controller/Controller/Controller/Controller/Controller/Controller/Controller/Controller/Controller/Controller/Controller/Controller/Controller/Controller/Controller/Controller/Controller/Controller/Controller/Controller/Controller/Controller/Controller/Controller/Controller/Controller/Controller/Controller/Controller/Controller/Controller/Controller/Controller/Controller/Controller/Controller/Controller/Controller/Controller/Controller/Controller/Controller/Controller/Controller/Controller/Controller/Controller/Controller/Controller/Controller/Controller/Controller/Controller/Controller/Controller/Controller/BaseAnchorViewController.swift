//
//  BaseAnchorViewController.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/21.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

private let HJItemMargin: CGFloat = 10
private let HJItemW: CGFloat  = (HJScreenW - 3 * HJItemMargin) / 2
private let HJNormalItemH: CGFloat = HJItemW * 3 / 4
private let HJPrettyItemH: CGFloat = HJItemW * 4 / 3
private let HJHeaderViewH: CGFloat = 50

private let HJHeaderViewID = "HJHeaderViewID"
private let HJNormalCellID = "HJNormalCellID"

class BaseAnchorViewController: UIViewController {
    
    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: HJItemW, height: 182)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = HJItemMargin
        layout.headerReferenceSize = CGSize(width: HJScreenW, height: HJHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: HJItemMargin, bottom: 0, right: HJItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        collectionView.register(UINib(nibName: "RecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HJHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier:HJNormalCellID)
        //        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }

}

extension BaseAnchorViewController{
    func setupUI(){
        view.addSubview(collectionView)
    }
}

extension BaseAnchorViewController{
    func loadData(){
    
    }
}


extension BaseAnchorViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return baseVM.anchorGroup[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:HJNormalCellID , for: indexPath) as!CollectionNormalCell
        cell.anchor = baseVM.anchorGroup[indexPath.section].anchors[indexPath.item]
        return cell;
    }
    
    // set the collectionHeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HJHeaderViewID, for: indexPath) as! RecommendHeaderView
        headerView.group = baseVM.anchorGroup[indexPath.section]
        return headerView
    }
}

