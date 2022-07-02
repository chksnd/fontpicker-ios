//
//  String+Localization.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import Foundation

extension String {
  func localized() -> String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.local, comment: "")
  }
}
