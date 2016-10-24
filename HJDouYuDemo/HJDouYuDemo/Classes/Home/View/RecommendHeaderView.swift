//
//  RecommendHeaderView.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/9.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class RecommendHeaderView: UICollectionReusableView {
    
    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group: AnchorGroup? {
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}

extension RecommendHeaderView{
    class func recommendHeaderView() -> RecommendHeaderView {
    return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! RecommendHeaderView
    }
}
