# System Font Picker for iOS

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FontPicker.svg?style=flat-square)](https://cocoapods.org/pods/FontPicker)
[![Platform](https://img.shields.io/cocoapods/p/FontPicker.svg?style=flat-square)](https://github.com/unsplash/unsplash-photopicker-ios)
[![License](https://img.shields.io/github/license/chksnd/fontpicker-ios.svg?style=flat-square)](https://github.com/unsplash/unsplash-photopicker-ios)

FontPicker is an iOS UI component that allows you to quickly search the system fonts with just a few lines of code.

![Font Picker for iOS preview](https://i.imgur.com/5IQzAzz.png "Font Picker for iOS")

## Description

FontPicker is a view controller. You present it to offer your users to select one system font. Once they have selected font, the view controller returns the font name as a `String` object that you can use in your app.

## Requirements

- iOS 13.0+
- Xcode 13.4+
- Swift 5.6+

## Installation

### CocoaPods

To integrate FontPicker into your Xcode project using [CocoaPods](https://cocoapods.org), specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FontPicker', '~> 1.0'
end
```

Then run `pod install`.

## Usage

### Presenting

`FontPicker` is a subclass of `UINavigationController`. We recommend that you present it modally or as a popover on iPad. Before presenting it, you need to implement the `FontPickerDelegate` protocol, and use the `pickerDelegate` property to get the results.

```swift
protocol FontPickerDelegate: class {
  func fontPicker(_ photoPicker: FontPicker, didSelectFont fontName: String)
  func fontPickerDidCancel(_ photoPicker: FontPicker)
}
```

### Using the results

`FontPicker` returns a `String` object that represents the system font name.
## License

MIT License

Copyright (c) ChkSnd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
