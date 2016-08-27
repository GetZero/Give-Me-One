//
//  HomeViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var homeModels: HomeDataManager = HomeDataManager()
    var day: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initWithUserInterface()
        addObservers()
        startNetwork()
    }
    
    deinit {
        homeModels.removeObserver(self, forKeyPath: self.homeModels.resultKeyPath())
    }
    
    func initWithUserInterface() {
        view.addSubview(self.homeCollectionView)
        view.addSubview(self.juhuaActivity)
    }
    
    func addObservers() {
        homeModels.addObserver(self, forKeyPath: homeModels.resultKeyPath(), options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    func startNetwork() {
        homeModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(HomeDataManager) && keyPath! == homeModels.resultKeyPath() {
            if change!["new"]! as! String == "Success" {
                homeCollectionView.reloadData()
            } else {
                print("链接失败，请检查网络")
            }
        }
    }
    
    // MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeModels.homeModels.count == 0 ? self.juhuaActivity.startAnimating() : self.juhuaActivity.stopAnimating()
        return homeModels.homeModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomeCell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath) as! HomeCell
        
        let model: HomeModel = self.homeModels.homeModels[indexPath.item]
        
        cell.setModel(model)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == homeModels.homeModels.count - 1 {
            startNetwork()
        }
    }
    
    private lazy var homeFlowLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeightWithoutNavBar)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        return layout
    }()
    
    private lazy var homeCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView(frame: ScreenRectWithoutNavBar, collectionViewLayout: self.homeFlowLayout)
        view.backgroundColor = UIColor.whiteColor()
        view.showsHorizontalScrollIndicator = false
        view.registerNib(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        view.pagingEnabled = true
        view.bounces = false
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView().juhuaActivityView(self.view)
    
}


