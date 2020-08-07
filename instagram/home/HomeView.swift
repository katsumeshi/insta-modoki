//
//  ContentView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/4/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    List {
      ForEach(0..<10, id: \.self) { _ in
        PhotoRow().listRowInsets(EdgeInsets())
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
