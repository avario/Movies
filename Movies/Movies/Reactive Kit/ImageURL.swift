//
//  ImageURL.swift
//  Movies
//
//  Created by Avario on 10/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import ReactiveCocoa
import ReactiveSwift

extension Reactive where Base: UIImageView {
    
    var imageURL: BindingTarget<URL> {
        return makeBindingTarget { $0.kf.setImage(with: $1) }
    }
    
}
