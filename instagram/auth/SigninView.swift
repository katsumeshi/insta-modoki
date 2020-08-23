//
//  AuthView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/19/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct SigninView: View {
  @ObservedObject var viewModel = SigninViewModel()
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        VStack {
          Text("Instagram").font(.largeTitle)
          TextField("Email", text: $viewModel.email).style()
          SecureField("Password", text: $viewModel.password).style()
          NavigationLink(destination: AppView()) {
            Text("Log In").style()
          }

          HStack {
            HorizontalLine(color: .secondary)
            Text("OR")
            HorizontalLine(color: .secondary)
          }
          Button(action: {
            SessionStore.signIn()
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
            NavigationLink(destination: SignupView()) {
              Text("Sign up.")
            }
          }
        }
      }.navigationBarHidden(true)
        .frame(minHeight: 0, maxHeight: .infinity)
        .padding(.vertical)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
  }
}

struct SigninView_Previews: PreviewProvider {
  static var previews: some View {
    SigninView()
  }
}

extension Color {

  static var secondarySystemFill = Color.init(UIColor.secondarySystemFill)
  static var secondarySystemBackground = Color.init(UIColor.secondarySystemBackground)
  static var tertiarySystemBackground = Color.init(UIColor.tertiarySystemBackground)

}
