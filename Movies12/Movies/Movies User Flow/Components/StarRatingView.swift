//
//  StarRatingView.swift
//  Abstract
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class StarRatingView: UIView {

    var rating: Double = 0 {
        didSet {
            for (index, star) in stars.enumerated() {
                if Double(index) < (rating / 2).rounded() {
                    star.textColor = .movieYellow
                } else {
                    star.textColor = UIColor.white.withAlphaComponent(0.5)
                }
            }
        }
    }

    private let stars: [UILabel]
    
    override init(frame: CGRect) {

        // Star Labels
        stars = (1...5).map { _ in
            let star = UILabel()
            star.text = "★"
            star.textColor = UIColor.white.withAlphaComponent(0.1)
            star.textAlignment = .center
            star.font = UIFont.preferredFont(forTextStyle: .callout)

            return star
        }
        
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

extension Reactive where Base: StarRatingView {
    
    var rating: BindingTarget<Double> {
        return makeBindingTarget { $0.rating = $1 }
    }
    
}


