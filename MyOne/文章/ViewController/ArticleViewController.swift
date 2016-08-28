//
//  ArticleViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var articleModels: ArticleDataManager = ArticleDataManager()
    var day: Int = 0
    var start: Double = 0
    var end: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initWithUserInterface()
        addObservers()
        
        startNetwork()
    }
    
    deinit {
        articleModels.removeObserver(self, forKeyPath: articleModels.resultKeyPath())
    }
    
    func initWithUserInterface() {
        view.addSubview(articleCollectionView)
        view.addSubview(juhuaActivity)
    }
    
    func addObservers() {
        articleModels.addObserver(self, forKeyPath: articleModels.resultKeyPath(), options: .New, context: nil)
    }
    
    func startNetwork() {
        articleModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(ArticleDataManager) && keyPath! == articleModels.resultKeyPath() {
            dispatch_async(dispatch_get_main_queue(), { 
                if change!["new"]! as! String == "Success" {
                    self.articleCollectionView.reloadData()
                } else {
                    print("链接失败，请检查网络")
                }
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articleModels.articleModels.count == 0 ? self.juhuaActivity.startAnimating() : self.juhuaActivity.stopAnimating()
        return articleModels.articleModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ArticleViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ArticleViewCell", forIndexPath: indexPath) as! ArticleViewCell
        let model: ArticleModel = articleModels.articleModels[indexPath.item]
        
        cell.setModel(model)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == articleModels.articleModels.count - 1 {
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
        view.registerNib(UINib(nibName: "ArticleViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleViewCell")
        view.pagingEnabled = true
        view.bounces = false
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView().juhuaActivityView(self.view)

}
