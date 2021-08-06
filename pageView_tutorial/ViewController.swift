//
//  ViewController.swift
//  pageView_tutorial
//
//  Created by 김송현 on 2021/03/22.
//

import UIKit
import FSPagerView

class ViewController: UIViewController,  FSPagerViewDataSource, FSPagerViewDelegate {

    fileprivate let imageNames = ["1.png", "2.png" , "3.png", "4.png"]
    
    @IBOutlet var leftBtn: UIButton!
    @IBOutlet var rightBtn: UIButton!
    
    @IBOutlet var myPagerView: FSPagerView!{
        didSet{
            //페이져 뷰에 쏄을 등록한다
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //아이템 사이즈 조절(자동)
            self.myPagerView.itemSize = FSPagerView.automaticSize
            //무한 스크롤
            self.myPagerView.isInfinite = true
            //자동 스크롤
            //self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    @IBOutlet var myPageControl: FSPageControl!{
        didSet{
            self.myPageControl.numberOfPages = self.imageNames.count
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 16
            self.myPageControl.interitemSpacing = 16
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height/2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height/2
    }

    //MARK: - FSPagerView Datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    //각 셀에대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill // 사진비율에 맞춰 이미지 제공
        
//        cell.textLabel?.text = ...
        return cell
    }
    
    //MARK: - IBAction
    @IBAction func leftBtnClicked(_ sender: UIButton) {
        self.myPageControl.currentPage = self.myPageControl.currentPage - 1
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
        
    }
    @IBAction func rightBtnClicked(_ sender: UIButton) {
        if(self.myPageControl.currentPage == self.imageNames.count - 1){
            self.myPageControl.currentPage = 0
        }else{
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
        }
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
        
    }
    
    //MARK: - FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    // 이미지 클릭시 하이라이트 효과 비활성화
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

