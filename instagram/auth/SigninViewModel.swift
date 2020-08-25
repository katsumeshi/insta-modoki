//
//  AuthViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/19/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import FirebaseAuth
import Foundation
import GoogleSignIn

final class SigninViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var signinError = ""
  @Published var alert = false
  @Published var loginDisable = true

  private var bag = Set<AnyCancellable>()

  init() {
    Publishers.CombineLatest($email, $password).sink(receiveValue: { [weak self] in
      guard let self = self else { return }
      self.loginDisable = $0.0.count == 0 || $0.1.count == 0
    }).store(in: &bag)
  }

  func signInWithEmail() {
    SessionStore.signInWithEmail(email: email, password: password).sink { [weak self] in
      guard let self = self else { return }
      self.signinError = $0
      self.alert = $0.count > 0
    }.store(in: &bag)
  }
}
