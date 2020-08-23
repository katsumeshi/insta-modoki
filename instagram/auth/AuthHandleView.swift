//
//  AuthHandleView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Foundation
import SwiftUI

struct AuthHandleView: View {
  @ObservedObject var sessionStore = SessionStore()

  var body: some View {
    Group {
      if sessionStore.authState == .unknown {
        LoadingView()
      } else if sessionStore.authState == .authrized {
        AppView()
      } else if sessionStore.authState == .unauthrized {
        SigninView()
      }
    }
  }
}

struct AuthHandleView_Previews: PreviewProvider {
  static var previews: some View {
    AuthHandleView()
  }
}
