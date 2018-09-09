//
//  ShotsScreen.swift
//  Abstract
//
//  Created by Avario Babushka on 07/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import UIKit
import ReactiveCocoa

class MoviesListScreen: UITableViewController {
    
    var movies: [MovieSummary] = []
    
    let moviesNetwork: MoviesNetwork
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    init(moviesNetwork: MoviesNetwork) {
        self.moviesNetwork = moviesNetwork
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Popular Movies"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .movieBlue
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        tableView.register(MovieSummaryTableViewCell.self, forCellReuseIdentifier: MovieSummaryTableViewCell.reuseIdentifier)
        
        activityIndicatorView.startAnimating()
        
        let request = MoviesNetwork.FetchPopularMovies()
        moviesNetwork.reactive.request(request).start({ event in
            
            self.activityIndicatorView.stopAnimating()
            
            switch event {
            case .value(let response):
                self.movies = response.results
                self.tableView.reloadData()
                break
            default:
                break
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieSummaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieSummaryTableViewCell.reuseIdentifier) as! MovieSummaryTableViewCell
        
        movieSummaryTableViewCell.movieSummary = movies[indexPath.row]
        
        return movieSummaryTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSummary = movies[indexPath.row]
        
        let movieDetailsScreen = MovieDetailsScreen(movieSummary: movieSummary, moviesNetwork: moviesNetwork)
        navigationController?.pushViewController(movieDetailsScreen, animated: true)
    }

}

