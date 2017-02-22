//
//  UICollectionViewHelper.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 22/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class CollectionViewHelper<ELEMENT: Any, CELL: UICollectionViewCell>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var elements = ReactiveList<ELEMENT>()
    
    var itemSelected: Observable<(indexPath: IndexPath, element: ELEMENT)>!
    
    var dataChanges: ((_:[ELEMENT]) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    var style: ((CELL, ELEMENT) -> Void)?
    
    let cellIdentifier: String
    
    init(of collection: UICollectionView, cellIdentifier: String, dataChanges: ((_:[ELEMENT]) -> Void)? = nil) {
        self.cellIdentifier = cellIdentifier
        self.dataChanges = dataChanges
        
        super.init()
        
        collection.delegate = self
        collection.dataSource = self
        
        let d1 = elements.asObservable
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
                guard let newData = event.element else { return }
                
                self.dataChanges?(newData)
        }
        
        disposeBag.insert(d1)
        
        itemSelected = collection.rx
            .itemSelected.asObservable()
            .withLatestFrom(elements.asObservable) {
                return (indexPath: $0, element: $1[$0.row])
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! CELL
        
        self.style?(cell, elements.data[indexPath.row])
        
        return cell
    }
}
