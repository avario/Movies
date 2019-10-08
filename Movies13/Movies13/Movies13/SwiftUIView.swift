//
//  SwiftUIView.swift
//  Movies13 Dev
//
//  Created by Avario Babushka on 8/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

class DependOnMe: ObservableObject {

}

struct SwiftUIView: View {
	@EnvironmentObject var depending: DependOnMe

    var body: some View {
        Text("Hello World")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
