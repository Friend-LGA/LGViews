# LGViews

Classes extends abilities of UILabel, UIButton, UITextField and UITextView.
- [LGLabel](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGLabel/LGLabel.h) adds ability to set contentEdgeInsets.
- [LGButton](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGButton/LGButton.h) adds ability to set background color for every control state, to easy choose image position (top, right, bottom, left) and to support for masked (not rectangle) forms.
- [LGTextField](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGTextField/LGTextField.h) adds ability to set edgeInsets for text and images, to set max length of text and to get caret position or caret rect.
- [LGTextView](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGTextView/LGTextView.h) adds ability to dynamic change height of view while typing text, to set max height, number of lines, placeholder and to get caret position or caret rect.

## Preview

<img src="https://raw.githubusercontent.com/Friend-LGA/ReadmeFiles/master/LGViews/Preview.gif" width="230"/>
<img src="https://raw.githubusercontent.com/Friend-LGA/ReadmeFiles/master/LGViews/1.png" width="230"/>
<img src="https://raw.githubusercontent.com/Friend-LGA/ReadmeFiles/master/LGViews/2.png" width="230"/>
<img src="https://raw.githubusercontent.com/Friend-LGA/ReadmeFiles/master/LGViews/3.png" width="230"/>
<img src="https://raw.githubusercontent.com/Friend-LGA/ReadmeFiles/master/LGViews/4.png" width="230"/>

## Installation

### With source code

[Download repository](https://github.com/Friend-LGA/LGViews/archive/master.zip), then add [LGViews directory](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/) to your project.

### With CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the "Get Started" section for more details.

#### Podfile
```
platform :ios, '6.0'
pod 'LGViews', '~> 1.0.0'
```

## Usage

In the source files where you need to use the library, import the header file:

```objective-c
#import "LGViews.h"
```

Or you can use sublibraries separately, depend of your needs: 

```objective-c
#import "LGLabel.h"
#import "LGButton.h"
#import "LGTextField.h"
#import "LGTextView.h"
```

### More

For more details try Xcode [Demo project](https://github.com/Friend-LGA/LGViews/blob/master/Demo) and see files:
- [LGLabel.h](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGLabel/LGLabel.h)
- [LGButton.h](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGButton/LGButton.h)
- [LGTextField.h](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGTextField/LGTextField.h)
- [LGTextView.h](https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGTextView/LGTextView.h)

## License

LGViews is released under the MIT license. See [LICENSE](https://raw.githubusercontent.com/Friend-LGA/LGViews/master/LICENSE) for details.
