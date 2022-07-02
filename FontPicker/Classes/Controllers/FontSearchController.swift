//
//  FontSearchController.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import UIKit

class FontSearchController: UISearchController {
  lazy var customSearchBar = CustomSearchBar(frame: CGRect.zero)

  override var searchBar: UISearchBar {
    customSearchBar.showsCancelButton = false
    return customSearchBar
  }
}

class CustomSearchBar: UISearchBar {
  override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
    super.setShowsCancelButton(false, animated: false)
  }
}
