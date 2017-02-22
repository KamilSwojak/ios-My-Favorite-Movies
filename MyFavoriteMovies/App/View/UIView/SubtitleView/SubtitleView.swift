//
//  SubtitleView.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 15/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

@IBDesignable
class SubtitleView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBInspectable var titleSize: CGFloat = 19.0 {
        didSet {
            if let titleLabel = titleLabel {
                titleLabel.font = titleLabel.font.withSize(titleSize)
            }
        }
    }
    
    @IBInspectable var subtitleSize: CGFloat = 16.0 {
        didSet {
            if let subtitleLabel = subtitleLabel {
                subtitleLabel.font = subtitleLabel.font.withSize(subtitleSize)
            }
        }
    }
    
    @IBInspectable var titleTextColor: UIColor = UIColor.black {
        didSet {
            if let titleLabel = titleLabel {
                titleLabel.textColor = titleTextColor
            }
        }
    }
    
    @IBInspectable var subtitleTextColor: UIColor = UIColor.gray {
        didSet {
            if let subtitleLabel = subtitleLabel {
                subtitleLabel.textColor = subtitleTextColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        
        if self.subviews.count == 0 {
            
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "SubtitleView", bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.frame = bounds
            addSubview(view)
        }
        
    }
    
    override func prepareForInterfaceBuilder(){
        titleLabel.text = "Title"
        subtitleLabel.text = "Subtitle"
    }
    
}
