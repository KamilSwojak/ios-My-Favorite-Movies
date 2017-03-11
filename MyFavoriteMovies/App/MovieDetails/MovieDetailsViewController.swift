//
//  MovieDetailsViewControllerV3ViewController.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 15/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
//import MBCircularProgressBar
import RxSwift
import TmdbApi

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var backdrop: TmdbImageView! /* not always visible - check if exists */
    @IBOutlet weak var poster: TmdbImageView!
    @IBOutlet weak var movieTitleLabel: UITextView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingView: MBCircularProgressBarView!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var featuredCrewTitleLabel: UILabel!
    @IBOutlet weak var featuredCrewCollection: UICollectionView!
    @IBOutlet weak var topBilledCastTitleLabel: UILabel!
    @IBOutlet weak var topBilledCastCollection: UICollectionView!

    @IBOutlet weak var userListsBarButton: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    @IBOutlet weak var bookmarkBarButton: UIBarButtonItem!
    @IBOutlet weak var rateBarButton: UIBarButtonItem!
    
    @IBOutlet weak var movieDataTitleLabel: UILabel!
    @IBOutlet weak var factsTitleLabel: UILabel!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var originalLanguageTitleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var runtimeTitleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var budgetTitleLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueTitleLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var homepageTitleLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var releaseInformationTitleLabel: UILabel!
    @IBOutlet weak var releaseInformationLabel: UILabel!
    
    @IBOutlet weak var genresTitleLabel: UILabel!
    @IBOutlet weak var genresTagListView: TagListView!
    @IBOutlet weak var keywordsTitleLabel: UILabel!
    @IBOutlet weak var keywordsTagListView: TagListView!
    
    var model: MovieDetailsViewModel!
    
    var movie: TmdbMovie!
    
    private let homepageLabelTapSubject = PublishSubject<Void>()
    
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        setImages()
        
        //react to taps on homepageLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.homepageViewTapped))
        homepageLabel.addGestureRecognizer(tap)
        
        let castManager = TopBilledCastManager(of: topBilledCastCollection, cellIdentifier: "TopBilledCastCell")
        { cast in
            self.topBilledCastCollection.reloadData()
        }
        
        let crewManager = FeaturedCrewManager(of: featuredCrewCollection, cellIdentifier: "FeaturedCrewCell")
        { crew in
            self.featuredCrewCollection.reloadData()
        }
        
        let selfOutput = MovieDetailsViewOutput(movie: movie,
                                                playTrailerTaps: playTrailerButton.tap,
                                                userListsTaps: userListsBarButton.tap,
                                                favoriteTaps: favoriteBarButton.tap,
                                                bookmarkTaps: bookmarkBarButton.tap,
                                                rateTaps: rateBarButton.tap,
                                                genreTap: genresTagListView.tap,
                                                keywordTap: keywordsTagListView.tap,
                                                homepageLinkTap: homepageLabelTapSubject.asObservable(),
                                                crewTap: crewManager.itemSelected.map { (indexPath: $0, crew: $1) },
                                                castTap: castManager.itemSelected.map { (indexPath: $0, cast: $1) })
        
        model = MovieDetailsViewModel(input: selfOutput)
        
        
        //MARK: ViewModel output
        guard let output = model.output else { return }
        
        let d1 = castManager.elements.bindElements(of: output.cast)
        let d2 = crewManager.elements.bindElements(of: output.crew)
        
        let d3 = output
            .genres
            .observeOn(MainScheduler.asyncInstance)
            .subscribe { (event) in
            guard let genres = event.element else { return }
            
            self.genresTagListView.removeAllTags()
            
            for genre in genres {
                if let name = genre.name {
                    self.genresTagListView.addTag(name)
                }
            }
        }
        
        let d4 = output
            .keywords
            .observeOn(MainScheduler.asyncInstance)
            .subscribe { (event) in
            guard let keywords = event.element else { return }
            
            self.keywordsTagListView.removeAllTags()
            
            for keyword in keywords {
                if let name = keyword.name {
                    self.keywordsTagListView.addTag(name)
                }
            }
        }
        
        let d5 = output.movie
            .observeOn(MainScheduler.asyncInstance)
            .subscribe { (event) in
                
                guard let movie = event.element else { return }
            
                self.movie = movie
                self.reloadData()
        }
        
        let d6 = output.event
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
            guard let event = event.element else { return }
            
            switch event {
                
                case .Trailer(let url): self.openUrl(url: url)
                
                case .AddToLists: print(".AddToLists")
                
                case .Favorite: print(".Favorite")
                
                case .Bookmark: print(".Bookmark")
                
                case .Rate: print(".Rate")
                
                case .SelectedTag(let tag): print(".SelectedTag:", tag)
                
                case .Open(let url): self.openUrl(url: url)
                
                case .SelectedCast(let movieCast): print(movieCast.name ?? "")
                
                case .SelectedCrew(let movieCrew): print(movieCrew.name ?? "")
            }
        }
        
        disposeBag.insert(d1, d2, d3, d4, d5, d6)
    }
    
    //MARK: Images
    func setImages() {
        if let backdrop = backdrop, let backdropPath = movie.backdrop_path {
            backdrop.setImage(.Backdrop(path: backdropPath, size: .w780))
        }
        
        if let posterPath = movie.poster_path {
            poster.setImage(.Poster(path: posterPath, size: .w500))
        }
    }
    
    //MARK: Reload Data
    func reloadData() {
        guard let movie = self.movie else { return }
        
        overviewLabel.text = movie.overview
        movieTitleLabel.text = movie.title
        
        if let voteAverage = movie.vote_average {
            ratingView.value = CGFloat(voteAverage) * 10.0
        }
        
        if let releaseDate = movie.release_date {
            yearLabel.text = releaseDate.substring(to: 4)
        }
        
        self.releaseInformationLabel.text = movie.status
        self.originalLanguageLabel.text = movie.original_lanugage
        
        if let runtime = movie.runtime {
            self.runtimeLabel.text = runtime.format(as: .HoursAndMinutes)
        }
        
        if let budget = movie.budget{
            self.budgetLabel.text = budget.format(as: .Currency)
        }
        
        if let revenue = movie.revenue{
            self.revenueLabel.text = revenue.format(as: .Currency)
        }
        
        self.homepageLabel.text = movie.homepage
        
        if let date = movie.release_date {
            self.releaseInformationLabel.text = date.format(as: .Date(format: .yyyy_MM_dd, style: .medium))
        }
    }
    
    func homepageViewTapped() {
        homepageLabelTapSubject.onNext(())
    }
}


