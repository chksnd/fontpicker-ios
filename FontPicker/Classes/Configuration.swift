//
//  Configuration.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import Foundation

struct Configuration {
  static var shared: FontPickerConfiguration = FontPickerConfiguration()
}

public struct FontPickerConfiguration {

  public var pickedFontName: String?

  public init() {}

  public init(pickedFontName: String) {
    self.pickedFontName = pickedFontName
  }
}
