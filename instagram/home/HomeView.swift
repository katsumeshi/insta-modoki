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

struct HomeView: View {
  @ObservedObject var viewModel = HomeViewModel()
  //  @State var helper = DelegateHelper()
  var body: some View {
    List {
      ForEach(viewModel.posts) { post in
        PhotoRow(post: post).listRowInsets(EdgeInsets())
      }
    }.introspectScrollView(customize: {
      $0.delegate = self.viewModel
    })
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