//MARK: Featured Crew

class FeaturedCrewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
}

class FeaturedCrewManager: CollectionViewHelper<TmdbMovieCrew, FeaturedCrewCell> {
    
    
    override init(of collection: UICollectionView, cellIdentifier: String, dataChanges: ((_: [TmdbMovieCrew]) -> Void)? = nil) {
        super.init(of: collection, cellIdentifier: cellIdentifier, dataChanges: dataChanges)
        
        style = { cell, crew in
            cell.name.text = crew.name
            cell.job.text = crew.job
        }
    }
    
}

//MARK: Top Billed Cast

class TopBilledCastCell: UICollectionViewCell {
    
    @IBOutlet weak var picture: TmdbImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
}

class TopBilledCastManager: CollectionViewHelper<TmdbMovieCast, TopBilledCastCell> {
    
    override init(of collection: UICollectionView, cellIdentifier: String, dataChanges: ((_: [TmdbMovieCast]) -> Void)? = nil) {
        super.init(of: collection, cellIdentifier: cellIdentifier, dataChanges: dataChanges)
        
        style = { cell, person in
            
            cell.nameLabel.text = person.name

            cell.characterLabel.text = person.character
            
            if let profilePath = person.profile_path {
                cell.picture.setImage(.Profile(path: profilePath, size: .w132_h132_bestv2))
                
                cell.picture.layer.masksToBounds = true
                cell.picture.layer.cornerRadius = cell.picture.frame.width / 2
            }
            
        }
    
    }
}
