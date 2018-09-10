//
//  PostTableViewCell.swift
//  Abstract
//
//  Created by Avario on 08/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import UIKit
import Kingfisher
import ReactiveSwift

class MovieSummaryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "MovieSummaryTableViewCell"
    
    private let backdropImageView = UIImageView()
    private let titleLabel = UILabel()
    private let starRatingView = StarRatingView()
    
    var movieSummary: MovieSummary! {
        didSet {
            titleLabel.reactive.text <~ movieSummary.title
                .producer.take(until: reactive.prepareForReuse)
            
            starRatingView.reactive.rating <~ movieSummary.rating
                .producer.take(until: reactive.prepareForReuse)
            
            backdropImageView.reactive.imageURL <~ movieSummary.backdropImageURL
                .producer.take(until: reactive.prepareForReuse)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = nil
        contentView.backgroundColor = nil
        backgroundView?.backgroundColor = nil
        selectionStyle = .none
                
        // Content View
        contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Backdrop Image View
        contentView.addSubview(backdropImageView)
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        backdropImageView.clipsToBounds = true
        backdropImageView.layer.cornerRadius = 5
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        backdropImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        backdropImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        backdropImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        
        // Gradient
        let gradientImageView = UIImageView(image: #imageLiteral(resourceName: "gradient"))
        backdropImageView.addSubview(gradientImageView)
        gradientImageView.contentMode = .scaleToFill
        gradientImageView.alpha = 0.5
        gradientImageView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        gradientImageView.leftAnchor.constraint(equalTo: backdropImageView.leftAnchor).isActive = true
        gradientImageView.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor).isActive = true
        gradientImageView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor).isActive = true
        
        // Title Label
        let font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        let fontMetrics = UIFontMetrics(forTextStyle: .title1)
        let scaledFont = fontMetrics.scaledFont(for: font)
        
        titleLabel.textColor = .white
        titleLabel.font = scaledFont
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Content Stack View
        let contentStackView = UIStackView(arrangedSubviews: [titleLabel, starRatingView])
        contentView.addSubview(contentStackView)
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentStackView.leftAnchor.constraint(equalTo: backdropImageView.leftAnchor, constant: 15).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor, constant: -15).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
