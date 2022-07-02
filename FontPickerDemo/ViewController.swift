//
//  ViewController.swift
//  FontPickerDemo
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import UIKit
import FontPicker

class ViewController: UIViewController {

  var fontPicker: FontPicker!

  @IBOutlet weak var fontLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    fontPicker = FontPicker(configuration: FontPickerConfiguration())
    fontPicker.pickerDelegate = self
  }

  @IBAction func handleClickOpenFontPicker(_ sender: Any) {
    present(fontPicker, animated: true)
  }
}

extension ViewController: FontPickerDelegate {
  func fontPicker(_ fontPicker: FontPicker, didSelectFont font: String) {
    dismiss(animated: true)
    fontLabel.text = font
  }

  func fontPickerDidCancel(_ fontPicker: FontPicker) {
    dismiss(animated: true)
  }
}
