//
//  CodableProperties.swift
//  Movies
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import ReactiveSwift

extension Property: Codable where Value: Codable {
    
    convenience public init(from decoder: Decoder) throws {
        self.init(value: try Value(from: decoder))
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

extension MutableProperty: Codable where Value: Codable {
    
    convenience public init(from decoder: Decoder) throws {
        self.init(try Value(from: decoder))
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
