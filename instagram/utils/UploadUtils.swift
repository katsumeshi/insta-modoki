//
//  UploadUtils.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/24/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct Post: Identifiable {
  var id = UUID()
  var url: String = ""
  var comment: String = ""
  var created: Date = Date()
}

class FileUtils {

  private static let storage = Storage.storage()
  private static let uid = Auth.auth().currentUser?.uid ?? ""
  private static let db = Firestore.firestore()

  static func upload(image: UIImage, comment: String) {

    if let data =
      image.cropToBounds(width: 1080, height: 1080)
      .jpegData(compressionQuality: 0.8)
    {
      let ref = storage.reference().child("images/\(uid)/\(UUID()).jpg")
      ref.putData(
        data, metadata: nil,
        completion: { (metadata, error) in
          guard let metadata = metadata else {
            return
          }
          ref.downloadURL { (url, error) in
            guard let downloadURL = url?.absoluteString else {
              return
            }
            db.collection("posts").addDocument(data: [
              "url": downloadURL, "comment": comment, "created": Date(),
            ])
          }
        })
    }
  }

  static func fetch() -> AnyPublisher<Post?, Never> {
    let subject = CurrentValueSubject<Post?, Never>(nil)
    let posts = db.collection("posts").order(by: "created", descending: true).limit(to: 10)
    posts.getDocuments { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          let data = document.data()
          let post = Post(
            url: data["url"] as! String, comment: data["comment"] as! String, created: Date())
          subject.send(post)
        }
      }
    }
    return subject.eraseToAnyPublisher()
  }
}
