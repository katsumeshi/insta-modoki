//
//  ProfileView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/21/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    Button(action: { AuthViewModel.signOut() }) {
      Text("Sign Out")
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
