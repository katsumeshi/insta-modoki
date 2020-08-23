//
//  SessionStore.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

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
    handle = Auth.auth().addStateDidChangeListener { (auth, user) in
      if let user = user {
        // if we have a user, create a new user model
        print("Got user: \(user)")
        //          self.session = User(
        //            uid: user.uid,
        //            displayName: user.displayName,
        //            email: user.email
        //          )
        self.authState = .authrized
      } else {
        // if we don't have a user, set our session to nil
        //          self.session = nil
        self.authState = .unauthrized
      }
    }
  }

  static func signIn() {
    GIDSignIn.sharedInstance()?.presentingViewController =
      UIApplication.shared.windows.first!.rootViewController
    GIDSignIn.sharedInstance().signIn()
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
