//
//  AuthView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/19/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct AuthView: View {
  @ObservedObject var viewModel = AuthViewModel()
  var body: some View {
    Group {
      if viewModel.session == nil {
        content
      } else {
        AppView()
      }
    }
  }

  var content: some View {

    NavigationView {
      VStack {
        Spacer()
        VStack {
          Text("Instagram").font(.largeTitle)
          VStack {
            TextField("Email", text: $viewModel.email).padding(8)
          }.background(Color.secondarySystemBackground)
            .cornerRadius(6)
          VStack {
            SecureField("Password", text: $viewModel.password).padding(8)
          }.background(Color.secondarySystemBackground)
            .cornerRadius(6)
          VStack {
            NavigationLink(destination: AppView()) {
              Text("Log In").fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundColor(.white)
            }
          }.background(Color.blue)
            .cornerRadius(6)

          HStack {
            HorizontalLine(color: .secondary)
            Text("OR")
            HorizontalLine(color: .secondary)
          }
          Button(action: {
            self.viewModel.signIn()
          }) {
            HStack {
              Image("google")
              Text("Log in with Google")
            }
          }.buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal)
        Spacer()
        VStack {
          Divider()
          HStack {
            Text("Don't have an account?").foregroundColor(.secondary)
            Text("Sign up.")
          }
        }
      }.navigationBarHidden(true)
        .frame(minHeight: 0, maxHeight: .infinity)
        .padding(.vertical)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
  }
}

struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthView()
  }
}

extension Color {

  static var secondarySystemFill = Color.init(UIColor.secondarySystemFill)
  static var secondarySystemBackground = Color.init(UIColor.secondarySystemBackground)
  static var tertiarySystemBackground = Color.init(UIColor.tertiarySystemBackground)

}
