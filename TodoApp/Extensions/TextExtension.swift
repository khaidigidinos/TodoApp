//
//  TextExtension.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/20/22.
//

import SwiftUI

extension Text {
  func scalableText(font: Font = Font.system(size: 1000)) -> some View {
    self
      .font(font)
      .minimumScaleFactor(0.01)
      .lineLimit(1)
  }
}
