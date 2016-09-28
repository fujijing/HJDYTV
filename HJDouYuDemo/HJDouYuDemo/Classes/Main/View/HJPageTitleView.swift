//
//  HJPageTitleView.swift
//  HJDouYuDemo
//
//  Created by Revive on 16/9/23.
//  Copyright © 2016年 HJing. All rights reserved.
//

import UIKit

// pragma mark -- constant
private let HJScrollLineH: CGFloat = 2
private let HJNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let HJSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

protocol HJPageTitleViewDelegate: class {
    func pageTitleViewChange(_ titleView: HJPageTitleView, selectedIndex: Int)
}


class HJPageTitleView: UIView {
    
    fileprivate var currentIndex: Int = 0
    fileprivate var titles: [String]
    
    // parameter displayTitleCount means the number of title in the screen, not contain the hidden title
    fileprivate var displayTitleCount: Int = 0
    weak var delegate: HJPageTitleViewDelegate?
    
    // lazy initialization
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
    //custom init
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //setup UI elements
        setupUIElements()
    }
    
    //custom init
    init(frame: CGRect, titles: [String], displayTitleCount: Int) {
        self.titles = titles
        self.displayTitleCount = displayTitleCount
        super.init(frame: frame)
        
        //setup UI elements
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// pragma mark -- setup UI elements
extension HJPageTitleView{
    fileprivate func setupUIElements(){
        
        //1、add scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // if the title number is more than the displayTitileCount, should set the contentSize of the scrollView
        if displayTitleCount != 0 {
            scrollView.contentSize = CGSize(width: (frame.width / CGFloat(displayTitleCount) * CGFloat(titles.count)), height: frame.height - HJScrollLineH)
        }
        
        //2、 setup titles and add labels to the scrollView
        setTitleLabels()
        
        //3、 serup bottom line and scroll Line
        setupBottomLineAndScrollLine()
        
    }
    
    fileprivate func setTitleLabels() {
        
        let labelH: CGFloat = frame.height - HJScrollLineH
        let count = displayTitleCount == 0 ? titles.count : displayTitleCount
        let labelW: CGFloat = frame.width / CGFloat(count)
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(red: HJNormalColor.0 / 255.0, green: HJNormalColor.1 / 255.0, blue: HJNormalColor.2 / 255.0, alpha: 1.0)
            label.textAlignment = .center
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // add gesture to the label
            label.isUserInteractionEnabled = true
            let  gesture = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(gesture)
            
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        // add bottom line
        let bottomLine = UIView()
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        // add scrollLine
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(red: HJSelectColor.0 / 255.0, green: HJSelectColor.1 / 255.0, blue: HJSelectColor.2 / 255.0, alpha: 1.0)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - HJScrollLineH, width: firstLabel.frame.width, height: HJScrollLineH)
        
    }
}

extension HJPageTitleView{
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        if currentLabel.tag == currentIndex {
            return
        }
        
        // change the color of selected Label
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(red: HJNormalColor.0 / 255.0, green: HJNormalColor.1 / 255.0, blue: HJNormalColor.2 / 255.0, alpha: 1.0)
        currentLabel.textColor = UIColor(red: HJSelectColor.0 / 255.0, green: HJSelectColor.1 / 255.0, blue: HJSelectColor.2 / 255.0, alpha: 1.0)
        
        // store the current label tag
        currentIndex = currentLabel.tag
        
        // change the position of the scroll line
        let scrollLineX: CGFloat = CGFloat(currentIndex) * currentLabel.frame.width
        scrollLine.frame.origin.x = scrollLineX;
        
        delegate?.pageTitleViewChange(self, selectedIndex: currentIndex)
    }
}


extension HJPageTitleView{
    func changeTitleViewWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        
        let currentLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let distance = targetLabel.frame.origin.x - currentLabel.frame.origin.x 
        scrollLine.frame.origin.x = currentLabel.frame.origin.x + distance * progress
        if displayTitleCount != 0 {
            if targetIndex > (displayTitleCount - 1) {
                scrollView.setContentOffset(CGPoint(x: targetLabel.frame.size.width, y: 0), animated: false)
            }
            if scrollView.contentOffset.x > 0 && targetIndex < (displayTitleCount - 1){
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
        
        // the scope of the color change
        let  colorScope = (HJSelectColor.0 - HJNormalColor.0, HJSelectColor.1 - HJNormalColor.1, HJSelectColor.2 - HJNormalColor.2)
        
        currentLabel.textColor = UIColor(red: (HJSelectColor.0  - colorScope.0 * progress ) / 255.0, green: (HJSelectColor.1 - colorScope.1 * progress) / 255.0, blue: ( HJSelectColor.2 - colorScope.2 * progress) / 255.0, alpha: 1.0)
        targetLabel.textColor = UIColor(red: (HJNormalColor.0  + colorScope.0 * progress ) / 255.0, green: (HJNormalColor.1  + colorScope.1 * progress ) / 255.0, blue: (HJNormalColor.2  + colorScope.2 * progress ) / 255.0, alpha: 1.0)
        
        currentIndex = targetIndex
    }
}






