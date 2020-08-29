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
  func get() -> [Post]
  func fetch() -> AnyPublisher<Post?, Never>
  //    func upload() -> AnyPublisher<Void, Error>
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
  private var follwingPosts: [Post] = []

  private var query: Query?

  init() {
    query = db.collection(uid)
      .order(by: "updated")
      .limit(to: 1)
  }

  func get() -> [Post] {
    return follwingPosts
  }

  func fetch() -> AnyPublisher<Post?, Never> {
    let subject = CurrentValueSubject<Post?, Never>(nil)

    query?.getDocuments { [weak self] (snapshot, error) in
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
          created: data["created"] as! NSNumber, updated: data["updated"] as! NSNumber)
        self.follwingPosts.append(post)
        subject.send(post)
      }

      // Construct a new query starting after this document,
      // retrieving the next 25 cities.
      self.query = self.db.collection(self.uid)
        .order(by: "updated")
        .limit(to: 1)
        .start(afterDocument: lastSnapshot)

      // Use the query for pagination.
      // ...
    }
    return subject.eraseToAnyPublisher()
  }

  deinit {
    print("PostsRepositoryImpl released")
  }

  //    func upload() -> AnyPublisher<Void, Error> {
  //    }
}

//  private static let storage = Storage.storage()
//  private static let uid = Auth.auth().currentUser?.uid ?? ""
//  private static let db = Firestore.firestore()

//  static func upload(image: UIImage, comment: String) {
//
//    if let data =
//      image.cropToBounds(width: 1080, height: 1080)
//      .jpegData(compressionQuality: 0.8)
//    {
//      let ref = storage.reference().child("images/\(uid)/\(UUID()).jpg")
//      ref.putData(
//        data, metadata: nil,
//        completion: { (metadata, error) in
//          guard let metadata = metadata else {
//            return
//          }
//          ref.downloadURL { (url, error) in
//            guard let downloadURL = url?.absoluteString else {
//              return
//            }
//            let timestamp = Date().timeIntervalSince1970
//            db.collection(uid).addDocument(data: [
//              "url": downloadURL, "comment": comment, "created": timestamp, "updated": timestamp,
//            ])
//          }
//        })
//    }
//  }
//
//  static func fetch() -> AnyPublisher<Post?, Never> {
//    let subject = CurrentValueSubject<Post?, Never>(nil)
//    let posts = db.collection(uid).whereField("updated", isGreaterThan: ts)
//      .order(by: "updated", descending: true)
//      .limit(to: 10)
//    posts.getDocuments { (querySnapshot, err) in
//      print(querySnapshot?.metadata.description)
//      if let err = err {
//        print("Error getting documents: \(err)")
//      } else {
//        for document in querySnapshot!.documents {
//          let data = document.data()
//          let post = Post(
//            url: data["url"] as! String, comment: data["comment"] as! String,
//            created: data["created"] as! Int, updated: data["updated"] as! Int)
//          subject.send(post)
//        }
//      }
//      ts = Int(Date().timeIntervalSince1970)
//    }
//    return subject.eraseToAnyPublisher()
//  }
//}
