//
//  HJPageContentView.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/23.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

private let contentCellID = "ContentCellID"

class HJPageContentView: UIView {
    
    private var childVCs: [UIViewController] = []
    private weak var parentViewController: UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate: Bool = false
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        layout.itemSize = (self?.bounds.size)!
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    //custom init
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        super.init(frame: frame)
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        // setup UI Elements
        setUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HJPageContentView{
    private func setUIElements() {
        //1、add all child controller to parent controller
        for childVC in childVCs {
            self.parentViewController?.addChildViewController(childVC)
        }
        
        //2、add collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


extension HJPageContentView: UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return childVCs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier(contentCellID, forIndexPath: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension HJPageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0
        var currentIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {
            // scroll left
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            currentIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = currentIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            //完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = currentIndex
            }
        }else{
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            currentIndex = targetIndex + 1
            if currentIndex >= childVCs.count {
                currentIndex = childVCs.count - 1
            }
        }
        
    }
}