//
//  SessionStore.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import FirebaseAuth
import Foundation
import GoogleSignIn

enum SessionState {
  case unknown
  case authrized
  case unauthrized
}

final class SessionStore: ObservableObject {

  @Published var authState: SessionState = .unknown
  var handle: AuthStateDidChangeListenerHandle?

  init() {
    listen()
  }

  func listen() {
    // monitor authentication changes using firebase
    handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
      guard let self = self else { return }
      if let user = user {
        self.authState = .authrized
      } else {
        self.authState = .unauthrized
      }
    }
  }

  static func signInWithEmail(email: String, password: String) -> AnyPublisher<String, Never> {
    return Future { promise in
      Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
        if let errStr = error?.localizedDescription {
          promise(.success(errStr))
        }
      }
    }.eraseToAnyPublisher()
  }

  static func signIn() {
    GIDSignIn.sharedInstance()?.presentingViewController =
      UIApplication.shared.windows.first!.rootViewController
    GIDSignIn.sharedInstance()?.signIn()
  }

  static func createAccount(email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      // ...
    }
  }

  static func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("something erorr")
    }
  }

  func unbind() {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}
