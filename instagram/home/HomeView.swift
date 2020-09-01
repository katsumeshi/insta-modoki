//
//  ContentView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/4/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Introspect
import SwiftUI
import UIKit
import SwiftUIRefresh

struct HomeView: View {
  @ObservedObject var viewModel = HomeViewModel()
  @State var isRefreshing = false
  var body: some View {
    List {
      ForEach(viewModel.posts) { post in
        PhotoRow(post: post).listRowInsets(EdgeInsets())
      }
    }.introspectScrollView(customize: {
      $0.delegate = self.viewModel
    }).pullToRefresh(isShowing: $isRefreshing) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            viewModel.fetchNew()
            self.isRefreshing = false
        }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
