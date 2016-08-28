//
//  ArticleViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var questionModels: QuestionDataManager = QuestionDataManager()
    var day: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initWithUserInterface()
        addObservers()
        startNetwork()
    }
    
    deinit {
        questionModels.removeObserver(self, forKeyPath: questionModels.resultKeyPath())
    }
    
    func initWithUserInterface() {
        view.addSubview(articleCollectionView)
        view.addSubview(juhuaActivity)
    }
    
    func addObservers() {
        questionModels.addObserver(self, forKeyPath: questionModels.resultKeyPath(), options: .New, context: nil)
    }
    
    func startNetwork() {
        questionModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(QuestionDataManager) && keyPath! == questionModels.resultKeyPath() {
            if change!["new"]! as! String == "Success" {
                articleCollectionView.reloadData()
            } else {
                print("链接失败，请检查网络")
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questionModels.questionModels.count == 0 ? self.juhuaActivity.startAnimating() : self.juhuaActivity.stopAnimating()
        return questionModels.questionModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: QuestionCell = collectionView.dequeueReusableCellWithReuseIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionCell
        
        let model: QuestionModel = questionModels.questionModels[indexPath.item]
        
        cell.setModel(model)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == questionModels.questionModels.count - 1 {
            startNetwork()
        }
    }
    
    private lazy var articleFlowLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeightWithoutNavAndTab)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        return layout
    }()
    
    private lazy var articleCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView(frame: ScreenRectWithoutNavBar, collectionViewLayout: self.articleFlowLayout)
        view.backgroundColor = UIColor.whiteColor()
        view.showsHorizontalScrollIndicator = false
        view.registerNib(UINib(nibName: "QuestionCell", bundle: nil), forCellWithReuseIdentifier: "QuestionCell")
        view.pagingEnabled = true
        view.bounces = false
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView().juhuaActivityView(self.view)
    
}
