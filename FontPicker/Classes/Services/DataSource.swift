//
//  DataSource.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import Foundation
import UIKit

protocol DataSourceDelegate {
  func dataSource(_ dataSource: DataSource, didSearch fonts: [String])
  func dataSourceFontsLoaded(_ dataSource: DataSource)
}

class DataSource {

  var delegate: DataSourceDelegate
  var systemFonts: [String] = []
  var fonts: [String] = []

  init(delegate: DataSourceDelegate) {
    self.delegate = delegate
    self.loadFonts()
  }

  private func loadFonts() {
    DispatchQueue.global().async {
      var fonts: [String] = []
      UIFont.familyNames.forEach { familyName in
        UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
          if !fonts.contains(fontName) {
            fonts.append(fontName)
          }
        }
      }

      DispatchQueue.main.async {
        self.systemFonts = fonts.sorted()
        self.fonts = self.systemFonts
        self.delegate.dataSourceFontsLoaded(self)
      }
    }
  }

  func searchFonts(query: String) {
    fonts = query.isEmpty ? systemFonts : systemFonts.filter {
      $0.localizedCaseInsensitiveContains(query)
    }

    delegate.dataSource(self, didSearch: fonts)
  }
}

