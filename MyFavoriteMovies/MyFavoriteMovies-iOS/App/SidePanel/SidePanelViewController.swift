//
//  SidePanelViewController.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 10/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class SidePanelViewController: UITableViewController {
    
    var selected: Observable<SidePanelItem> {
        return tableView.rx
            .itemSelected.asObservable()
            .filter{ indexPath in return SidePanelItem.from(indexPath: indexPath) != nil }
            .map({ (indexPath: IndexPath) -> SidePanelItem in
                return SidePanelItem.from(indexPath: indexPath)!
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.top = UIApplication.shared.statusBarFrame.height + 44 // status bar + nav bar
        self.view.backgroundColor = UIColor.secondary
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.backgroundColor = UIColor.secondary
        cell.selectedBackgroundView = UIView()
        
        guard let item = SidePanelItem.from(indexPath: indexPath) else { return cell}
        cell.imageView?.image = UIImage(named: item.imageNameNormal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) else { return }
        guard let item = SidePanelItem.from(indexPath: indexPath) else { return }
        
        selectedCell.imageView?.image = UIImage(named: item.imageNameSelected)
        selectedCell.selectedBackgroundView?.backgroundColor = UIColor.primary
        selectedCell.textLabel?.textColor = UIColor.secondary
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let deselectedCell = tableView.cellForRow(at: indexPath) else { return }
        guard let item = SidePanelItem.from(indexPath: indexPath) else { return }
        
        deselectedCell.imageView?.image = UIImage(named: item.imageNameNormal)
        deselectedCell.selectedBackgroundView?.backgroundColor = UIColor.secondary
        deselectedCell.textLabel?.textColor = UIColor.primary
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.secondary

        guard let view = (view as? UITableViewHeaderFooterView) else { return }
        
        view.textLabel?.textColor = UIColor.primary
    }

}
