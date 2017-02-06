//
//  MovieDataTableViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 02/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class MovieDataTableViewCell: UITableViewCell  {

    @IBOutlet weak var factsTitle: UILabel!
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var originalLanguageTitle: UILabel!
    @IBOutlet weak var originalLanguage: UILabel!
    @IBOutlet weak var runtimeTitle: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var budgetTitle: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var revenueTitle: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var homepageTitle: UILabel!
    @IBOutlet weak var homepage: UITextView!
    @IBOutlet weak var releaseInformationTitle: UILabel!
    @IBOutlet weak var releaseInformation: UILabel!

    @IBOutlet weak var genresTitle: UILabel!
    @IBOutlet weak var keywordsTitle: UILabel!
    @IBOutlet weak var genresView: TagListView!
    @IBOutlet weak var keywordsView: TagListView!
    
    var genres = ReactiveList<String>()
    var keywords = ReactiveList<String>()
    
    var requestedHeight: CGFloat {
        return 475
    }
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genresView.textFont = UIFont.systemFont(ofSize: 13.0)
        genresView.paddingX = 4.0
        genresView.paddingY = 4.0
        genresView.alignment = .left
        genresView.marginX = 4
        genresView.marginY = 4
        
        keywordsView.textFont = UIFont.systemFont(ofSize: 13.0)
        keywordsView.paddingX = 4.0
        keywordsView.paddingY = 4.0
        keywordsView.alignment = .left
        keywordsView.marginX = 4
        keywordsView.marginY = 4
        
        let d1 = genres
            .asObservable
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
            guard let genres = event.element else { return }
            
            self.genresView.removeAllTags()
            genres.forEach { self.genresView.addTag($0) }
        }
        
        let d2 = keywords
            .asObservable
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
            guard let keywords = event.element else { return }
            
            self.keywordsView.removeAllTags()
            keywords.forEach { self.keywordsView.addTag($0) }
        }
        
        disposeBag.insert(d1)
        disposeBag.insert(d2)
    }
    
    //MARK: Style
    var itemTitleTextColor: UIColor!{
        didSet{
            factsTitle.textColor = itemTitleTextColor
            statusTitle.textColor = itemTitleTextColor
            originalLanguageTitle.textColor = itemTitleTextColor
            runtimeTitle.textColor = itemTitleTextColor
            budgetTitle.textColor = itemTitleTextColor
            revenueTitle.textColor = itemTitleTextColor
            homepageTitle.textColor = itemTitleTextColor
            releaseInformationTitle.textColor = itemTitleTextColor
            genresTitle.textColor = itemTitleTextColor
            keywordsTitle.textColor = itemTitleTextColor
        }
    }
    var itemTextColor: UIColor!{
        didSet{
            status.textColor = itemTextColor
            originalLanguage.textColor = itemTextColor
            runtime.textColor = itemTextColor
            budget.textColor = itemTextColor
            revenue.textColor = itemTextColor
            homepage.textColor = itemTextColor
            releaseInformation.textColor = itemTextColor
        }
    }
    
    var itemBackgroundColor: UIColor?{
        didSet{
            statusTitle.backgroundColor = itemBackgroundColor
            status.backgroundColor = itemBackgroundColor
            originalLanguageTitle.backgroundColor = itemBackgroundColor
            originalLanguage.backgroundColor = itemBackgroundColor
            runtime.backgroundColor = itemBackgroundColor
            runtimeTitle.backgroundColor = itemBackgroundColor
            budget.backgroundColor = itemBackgroundColor
            budgetTitle.backgroundColor = itemBackgroundColor
            revenue.backgroundColor = itemBackgroundColor
            revenueTitle.backgroundColor = itemBackgroundColor
            homepage.backgroundColor = itemBackgroundColor
            homepageTitle.backgroundColor = itemBackgroundColor
            releaseInformation.backgroundColor = itemBackgroundColor
            releaseInformationTitle.backgroundColor = itemBackgroundColor
            genresTitle.backgroundColor = itemBackgroundColor
            keywordsTitle.backgroundColor = itemBackgroundColor
        }
    }
}

