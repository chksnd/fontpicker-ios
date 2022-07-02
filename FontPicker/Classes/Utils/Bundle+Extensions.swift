//
//  Bundle+Extensions.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import UIKit

extension Bundle {
  static var local: Bundle {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }
}

private class BundleToken {}
