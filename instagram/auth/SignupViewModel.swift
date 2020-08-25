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
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published private(set) var emailError = ""
  @Published private(set) var passwordError = ""
  @Published private(set) var canCreate = false

  private var bag = Set<AnyCancellable>()

  init() {

    emailValidation().sink { [weak self] in
      guard let self = self else { return }
      self.emailError = ""
      if $0 == .invalid {
        self.emailError = "Email is invalid"
      }
    }.store(in: &bag)

    passwordValidation().sink { [weak self] in
      guard let self = self else { return }
      self.passwordError = ""
      if $0 == .notMatch {
        self.passwordError = "Password is not match"
      } else if $0 == .less {
        self.passwordError = "Password should be more than 6 characters"
      }
    }.store(in: &bag)

    Publishers.CombineLatest(emailValidation(), passwordValidation()).map {
      $0.0 == .valid && $0.1 == .valid
    }.sink { [weak self] in
      guard let self = self else { return }
      self.canCreate = $0
    }.store(in: &bag)
  }

  private enum EmailValidation {
    case zero
    case valid
    case invalid
  }

  private func emailValidation() -> AnyPublisher<EmailValidation, Never> {
    return self.$email.map {
      if $0.count == 0 {
        return .zero
      } else if self.isValidEmail($0) {
        return .valid
      }
      return .invalid
    }.eraseToAnyPublisher()
  }

  private enum PasswordValidation {
    case zero
    case valid
    case less
    case notMatch
  }

  private func passwordValidation() -> AnyPublisher<PasswordValidation, Never> {
    return Publishers.CombineLatest($password, $confirmPassword).map {
      password, confirmPassword in
      if password.count == 0 && confirmPassword.count == 0 {
        return .zero
      } else if password.count < 6 {
        return .less
      } else if password != confirmPassword {
        return .notMatch
      }
      return .valid
    }.eraseToAnyPublisher()
  }

  func createAccount() {
    SessionStore.createAccount(email: email, password: password)
  }

  private func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}
