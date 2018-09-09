//
//  MovieDetails.swift
//  Abstract
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire

struct MovieDetails: Codable {
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    let id: Int
    let title: String
    let releaseDateString: String
    let genres: [Genre]
    let posterPath: String
    let overview: String
    let rating: Double
    
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
    var posterURL: URL? {
        let url = try! "https://image.tmdb.org/t/p/w780".asURL()
        return url.appendingPathComponent(posterPath)
    }
    
    var releaseDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: releaseDateString)!
    }
}
