//
//  RootViewController.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 10/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController{
    
    static let barButton = UIBarButtonItem(image: UIImage(named: "sidepanel_primary"), style: .plain, target: nil, action: nil)
    
    var center: UINavigationController! = UIStoryboard.navigationViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(center.view)
        addChildViewController(center)
        center.didMove(toParentViewController: self)
        
        center.viewControllers = [UIStoryboard.movieCollections]
        
        center.viewControllers[0].navigationItem.leftBarButtonItem = RootViewController.barButton
    }
}












// SidePanel

//    var side: SidePanelViewController!

//    let panelAnimationTime = 0.30
//    var leftPanelState: SidePanelState = SidePanelState.Contracted

//    var sideWidth: CGFloat {
//        return 0.8 * self.view.frame.width
//    }

//extension RootViewController {
    //    func expandPanel(){
    //        UIView.animate(withDuration: panelAnimationTime, animations: {
    //            self.side.view.frame.origin.x = 0
    //            self.center.view.frame.origin.x = self.sideWidth
    //        }) { completed in
    //            self.leftPanelState = .Expanded
    //        }
    //    }
    //
    //    func contractPanel(){
    //        UIView.animate(withDuration: panelAnimationTime, animations: {
    //            self.side.view.frame.origin.x = -self.sideWidth
    //            self.center.view.frame.origin.x = 0
    //        }) { completed in
    //            self.leftPanelState = .Contracted
    //        }
    //    }
    //
    //    func animateCenterPanelXPostion(targetPosition: CGFloat, completion: @escaping (Bool) -> Void){
    //        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
    //
    //            self.center.view.frame.origin.x = targetPosition
    //            
    //        }, completion: completion)
    //        
    //    }
//}
