//
//  ProfileViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/27/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Resolver

final class ProfileViewModel: ObservableObject {
  @Published var posts: [Post] = []
  @Injected var repository: PostsRepository

  private var bag = Set<AnyCancellable>()

  init() {
  }

  func onAppear() {
    posts = repository.get()
  }
}
