//
//  SomethingViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class SomethingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var somethingModels: SomethingDataManager = SomethingDataManager()
    var day: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initWithUserInterface()
        addObservers()
        startNetwork()
    }
    
    deinit {
        somethingModels.removeObserver(self, forKeyPath: somethingModels.resultKeyPath())
    }
    
    func initWithUserInterface() {
        view.addSubview(somethingCollectionView)
        view.addSubview(juhuaActivity)
    }
    
    func addObservers() {
        somethingModels.addObserver(self, forKeyPath: somethingModels.resultKeyPath(), options: .New, context: nil)
    }
    
    func startNetwork() {
        somethingModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(SomethingDataManager) && keyPath == somethingModels.resultKeyPath() {
            if change!["new"]! as! String == "Success" {
                somethingCollectionView.reloadData()
            } else {
                print("链接失败，请检查网络")
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        somethingModels.somethingModels.count == 0 ? self.juhuaActivity.startAnimating() : self.juhuaActivity.stopAnimating()
        return somethingModels.somethingModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SomethingCell = collectionView.dequeueReusableCellWithReuseIdentifier("SomethingCell", forIndexPath: indexPath) as! SomethingCell
        
        let model: SomethingModel = somethingModels.somethingModels[indexPath.item]
        
        cell.setModel(model)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == somethingModels.somethingModels.count - 1 {
            startNetwork()
        }
    }
    
    private lazy var somethingFlowLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeightWithoutNavAndTab)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        return layout
    }()
    
    private lazy var somethingCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView(frame: ScreenRectWithoutNavBar, collectionViewLayout: self.somethingFlowLayout)
        view.backgroundColor = UIColor.whiteColor()
        view.showsHorizontalScrollIndicator = false
        view.registerNib(UINib(nibName: "SomethingCell", bundle: nil), forCellWithReuseIdentifier: "SomethingCell")
        view.pagingEnabled = true
        view.bounces = false
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView().juhuaActivityView(self.view)
    
}
