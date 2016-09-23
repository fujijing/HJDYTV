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
    
    private lazy var pageTitleView: HJPageTitleView = {
        let titleFrame = CGRect(x: 0, y: HJStatusBarH + HJNavigationBarH, width: HJScreenW, height: HJTitleViewH)
        let titleItems = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = HJPageTitleView(frame: titleFrame, titles: titleItems)
        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup UI elements
        setUIElements()
    }


}


//pragma mark --UI Elements
extension HomeViewController{
    
    private func setUIElements(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        //1、setup navigationBar
        setNavigationBar()
        
        //2、 add TitleView
        view.addSubview(pageTitleView)
    }
    
    private func setNavigationBar(){
        
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