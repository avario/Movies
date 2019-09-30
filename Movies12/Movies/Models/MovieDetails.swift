//
//  MovieDetails.swift
//  Movies
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

struct MovieDetails: Codable {

    struct Genre: Codable {
        // Properties
        let id: Property<Int>
        let name: Property<String>
    }

    // Properties
    let id: Property<Int>
    let title: Property<String>
    let releaseDateString: Property<String>
    let genres: Property<[Genre]>
    let posterPath: Property<String>
    let overview: Property<String>
    let rating: Property<Double>

    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDateString = "release_date"
        case genres
        case posterPath = "poster_path"
        case overview
        case rating = "vote_average"
    }

}

extension MovieDetails {

    // Poster URL
    var posterURL: Property<URL> {
        return posterPath.map({ posterPath in
            let url = try! "https://image.tmdb.org/t/p/w780".asURL()
            return url.appendingPathComponent(posterPath)
        })
    }

    // Release Date
    var releaseDate: Property<Date> {
        return releaseDateString.map({ releaseDateString in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: releaseDateString)!
        })
    }

}
