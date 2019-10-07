//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
	case unknown
	
	init(error: Error) {
		self = .unknown
	}
}
