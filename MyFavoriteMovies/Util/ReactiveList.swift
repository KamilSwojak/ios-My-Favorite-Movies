//
//  MovieListDataSource.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 08/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class ReactiveList<Element: Any>{
    
    private var variable: Variable<[Element]>
    
    var data: [Element]{
        return variable.value
    }
    
    var asObservable: Observable<[Element]>{
        return variable.asObservable()
    }
    
    init(initial: [Element] = []) {
        self.variable = Variable(initial)
    }
    
    func append(element: Element) {
        variable.value.append(element)
    }
    
    func append(elements: [Element]){
        variable.value.append(contentsOf: elements)
    }
    
    func insert(element: Element, at index: Int) {
        variable.value.insert(element, at: index)
    }
    
    func insert(elements: [Element], at index: Int) {
        variable.value.insert(contentsOf: elements, at: index)
    }
    
    func remove(at index: Int) {
        variable.value.remove(at: index)
    }
    
    func clearAll() {
        variable.value.removeAll()
    }
    
    func bindElements(of sequence: Observable<Element>) -> Disposable{
        return sequence.subscribe { (event) in
            guard let element = event.element else { return }
            
            self.variable.value.append(element)
        }
    }
    
    func bindElements(of sequence: Observable<[Element]>) -> Disposable{
        return sequence.bindTo(self.variable)
    }
    
}
