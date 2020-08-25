//
//  InputField.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/24/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import SwiftUI

enum InputFieldType {
  case regular
  case secure
}

struct InputField: View {
  var placeHolder: String
  var type: InputFieldType = .regular
  @Binding var text: String
  var error: String

  var body: some View {
    VStack(alignment: .leading) {
      Group {
        if type == .regular {
          TextField(placeHolder, text: $text)
        } else {
          SecureField(placeHolder, text: $text)
        }
      }.style()
      if error.isEmpty {
        EmptyView()
      } else {
        Text(error).errorStyle()
      }
    }
  }
}

struct InputField_Previews: PreviewProvider {
  static var previews: some View {
    InputField(placeHolder: "", text: Binding.constant(""), error: "")
  }
}
