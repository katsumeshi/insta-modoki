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

  var body: some View {
    VStack {
      HStack {
        VStack {
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
      }
      Button(action: {}) {
        Text("Edit Profile")
      }
      Button(action: { SessionStore.signOut() }) {
        Text("Sign Out")
      }

      GridView(grid2dArr: viewModel.posts.map { $0.url }.chunked(into: 4))
    }.onAppear {
      self.viewModel.onAppear()
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
