Pod::Spec.new do |spec|

  spec.name         = "SlideOverCard"
  spec.version      = "0.0.1"
  spec.summary      = "SlideOverCard is a View for SwiftUI"

  spec.description  = <<-DESC
This library mimics Slide Over Card for using with SwiftUI code.
                   DESC

  spec.homepage     = "https://github.com/Devepre/SlideOverCard"

  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Serhii Kyrylenko" => "bicycle2life@gmail.com" }
  spec.social_media_url   = "https://www.linkedin.com/in/serhii-kyrylenko-232189110/"

  spec.platform     = :ios, "13.0"
  spec.swift_version = "5"

  spec.source       = { :git => "https://github.com/Devepre/SlideOverCard.git", :tag => "#{spec.version}" }

  spec.source_files  = "SlideOverCard/**/*.{h,m,swift}"
  spec.public_header_files = "SlideOverCard/**/*.h"

end
