//
//  ProfileView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/21/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject private var viewModel: ProfileViewModel = ProfileViewModel()
    @State private var isActive = false

  var body: some View {
    NavigationView {
    VStack(spacing: 0) {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
          Image("cat")
            .resizable()
            .frame(width: 40, height: 40)
            .scaledToFit()
            .cornerRadius(20)
            .padding(2)
          Text("Yuki Matsushita")
        }
        VStack {
          Text("346").bold()
          Text("Posts")
        }
        VStack {
          Text("164").bold()
          Text("Followers")
        }
        VStack {
          Text("357").bold()
          Text("Following")
        }
        }.frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.green)
      Button(action: {}) {
        Text("Edit Profile")
      }
      Button(action: { SessionStore.signOut() }) {
        Text("Sign Out")
      }
        NavigationLink(destination: HomeView(), isActive: $isActive) {
          EmptyView()
        }
        GridView(grid2dArr: viewModel.posts.map { $0.url }.chunked(into: 3), column: 3) {
            isActive = $0 >= 0
        }
    }
    .navigationBarTitle("Profile", displayMode: .inline)
  }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
