//
//  HomeViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Life circle and property
    var homeModels: HomeModel = HomeModel()
    var day: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initWithUserInterface()
        addObservers()
        startNetwork()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        TopWindow.showTopWindow()
    }
    
    deinit {
        homeModels.removeObserver(self, forKeyPath: homeModels.resultKeyPath())
    }
    
    func initWithUserInterface() {
        view.addSubview(homeCollectionView)
        view.addSubview(juhuaActivity)
        view.addSubview(circleView)
        view.addSubview(networkWarningLabel)
        
        UIView.animateWithDuration(1, animations: { 
            self.circleView.transform = CGAffineTransformScale(self.circleView.transform, 0.0001, 0.0001)
            }) { (_) in
                self.circleView.removeFromSuperview()
        }
    }
    
    // MARK: Observer and network
    func addObservers() {
        homeModels.addObserver(self, forKeyPath: homeModels.resultKeyPath(), options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    func startNetwork() {
        juhuaActivity.startAnimating()
        homeModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(HomeModel) && keyPath! == homeModels.resultKeyPath() {
            if change!["new"]! as! String == "Success" {
                homeCollectionView.reloadData()
                networkWarningLabel.hidden = true
            } else {
                let _: UIAlertController = UIAlertController.networkErrorAlert(self)
                networkWarningLabel.hidden = false
                juhuaActivity.stopAnimating()
            }
        }
    }
    
    // MARK: Delegate and datasource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeModels.homeDatas.count == 0 ? juhuaActivity.startAnimating() : juhuaActivity.stopAnimating()
        return homeModels.homeDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomeCell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath) as! HomeCell
        
        cell.setModel(homeModels.homeDatas[indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == homeModels.homeDatas.count - 1 {
            startNetwork()
        }
    }
    
    // MARK: Lazy load
    private lazy var homeCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView.standardCollectionView("HomeCell")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView.juhuaActivityView(self.view)
    
    private lazy var circleView: UIView = UIView.circleView(self.view)
    
    private lazy var networkWarningLabel: UILabel = UILabel.networkErrorWarning(self.view)
    
}
