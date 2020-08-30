//
//  UserRepository.swift
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

protocol UserRepository {
  func get() -> [Post]
  func fetch() -> AnyPublisher<Post?, Never>
  //    func upload() -> AnyPublisher<Void, Error>
}
extension Resolver {
  public static func registerUsersRepository() {
    register { UserRepositoryImpl() }
      .implements(PostsRepository.self)
      .scope(cached)
  }
}

class UserRepositoryImpl: UserRepository {

  private let storage = Storage.storage()
  private let uid = Auth.auth().currentUser?.uid ?? ""
  private let db = Firestore.firestore()
  private var posts: [Post] = []

  func get() -> [Post] {
    return posts
  }

  func fetch() -> AnyPublisher<Post?, Never> {
    let subject = CurrentValueSubject<Post?, Never>(nil)

    let first = db.collection(uid)
      .order(by: "updated")
      .limit(to: 20)

    first.addSnapshotListener { [weak self] (snapshot, error) in
      guard let self = self else { return }
      guard let snapshot = snapshot else {
        print("Error retreving cities: \(error.debugDescription)")
        return
      }

      guard let lastSnapshot = snapshot.documents.last else {
        // The collection is empty.
        return
      }

      for document in snapshot.documents {
        let data = document.data()
        let post = Post(
          url: data["url"] as! String, comment: data["comment"] as! String,
          created: data["created"] as! Double, updated: data["updated"] as! Double)
        self.posts.append(post)
        subject.send(post)
      }

      // Construct a new query starting after this document,
      // retrieving the next 25 cities.
      let next = self.db.collection(self.uid)
        .order(by: "updated")
        .start(afterDocument: lastSnapshot)

      // Use the query for pagination.
      // ...
    }

    //    let postQuery = db.collection(uid).whereField("updated", isGreaterThan: ts)
    //      .order(by: "updated", descending: true)
    //      .limit(to: 10)
    //    postQuery.getDocuments { (querySnapshot, err) in
    //      if let err = err {
    //        print("Error getting documents: \(err)")
    //      } else {
    //        for document in querySnapshot!.documents {
    //          let data = document.data()
    //          let post = Post(
    //            url: data["url"] as! String, comment: data["comment"] as! String,
    //            created: data["created"] as! Int, updated: data["updated"] as! Int)
    //          self.posts.append(post)
    //          subject.send(post)
    //        }
    //      }
    //      ts = Int(Date().timeIntervalSince1970)

    return subject.eraseToAnyPublisher()
  }

  deinit {
    print("PostsRepositoryImpl released")
  }

  //    func upload() -> AnyPublisher<Void, Error> {
  //    }
}
