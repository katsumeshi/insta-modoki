//
//  AppDelegate+Injection.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/28/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    registerPostsRepository()
    registerUsersRepository()
  }
}
