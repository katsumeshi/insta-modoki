//
//  AppView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/5/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct AppView: View {
  @State private var selectedItem = 1
  @State private var oldSelectedItem = 1
  @State private var showModal = false
  var body: some View {
    TabView(selection: $selectedItem) {
      HomeView()
        .tabItem {
          Image(systemName: "house.fill")
        }
        .tag(1)
        .onAppear { self.oldSelectedItem = self.selectedItem }
      HomeView()
        .tabItem {
          Image(systemName: "magnifyingglass")
        }
        .tag(2)
        .onAppear { self.oldSelectedItem = self.selectedItem }
      Text("")
        .onAppear {
          DispatchQueue.main.async {
            self.showModal.toggle()
          }

          self.selectedItem = self.oldSelectedItem

        }.tabItem {
          Image(systemName: "plus.app")
        }
        .tag(3)
        .onTapGesture {
          print("aaaaaa")
        }
      HomeView()
        .tabItem {
          Image(systemName: "heart")
        }
        .tag(4)
        .onAppear { self.oldSelectedItem = self.selectedItem }
      HomeView()
        .tabItem {
          Image(systemName: "person")
        }
        .tag(5)
        .onAppear { self.oldSelectedItem = self.selectedItem }
    }
    .sheet(isPresented: self.$showModal) {
      Text("Camera View")
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
