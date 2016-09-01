//
//  SomethingViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class SomethingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Life circle and property
    var somethingModel: SomethingModel = SomethingModel()
    var day: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initWithUserInterface()
        addObservers()
        startNetwork()
    }
    
    deinit {
        somethingModel.removeObserver(self, forKeyPath: somethingModel.resultKeyPath())
    }
    
    func initWithUserInterface() {
        view.addSubview(somethingCollectionView)
        view.addSubview(juhuaActivity)
        view.addSubview(networkWarningLabel)
    }
    
    // MARK: Observer and network
    func addObservers() {
        somethingModel.addObserver(self, forKeyPath: somethingModel.resultKeyPath(), options: .New, context: nil)
    }
    
    func startNetwork() {
        juhuaActivity.startAnimating()
        somethingModel.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(SomethingModel) && keyPath == somethingModel.resultKeyPath() {
            if change!["new"]! as! String == "Success" {
                somethingCollectionView.reloadData()
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
        somethingModel.somethingDatas.count == 0 ? juhuaActivity.startAnimating() : juhuaActivity.stopAnimating()
        return somethingModel.somethingDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SomethingCell = collectionView.dequeueReusableCellWithReuseIdentifier("SomethingCell", forIndexPath: indexPath) as! SomethingCell
        
        cell.setModel(somethingModel.somethingDatas[indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == somethingModel.somethingDatas.count - 1 {
            startNetwork()
        }
    }
    
    // MARK: Lazy load
    private lazy var somethingCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView.standardCollectionView("SomethingCell")
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView.juhuaActivityView(self.view)
    
    private lazy var networkWarningLabel: UILabel = UILabel.networkErrorWarning(self.view)
    
}
