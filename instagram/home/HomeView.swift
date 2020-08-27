//
//  ContentView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/4/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var viewModel = HomeViewModel()
  var body: some View {
    List {
      ForEach(viewModel.posts) { post in
        PhotoRow(post: post).listRowInsets(EdgeInsets())
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
