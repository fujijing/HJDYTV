//
//  HJPageContentView.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/23.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

protocol pageContentDelegate: class {
    func pageContentViewScrollDetial(_ contenView: HJPageContentView, progress: CGFloat, currentIndex: Int, targetIndex: Int)
}

private let contentCellID = "ContentCellID"

class HJPageContentView: UIView {
    
    fileprivate var childVCs: [UIViewController] = []
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    weak var delegate: pageContentDelegate?
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = (self?.bounds.size)!
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
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
    fileprivate func setUIElements() {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[(indexPath as NSIndexPath).item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension HJPageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0
        var currentIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
//        print("\(scrollView.contentOffset.x)")
//        print("=========\(startOffsetX)")
        
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
        
        delegate?.pageContentViewScrollDetial(self, progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}

extension HJPageContentView{
    func  contentViewChange(_ currentIndex: Int){
        
        isForbidScrollDelegate = true
        
        let offsetX = collectionView.frame.width * CGFloat(currentIndex)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
