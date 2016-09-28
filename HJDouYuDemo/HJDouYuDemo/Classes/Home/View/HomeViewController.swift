//
//  HomeViewController.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/19.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

private let HJTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView: HJPageTitleView = {
        let titleFrame = CGRect(x: 0, y: HJStatusBarH + HJNavigationBarH, width: HJScreenW, height: HJTitleViewH)
        let titleItems = ["推荐", "游戏", "娱乐", "趣玩"]
        let displayTitlecount = 0
        let titleView = HJPageTitleView(frame: titleFrame, titles: titleItems, displayTitleCount: displayTitlecount)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView: HJPageContentView = {
        let contentH = HJScreenH - HJStatusBarH - HJNavigationBarH - HJTitleViewH
        let contentFrame = CGRect(x: 0, y: HJStatusBarH + HJNavigationBarH + HJTitleViewH, width: HJScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
            childVCs.append(vc)
        }
        
        let pageContentView = HJPageContentView(frame: contentFrame, childVCs:childVCs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup UI elements
        setUIElements()
    }
    
}


//pragma mark --UI Elements
extension HomeViewController{
    
    fileprivate func setUIElements(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        //1、setup navigationBar
        setNavigationBar()
        
        //2、 add TitleView
        view.addSubview(pageTitleView)
        
        //3、 add pageContentView
        view.addSubview(pageContentView)
    }
    
    fileprivate func setNavigationBar(){
        
        // the left button
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        // the right buttons
        let size = CGSize(width: 40, height: 40)
        let history = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
        let qrcode = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [qrcode, searchItem, history];
        
    }
}

extension HomeViewController: pageContentDelegate {
    func pageContentViewScrollDetial(_ contenView: HJPageContentView, progress: CGFloat, currentIndex: Int, targetIndex: Int) {
        //set titleView 
        pageTitleView.changeTitleViewWithProgress(progress, sourceIndex: currentIndex, targetIndex: targetIndex)
    }
}

extension HomeViewController: HJPageTitleViewDelegate {
    func pageTitleViewChange(_ titleView: HJPageTitleView, selectedIndex: Int) {
        pageContentView.contentViewChange(selectedIndex)
    }
}
