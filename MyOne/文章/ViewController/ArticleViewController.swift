//
//  ArticleViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Life circle and property
    var articleModels: ArticleModel = ArticleModel()
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
        view.addSubview(networkWarningLabel)
    }
    
    // MARK: Observer and network
    func addObservers() {
        articleModels.addObserver(self, forKeyPath: articleModels.resultKeyPath(), options: .New, context: nil)
    }
    
    func startNetwork() {
        juhuaActivity.startAnimating()
        articleModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(ArticleModel) && keyPath! == articleModels.resultKeyPath() {
            dispatch_async(dispatch_get_main_queue(), { 
                if change!["new"]! as! String == "Success" {
                    self.articleCollectionView.reloadData()
                    self.networkWarningLabel.hidden = true
                } else {
                    let _: UIAlertController = UIAlertController.networkErrorAlert(self)
                    self.networkWarningLabel.hidden = false
                    self.juhuaActivity.stopAnimating()
                }
            })
        }
    }
    
    // MARK: Delegate and datasource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articleModels.articleDatas.count == 0 ? juhuaActivity.startAnimating() : juhuaActivity.stopAnimating()
        return articleModels.articleDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ArticleViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ArticleViewCell", forIndexPath: indexPath) as! ArticleViewCell
        
        cell.setModel(articleModels.articleDatas[indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == articleModels.articleDatas.count - 1 {
            startNetwork()
        }
    }
    
    // MARK: Lazy load
    private lazy var articleCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView.standardCollectionView("ArticleViewCell")
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView.juhuaActivityView(self.view)
    
    private lazy var networkWarningLabel: UILabel = UILabel.networkErrorWarning(self.view)

}
