//
//  ContentView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/4/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(0 ..< 10, id: \.self) { _ in
            PhotoRow()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
