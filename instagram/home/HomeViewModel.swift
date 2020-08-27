//
//  HomeViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/26/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import FirebaseAuth
import Foundation
import GoogleSignIn

final class HomeViewModel: ObservableObject {
  @Published var posts: [Post] = []

  private var bag = Set<AnyCancellable>()

  init() {
    FileUtils.fetch().sink(receiveValue: {
      guard let post = $0 else { return }
      self.posts += [post]
    }).store(in: &bag)
  }
}
