//
//  ContentView.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 21/09/22.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Home()
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
