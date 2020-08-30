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
  func fetchOld() -> AnyPublisher<Post?, Never>
  func fetchNew() -> AnyPublisher<Post?, Never>
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
    
    private var oldTimestamp: Double = Date().timeIntervalSince1970
  private var newTimestamp: Double = Date().timeIntervalSince1970

  private var query: Query?

  init() {
    query = db.collection(uid)
        .whereField("updated", isLessThan: oldTimestamp)
        .order(by: "updated", descending: true)
        .limit(to: 1)
  }

  func get() -> [Post] {
    return follwingPosts
  }
    
  func fetchOld() -> AnyPublisher<Post?, Never> {
    let q = self.db.collection(self.uid)
        .whereField("updated", isLessThan: oldTimestamp)
        .order(by: "updated", descending: true)
        .limit(to: 1)
    return fetch(nextQuery: q).map {
        self.oldTimestamp = min(self.oldTimestamp, $0?.updated ?? 0)
        return $0
    }.eraseToAnyPublisher()
  }
    
    func fetchNew() -> AnyPublisher<Post?, Never> {
        let q = self.db.collection(self.uid)
            .whereField("updated", isGreaterThan: newTimestamp)
            .order(by: "updated", descending: true)
            .limit(to: 1)
        return fetch(nextQuery: q).map {
            self.newTimestamp = max(self.newTimestamp, $0?.updated ?? 0)
            return $0
        }.eraseToAnyPublisher()
    }
    
   private func fetch(nextQuery: Query) -> AnyPublisher<Post?, Never> {
    let subject = PassthroughSubject<Post?, Never>()

    nextQuery.getDocuments { [weak self] (snapshot, error) in
      guard let self = self else { return }
      guard let snapshot = snapshot else {
        print("Error retreving cities: \(error.debugDescription)")
        return
      }

      for document in snapshot.documents {
        let data = document.data()
        let post = Post(
          url: data["url"] as! String, comment: data["comment"] as! String,
          created: data["created"] as! Double, updated: data["updated"] as! Double)
        subject.send(post)
      }
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
