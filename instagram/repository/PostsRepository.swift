//
//  PostsRepository.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/28/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Resolver

protocol PostsRepository {
  func get() -> AnyPublisher<[Post], Never>
  func fetchOld()
  func fetchNew()
}

extension Resolver {
  public static func registerPostsRepository() {
    register { PostsRepositoryImpl() }
      .implements(PostsRepository.self)
      .scope(cached)
  }
}

class PostsRepositoryImpl: PostsRepository {
    

  private let storage = Storage.storage()
  private let uid = Auth.auth().currentUser?.uid ?? ""
  private let db = Firestore.firestore()
    
  private var oldTimestamp: Double = Date().timeIntervalSince1970
  private var newTimestamp: Double = Date().timeIntervalSince1970

    
  private var subject = PassthroughSubject<[Post], Never>()
  private var posts: [Post] = []
  private var bag = Set<AnyCancellable>()
    
  private static let fetchingCount = 3

  init() {}

  func get() -> AnyPublisher<[Post], Never> {
    return subject.eraseToAnyPublisher()
  }
    
    func fetchOld() {
      let q = self.db.collection(self.uid)
          .whereField("updated", isLessThan: oldTimestamp)
          .order(by: "updated", descending: true)
        .limit(to: PostsRepositoryImpl.fetchingCount)
        fetch(nextQuery: q).sink(receiveValue: {
            self.oldTimestamp = $0.last?.updated ?? 0
            self.posts += $0
            self.subject.send( self.posts)
        }).store(in: &bag)
    }
      
      func fetchNew() {
          let q = self.db.collection(self.uid)
              .whereField("updated", isGreaterThan: newTimestamp)
              .order(by: "updated", descending: true)
              .limit(to: PostsRepositoryImpl.fetchingCount)
        
        fetch(nextQuery: q).sink(receiveValue: {
            self.newTimestamp = $0.first?.updated ?? 0
            self.posts = $0 + self.posts
            self.subject.send( self.posts)
        }).store(in: &bag)
      }
    
   private func fetch(nextQuery: Query) -> AnyPublisher<[Post], Never> {
    let subject = PassthroughSubject<[Post], Never>()
    nextQuery.getDocuments { [weak self] (snapshot, error) in
      guard let self = self else { return }
      guard let snapshot = snapshot else {
        print("Error retreving cities: \(error.debugDescription)")
        return
      }

        var posts: [Post] = []
      for document in snapshot.documents {
        let data = document.data()
        let post = Post(
          url: data["url"] as! String, comment: data["comment"] as! String,
          created: data["created"] as! Double, updated: data["updated"] as! Double)
        posts.append(post)
      }
      subject.send(posts)
    }
    return subject.eraseToAnyPublisher()
  }

  deinit {
    print("PostsRepositoryImpl released")
  }
}
