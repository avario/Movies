//
//  MovieDetailsViewController.swift
//  Abstract
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import UIKit

class MovieDetailsScreen: UIViewController {
    
    private let moviesNetwork: MoviesNetwork
    private let movieSummary: MovieSummary
    
    private let posterImageView = UIImageView()
    private let overviewLabel = UILabel()
    private let genresLabel = UILabel()
    private let yearLabel = UILabel()
    private let starRatingView = StarRatingView()
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    init(movieSummary: MovieSummary, moviesNetwork: MoviesNetwork) {
        self.movieSummary = movieSummary
        self.moviesNetwork = moviesNetwork
        
        super.init(nibName: nil, bundle: nil)
        
        title = movieSummary.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .movieBlue
        
        activityIndicatorView.startAnimating()
        
        let request = MoviesNetwork.FetchMovieDetails(movieId: movieSummary.id)
        moviesNetwork.reactive.request(request).start({ event in
            self.activityIndicatorView.stopAnimating()
            
            switch event {
            case .value(let movieDetails):
                let yearDateFormatter = DateFormatter()
                yearDateFormatter.dateFormat = "yyyy"
                
                self.posterImageView.kf.setImage(with: movieDetails.posterURL)
                self.yearLabel.text = yearDateFormatter.string(from: movieDetails.releaseDate)
                self.genresLabel.text = movieDetails.genres.map({ $0.name }).joined(separator: ", ")
                self.overviewLabel.text = movieDetails.overview
                self.starRatingView.rating = movieDetails.rating/2
            default:
                break
            }
        })
        
        // Scroll View
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        // Poster Image View
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 5
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        posterImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: (2.0/3.0)).isActive = true
        
        // Overview Label
        overviewLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        overviewLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        overviewLabel.numberOfLines = 10
        
        // Year Label
        let yearLabelFont = UIFont.systemFont(ofSize: 24, weight: .heavy)
        let fontMetric = UIFontMetrics(forTextStyle: .callout)
        
        yearLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        yearLabel.font = fontMetric.scaledFont(for: yearLabelFont)
        
        // Genres Label
        genresLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        genresLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        
        // Details Stack View
        let detailsStackView = UIStackView(arrangedSubviews: [yearLabel, genresLabel])
        detailsStackView.spacing = 12
        
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [posterImageView, detailsStackView, overviewLabel, starRatingView])
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 12
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    }
    
}
