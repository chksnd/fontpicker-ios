Pod::Spec.new do |spec|
  spec.name           = "FontPicker"
  spec.version        = "1.0.1"
  spec.summary        = "A font picker to search for and use from ChkSnd."
  spec.license        = { :type => "MIT" }
  spec.homepage       = "https://github.com/chksnd/fontpicker-ios"
  spec.author         = { "Aibek Mazhitov" => "aimazhdev@gmail.com" }
  spec.source         = { :git => "https://github.com/chksnd/fontpicker-ios.git", :tag => "#{spec.version}" }
  spec.source_files   = "FontPicker/**/*.{h,m,swift,xib,strings,stringsdict}"
  spec.exclude_files  = "FontPickerDemo"
  spec.frameworks     = "Foundation", "UIKit"
  spec.platform       = ":ios, 13.0"
  spec.requires_arc   = true
  spec.swift_version  = "5.6.1"
end
