//
//  ProfileViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/27/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//


import Combine
import FirebaseAuth
import Foundation
import GoogleSignIn
import Resolver

final class ProfileViewModel: NSObject, ObservableObject {
  @Injected var repository: UserRepository
    @Published var posts: [Post] = []
    private var feching = false

    private var bag = Set<AnyCancellable>()

    override init() {
          super.init()
      fetchOld()
      repository.get().sink(receiveValue: {
          self.posts = $0
          self.feching = false
      }).store(in: &bag)
    }
      
       func fetchOld() {
          feching = true
          repository.fetchOld()
      }
      
      func fetchNew() {
          feching = true
          repository.fetchNew()
      }

    deinit {
      print("remove HomeViewModel")
    }
  }

  extension ProfileViewModel: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if !feching && scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < 100 {
          fetchOld()
      }
    }

  }
