//
//  MainViewController.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/19.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Mine")
    }
    
    private func addChildVC(storyName: String){
        
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
        
    }
}
