//
//  UploadUtils.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/24/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FileUtils {

  private static let storage = Storage.storage()
  private static let uid = Auth.auth().currentUser?.uid ?? ""
  private static let db = Firestore.firestore()

  static func upload(image: UIImage) {
    if let data = image.jpegData(compressionQuality: 0.8) {
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
            db.collection("posts").addDocument(data: ["url": downloadURL])
          }
        })
    }
  }
}
