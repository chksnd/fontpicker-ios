//
//  FontPicker.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import UIKit

public protocol FontPickerDelegate {
  func fontPicker(_ fontPicker: FontPicker, didSelectFont fontName: String)
  func fontPickerDidCancel(_ fontPicker: FontPicker)
}

public class FontPicker: UINavigationController {

  private let viewController: FontPickerViewController
  public var pickerDelegate: FontPickerDelegate?

  public init(configuration: FontPickerConfiguration) {
    viewController = FontPickerViewController()
    super.init(nibName: nil, bundle: nil)
    Configuration.shared = configuration
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    viewController.delegate = self
    viewControllers = [viewController]
  }
}

extension FontPicker: FontPickerViewControllerDelegate {
  func fontPickerViewController(_ viewController: FontPickerViewController, didSelectFont fontName: String) {
    pickerDelegate?.fontPicker(self, didSelectFont: fontName)

    // Store the picked font
    Configuration.shared.pickedFontName = fontName
  }

  func fontPickerViewControllerDidCancel(_ viewController: FontPickerViewController) {
    pickerDelegate?.fontPickerDidCancel(self)
  }
}
