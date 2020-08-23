//
//  SignupViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import SwiftUI

final class SignupViewModel: ObservableObject {
  @Published var email = ""
  @Published var emailError = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var passwordError = ""
  @Published var canCreate = false

  private var bag = Set<AnyCancellable>()

  init() {
    $email.sink { [weak self] in
      guard let self = self else { return }
      if $0.count == 0 {
        self.emailError = ""
      } else if !self.isValidEmail($0) {
        self.emailError = "Password is invalid"
      } else {
        self.emailError = ""
      }
    }.store(in: &bag)

    Publishers.CombineLatest($password, $confirmPassword).sink(receiveValue: {
      [weak self] password, confirmPassword in
      guard let self = self else { return }
      if password.isEmpty && confirmPassword.isEmpty {
        self.passwordError = ""
      } else if password != confirmPassword {
        self.passwordError = "passwords are not match"
      } else if password.count <= 6 {
        self.passwordError = "password should be more than 6 charactors"
      } else {
        self.passwordError = ""
      }
    }).store(in: &bag)

    let hasEmail = $email.map { $0.count > 0 }
    let hasPassword = $password.map { $0.count > 0 }
    let hasConfirmPassword = $confirmPassword.map { $0.count > 0 }
    let noEmailError = $emailError.map { $0.count == 0 }
    let noPasswordError = $passwordError.map { $0.count == 0 }

    let hasAll = Publishers.CombineLatest3(hasEmail, hasPassword, hasConfirmPassword).map {
      $0.0 && $0.1 && $0.2
    }

    let noAll = Publishers.CombineLatest(noEmailError, noPasswordError).map {
      $0.0 && $0.1
    }

    Publishers.CombineLatest(hasAll, noAll).sink(receiveValue: {
      [weak self] in
      guard let self = self else { return }
      self.canCreate = false
      if $0.0 && $0.1 {
        self.canCreate = true
      }
    }).store(in: &bag)
  }

  func createAccount() {
    SessionStore.createAccount(email: email, password: password)
  }

  func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}
