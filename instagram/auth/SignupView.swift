//
//  SignupView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct SignupView: View {
  @ObservedObject var viewModel = SignupViewModel()
  var body: some View {
    VStack {
      InputField(placeHolder: "Email", text: $viewModel.email, error: viewModel.emailError)
      SecureField("Password", text: $viewModel.password).style()
      InputField(
        placeHolder: "Confirm Password", type: .secure, text: $viewModel.confirmPassword,
        error: viewModel.passwordError)
      Button(action: { self.viewModel.createAccount() }) {
        Text("Create").style()
      }.disabled(!viewModel.canCreate)
        .buttonStyle(PlainButtonStyle())
    }.padding()
  }
}

struct SignupView_Previews: PreviewProvider {
  static var previews: some View {
    SignupView()
  }
}
