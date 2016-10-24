//
//  CollectionNormalCell.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/10/10.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor: AnchorModel?{

        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }

}
