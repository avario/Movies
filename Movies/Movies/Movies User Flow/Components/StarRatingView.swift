//
//  StarRatingView.swift
//  Abstract
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import UIKit

class StarRatingView: UIView {

    var rating: Double = 0 {
        didSet {
            for (index, star) in stars.enumerated() {
                if Double(index) < rating.rounded() {
                    star.textColor = .movieYellow
                } else {
                    star.textColor = UIColor.white.withAlphaComponent(0.5)
                }
            }
        }
    }

    private let stars: [UILabel]
    
    override init(frame: CGRect) {
        // Star 1
        let star1 = UILabel()
        star1.text = "★"
        star1.textColor = UIColor.white.withAlphaComponent(0.1)
        star1.textAlignment = .center
        star1.font = UIFont.preferredFont(forTextStyle: .callout)
        
        // Star 2
        let star2 = UILabel()
        star2.text = "★"
        star2.textColor = UIColor.white.withAlphaComponent(0.1)
        star2.textAlignment = .center
        star2.font = UIFont.preferredFont(forTextStyle: .callout)
        
        // Star 3
        let star3 = UILabel()
        star3.text = "★"
        star3.textColor = UIColor.white.withAlphaComponent(0.1)
        star3.textAlignment = .center
        star3.font = UIFont.preferredFont(forTextStyle: .callout)
        
        // Star 4
        let star4 = UILabel()
        star4.text = "★"
        star4.textColor = UIColor.white.withAlphaComponent(0.1)
        star4.textAlignment = .center
        star4.font = UIFont.preferredFont(forTextStyle: .callout)
        
        // Star 5
        let star5 = UILabel()
        star5.text = "★"
        star5.textColor = UIColor.white.withAlphaComponent(0.1)
        star5.textAlignment = .center
        star5.font = UIFont.preferredFont(forTextStyle: .callout)
        
        stars =  [star1, star2, star3, star4, star5]
        
        super.init(frame: frame)
        
        // Star Stack View
        let starStackView = UIStackView(arrangedSubviews: stars)
        addSubview(starStackView)
        starStackView.spacing = 3
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        
        starStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        starStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        starStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        starStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
