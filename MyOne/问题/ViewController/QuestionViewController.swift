//
//  ArticleViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Life circle and property
    var questionModels: QuestionModel = QuestionModel()
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
        view.addSubview(questionCollectionView)
        view.addSubview(juhuaActivity)
        view.addSubview(networkWarningLabel)
    }
    
    // MARK: Observer and network
    func addObservers() {
        questionModels.addObserver(self, forKeyPath: questionModels.resultKeyPath(), options: .New, context: nil)
    }
    
    func startNetwork() {
        juhuaActivity.startAnimating()
        questionModels.startNetwork(day)
        day -= 1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object!.isKindOfClass(QuestionModel) && keyPath! == questionModels.resultKeyPath() {
            if change!["new"]! as! String == "Success" {
                questionCollectionView.reloadData()
                self.networkWarningLabel.hidden = true
            } else {
                let _: UIAlertController = UIAlertController.networkErrorAlert(self)
                self.networkWarningLabel.hidden = false
                self.juhuaActivity.stopAnimating()
            }
        }
    }
    
    // MARK: Delegate and datasource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questionModels.questionDatas.count == 0 ? juhuaActivity.startAnimating() : juhuaActivity.stopAnimating()
        return questionModels.questionDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: QuestionCell = collectionView.dequeueReusableCellWithReuseIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionCell
        
        cell.setModel(questionModels.questionDatas[indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == questionModels.questionDatas.count - 1 {
            startNetwork()
        }
    }
    
    // MARK: Lazy load
    private lazy var questionCollectionView: UICollectionView = {
        let view: UICollectionView = UICollectionView.standardCollectionView("QuestionCell")
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var juhuaActivity: UIActivityIndicatorView = UIActivityIndicatorView.juhuaActivityView(self.view)
    
    private lazy var networkWarningLabel: UILabel = UILabel.networkErrorWarning(self.view)
    
}
