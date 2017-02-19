//
//  MovieDetailsViewControllerV3ViewController.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 15/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import RxSwift
import SDWebImage

//still need to fix iphone 7 plus

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var backdrop: TmdbImageView! /* not always visible - check if exists */
    @IBOutlet weak var poster: TmdbImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: MBCircularProgressBarView!
    @IBOutlet weak var playTrailer: UIButton!
    @IBOutlet weak var overviewTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var featuredCrewTitle: UILabel!
    @IBOutlet weak var featuredCrewCollection: UICollectionView!
    @IBOutlet weak var topBilledCastTitle: UILabel!
    @IBOutlet weak var topBilledCastCollection: UICollectionView!
    
    var model: MovieDetailsViewModel!
    
    var movie: Movie!
    
//    let crewList = ReactiveList<(name: String, job: String)>()
//    let castList = ReactiveList<(name: String, character: String, profilePath: String?)>()
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = MovieDetailsViewModel(input: MovieDetailsViewOutput(movie: movie))
        
        let castManager = TopBilledCastManager()
        topBilledCastCollection.delegate = castManager
        topBilledCastCollection.dataSource = castManager
        
        castManager.callback = {
            mainAsync {
                self.topBilledCastCollection.reloadData()
            }
        }
        
        let crewManager = FeaturedCrewManager()
        
        crewManager.callback = {
            mainAsync {
                self.featuredCrewCollection.reloadData()
            }
        }
        
        featuredCrewCollection.delegate = crewManager
        featuredCrewCollection.dataSource = crewManager
        
        if let backdrop = backdrop, let backdropPath = movie.backdrop_path {
            backdrop.setImage(.Backdrop(path: backdropPath, size: .w780))
        }
        
        if let posterPath = movie.poster_path {
            poster.setImage(.Poster(path: posterPath, size: .w500))
        }
        
        overview.text = movie.overview
        movieTitle.text = movie.title
        
        if let voteAverage = movie.vote_average {
            rating.value = CGFloat(voteAverage)
        }
        
        if let releaseDate = movie.release_date {
            year.text = (releaseDate as NSString).substring(to: 4)
        } else {
            year.text = nil
        }
        
        //MARK: ViewModel output
        guard let output = model.output else { return }
        
        let mappedCast =
            output
            .cast
            .asObservable
            .map { (cast: [MovieCast]) -> [(name: String, character: String, profilePath: String?)] in
                return cast.filter { $0.name != nil && $0.character != nil }.map { (name: $0.name!, character: $0.character!, profilePath: $0.profile_path) }
        }
        
        let mappedCrew =
            output
                .crew
                .asObservable
                .map { (crew: [MovieCrew]) -> [(name: String, job: String)] in
                    return crew
                        .filter { $0.name != nil && $0.job != nil }
                        .map { (name: $0.name!, job: $0.job!) }
        }
        
        _ = castManager.bind(cast: mappedCast)
        _ = crewManager.bind(crew: mappedCrew)

    }
    
}

class FeaturedCrewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    
}

class FeaturedCrewManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    let crew = ReactiveList<(name: String, job: String)>()

    var callback: (() -> Void)?
    
    override init() {
        super.init()
        
        _ = crew.asObservable
            .subscribeOn(MainScheduler.instance)
            .subscribe { _ in
            self.callback?()
        }
    }
    
    func bind(crew: Observable<(name: String, job: String)>) -> Disposable {
        return self.crew.bindElements(of: crew)
    }
    
    func bind(crew: Observable<[(name: String, job: String)]>) -> Disposable {
        return self.crew.bindElements(of: crew)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crew.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCrewCell", for: indexPath) as! FeaturedCrewCell
        cell.name.text = crew.data[indexPath.row].name
        cell.job.text = crew.data[indexPath.row].job
        
        return cell
    }
}

class TopBilledCastCell: UICollectionViewCell {
    
    @IBOutlet weak var picture: TmdbImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
}

class TopBilledCastManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var cast = ReactiveList<(name: String, character: String, profilePath: String?)>()
    
    var callback: (() -> Void)?
    
    override init() {
        super.init()
        
        _ = cast.asObservable
            .subscribeOn(MainScheduler.instance)
            .subscribe { _ in
                self.callback?()
        }
    }
    
    
    func bind(cast: Observable<(name: String, character: String, profilePath: String?)>) -> Disposable {
        return self.cast.bindElements(of: cast)
    }
    
    func bind(cast: Observable<[(name: String, character: String, profilePath: String?)]>) -> Disposable {
        return self.cast.bindElements(of: cast)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopBilledCastCell", for: indexPath) as! TopBilledCastCell
        
        let person = cast.data[indexPath.row]
        
        cell.nameLabel.text = person.name
        cell.characterLabel.text = person.character
        
        if let profilePath = person.profilePath {
            cell.picture.setImage(.Profile(path: profilePath, size: .w132_h132_bestv2))
        }
        return cell
    }
    
}
