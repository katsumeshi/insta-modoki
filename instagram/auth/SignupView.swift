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
      TextField("Email", text: $viewModel.email).style()
      Text(viewModel.emailError).errorStyle()
      SecureField("Password", text: $viewModel.password).style()
      SecureField("Confirm Password", text: $viewModel.confirmPassword).style()
      Text(viewModel.passwordError).errorStyle()
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
