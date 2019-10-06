//
//  Detector.swift
//  Movies13 Dev
//
//  Created by Avario on 07/10/2019.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import UIKit
import SwiftUI

struct Detector: View {
	
	let info = ProcessInfo.processInfo
	
	let keys: [String]
	let values: [String]
	
	init() {
		keys = Array(info.environment.keys)
		values = Array(info.environment.values)
	}
	
    var body: some View {
		VStack(alignment: .leading) {
			ForEach(keys, id: \.self) { key in
				VStack {
					Text(verbatim: key)
					Text(verbatim: self.info.environment[key]!)
						.foregroundColor(.secondary)
					Divider()
				}
			}
		}
    }
}

struct Detector_Previews: PreviewProvider {
    static var previews: some View {
        Detector()
			.previewLayout(.sizeThatFits)
    }
}
