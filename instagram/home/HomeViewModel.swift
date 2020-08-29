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
import Resolver

final class HomeViewModel: NSObject, ObservableObject {
  @Published var posts: [Post] = []
  @Injected var repository: PostsRepository
  var fetched = false

  private var bag = Set<AnyCancellable>()

  override init() {
    super.init()
    repository.fetch().sink(receiveValue: {
      guard let post = $0 else { return }
      self.posts += [post]
    }).store(in: &bag)
  }
}

extension HomeViewModel: UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < 100 {
      // only 100 pt are left from the bottom
      if !fetched {
        repository.fetch().sink(receiveValue: {
          guard let post = $0 else { return }
          self.posts += [post]
          self.fetched = false
        }).store(in: &bag)
        fetched = true
      }
    }
  }

}
