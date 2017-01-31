DGParallaxInteractiveTransition
=================================

[![Build Status](https://travis-ci.org/Digipolitan/parallax-interactive-transition-swift.svg?branch=master)](https://travis-ci.org/Digipolitan/parallax-interactive-transition-swift)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DGParallaxInteractiveTransition.svg)](https://img.shields.io/cocoapods/v/DGParallaxInteractiveTransition.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/DGParallaxInteractiveTransition.svg?style=flat)](http://cocoadocs.org/docsets/DGParallaxInteractiveTransition)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

The `ParallaxInteractiveTransition` add a simple way to perform parallax interactive transition between 2 UIViewController

### Demo iOS

![Demo iOS](https://github.com/Digipolitan/parallax-interactive-transition-swift/blob/develop/Screenshots/ios_capture.gif?raw=true "Demo iOS")

### Demo tvOS

![Demo tvOS](https://github.com/Digipolitan/parallax-interactive-transition-swift/blob/develop/Screenshots/tvos_capture.gif?raw=true "Demo tvOS")


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Works with iOS 8+, tested on Xcode 8.2

### Installing

To install the `DGParallaxInteractiveTransition` using **cocoapods**

- Add an entry in your Podfile  

```
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

target 'YourTarget' do
  frameworks
   use_frameworks!

  # Pods for YourTarget
  pod 'DGParallaxInteractiveTransition'
end
```

- Then install the dependency with the `pod install` command.

## Usage

How to perform the transition

```swift
let viewController = UIViewController()
let parallaxTransition = DGParallaxViewControllerTransition()
parallaxTransition.attach(to: viewController)
self.present(viewController, animated: true, completion: nil)
self.parallaxTransition = parallaxTransition // You must retain the parallax transition
```

### Configuration

You can customize the component by enabling few options:

```swift
let viewController = UIViewController()
let parallaxTransition = DGParallaxViewControllerTransition()
parallaxTransition.presentedViewInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
parallaxTransition.overlayColor = .gray
parallaxTransition.maximumOverlayAlpha = 0.5
parallaxTransition.attach(to: viewController)
self.present(viewController, animated: true, completion: nil)
self.parallaxTransition = parallaxTransition // You must retain the parallax transition
```

## Built With

[Fastlane](https://fastlane.tools/)
Fastlane is a tool for iOS, Mac, and Android developers to automate tedious tasks like generating screenshots, dealing with provisioning profiles, and releasing your application.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

DGParallaxInteractiveTransition is licensed under the [BSD 3-Clause license](LICENSE).
