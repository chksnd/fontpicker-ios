#
#  Be sure to run `pod spec lint FontPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name           = "FontPicker"
  spec.version        = "1.0.0"
  spec.summary        = "A font picker to search for and use from ChkSnd."
  spec.license        = { :type => "MIT" }
  spec.homepage       = "https://github.com/chksnd/fontpicker-ios"
  spec.author         = { "Aibek Mazhitov" => "aimazhdev@gmail.com" }
  spec.source         = { :git => "https://github.com/chksnd/fontpicker-ios.git", :tag => "#{spec.version}" }
  spec.source_files   = "FontPicker/**/*.{h,m,swift,xib,strings,stringsdict}"
  spec.exclude_files  = "FontPickerDemo"
  spec.frameworks     = "Foundation", "UIKit"
  spec.requires_arc   = true
  spec.swift_version  = "5.3"
end
