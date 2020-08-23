//
//  AuthViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/19/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import FirebaseAuth
import Foundation
import GoogleSignIn

//class User {
//  var uid: String
//  var email: String?
//  var displayName: String?
//
//  init(uid: String, displayName: String?, email: String?) {
//    self.uid = uid
//    self.email = email
//    self.displayName = displayName
//  }
//
//}
//
//enum AuthState {
//  case unknown
//  case authrized
//  case unauthrized
//}

final class SigninViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var session: User?
  //  @Published var authState: AuthState = .unknown
  var handle: AuthStateDidChangeListenerHandle?

  //  init() {
  //    listen()
  //  }

  //  func signIn() {
  //    GIDSignIn.sharedInstance()?.presentingViewController =
  //      UIApplication.shared.windows.first!.rootViewController
  //    GIDSignIn.sharedInstance().signIn()
  //  }
  //
  //  func listen() {
  //    // monitor authentication changes using firebase
  //    handle = Auth.auth().addStateDidChangeListener { (auth, user) in
  //      if let user = user {
  //        // if we have a user, create a new user model
  //        print("Got user: \(user)")
  //        self.session = User(
  //          uid: user.uid,
  //          displayName: user.displayName,
  //          email: user.email
  //        )
  //        self.authState = .authrized
  //      } else {
  //        // if we don't have a user, set our session to nil
  //        self.session = nil
  //        self.authState = .unauthrized
  //      }
  //    }
  //  }
  //
  //  static func signOut() {
  //    do {
  //      try Auth.auth().signOut()
  //    } catch {
  //      print("something erorr")
  //    }
  //  }
  //
  //  func unbind() {
  //    if let handle = handle {
  //      Auth.auth().removeStateDidChangeListener(handle)
  //    }
  //  }
  //  @Published var selectIndex: Int = 0
  //  @Published var assets: PHFetchResult<PHAsset> = PHFetchResult()
  //  @Published var grid2dArr: [[Int]] = []
  //  @Published var selectedTabItem = 1
  //  @Published var previewImage: UIImage = UIImage()
  //
  //  static let columnNum: CGFloat = 4
  //  static let thumbNailWidth = UIScreen.main.bounds.width / GarallyViewModel.columnNum
  //  static let previewSize = CGSize(
  //    width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.width * 3)
  //  static let actualThumbnailSize = CGSize(
  //    width: GarallyViewModel.thumbNailWidth * 3, height: GarallyViewModel.thumbNailWidth * 3)
  //  var photos: PhotoAPI
  //  private var bag = Set<AnyCancellable>()
  //
  //  init() {
  //    photos = PhotoAPI()
  //    photos.fetchGallaryData(size: GarallyViewModel.actualThumbnailSize).sink(
  //      receiveCompletion: { _ in
  //      },
  //      receiveValue: { [weak self] in
  //        self?.assets = $0
  //        self?.grid2dArr = Array(0...max((($0.count) - 1), 0)).chunked(
  //          into: Int(GarallyViewModel.columnNum))
  //        self?.setPreviewImage()
  //      }
  //    )
  //    .store(in: &bag)
  //
  //    $selectIndex.sink(receiveValue: { [weak self] _ in
  //      self?.setPreviewImage()
  //    }).store(in: &bag)
  //  }
  //
  //  private func setPreviewImage() {
  //    if let asset = self.getAssetFromIndex() {
  //      self.photos.fetchUIImage(asset: asset, size: PHImageManagerMaximumSize)
  //        .sink(receiveValue: { [weak self] in
  //          self?.previewImage = $0
  //        }).store(in: &self.bag)
  //    }
  //  }
  //
  //  func getAssetFromIndex() -> PHAsset? {
  //    return getAsset(
  //      x: selectIndex % Int(GarallyViewModel.columnNum),
  //      y: selectIndex / Int(GarallyViewModel.columnNum))
  //  }
  //
  //  func getAsset(x: Int, y: Int) -> PHAsset? {
  //    if assets.count > 0 {
  //      return assets.object(at: (y * Int(GarallyViewModel.columnNum)) + x)
  //    }
  //    return nil
  //  }
  //
  //  deinit {
  //    print("GarallyViewModel released")
  //  }

}
