//
//  ArticleViewCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/28.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var authorBriefLabel: UILabel!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var briefHeight: NSLayoutConstraint!
    @IBOutlet weak var containHeight: NSLayoutConstraint!
    
    private var model: ArticleData?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomScrollView.alpha = 0
        addSubview(juhua)
        juhua.center = CGPoint(x: ScreenWidth * 0.5, y: ScreenHeightWithoutNavAndTab * 0.5)
    }
    
    func setModel(model: ArticleData) {
        self.model = model
        performSelector(#selector(loadUserView), withObject: nil, afterDelay: 0.1)
    }
    
    @objc private func loadUserView() {
        timeLabel.text = model!.strContMarketTime
        titleLabel.text = model!.strContTitle
        authorLabel.text = model!.strContAuthor
        contentLabel.text = model!.strContent
        authorTitleLabel.text = model!.strContAuthor
        authorBriefLabel.text = model!.sAuth
        
        contentHeight.constant = model!.contentHeight
        briefHeight.constant = model!.briefHeight
        containHeight.constant = model!.contentHeight + model!.briefHeight + ScreenHeightWithoutNavAndTab * 0.5
        
        UIView.animateWithDuration(0.3, animations: {
            self.bottomScrollView.alpha = 1
            self.juhua.alpha = 0
        }) { (_) in
            self.juhua.stopAnimating()
        }
    }
    
    private lazy var juhua: UIActivityIndicatorView = UIActivityIndicatorView.juhuaActivityView(self)

}
