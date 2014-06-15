btSimplePopUp-Menu
============================
This is a simple PopUp menu with custom items having images. Its responds to Touch &amp; gives a iOS7 feel.

<IMG SRC ="https://s3-ap-southeast-1.amazonaws.com/problem-arc/SimplePopUP.gif" alt="btSimplePopUpMenu"> </IMG>

This is a simple popup menu for iOS. Inspipred by iOS7 groupping folder (look alike) in the springboard. It is purely based on `UIView`. Includes flats looks, callbacks using blocks & several options for curved corners & flat corners.

### Rounded Corners / FlatCorners / BorderColors
<img src="https://raw.githubusercontent.com/balram3429/btSimplePopUp/master/raw/btSimplePopRED.jpg" alt="btSimpleSideMenu Screenshot" width="705" height="396" />

### PopMenu Color Variance
<img src="https://raw.githubusercontent.com/balram3429/btSimplePopUp/master/raw/btSimplePopBLUE.jpg" alt="btSimpleSideMenu Screenshot" width="705" height="396" />

## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* iOS 7.1 or higher
* ARC

## Demo
Build and run the `btCustomPopUP.xcodeproj` project in Xcode to see `btSimplePopUp` in action.

## Installation
  1. Drag the file `btSimplePopUp.h / btSimplePopUp.m ` to your project folder.
  2. Maken an import statement for the file as `#import "btSimplePopUp.h"` .
  3. Add to your project the `QuartzCore framework` & `Accelerate Framework` & make an import statement for both.

## Initialization 

### Menu Buttons only
 Use the below method to initialize the `btSimplePopUp` menu with just images & callback block operations for each menu.
 
  `-(instancetype)initWithItemImage:(NSArray *)items andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender;`
  
<img src="https://raw.githubusercontent.com/balram3429/btSimplePopUp/master/raw/btScreenRCREDbuttonsonly.png" alt="btSimpleSideMenu Screenshot" width="320" height="568" />
  
  Example :
  
```objective-c
  popUp = [[btSimplePopUP alloc]initWithItemImage:@[
                                                      [UIImage imageNamed:@"alert.png"],
                                                      [UIImage imageNamed:@"attach.png"],
                                                      [UIImage imageNamed:@"cloudUp.png"],
                                                      [UIImage imageNamed:@"facebook.png"],
                                                      [UIImage imageNamed:@"camera.png"],
                                                      [UIImage imageNamed:@"dropBox.png"],
                                                      [UIImage imageNamed:@"mic.png"],
                                                      [UIImage imageNamed:@"wi-Fi.png"]
                                                      ]
                                                      
                                     andActionArray:@[
                                     ^{ [self showAlert]; },
                                     ^{ [self showAlert]; }, 
                                     ^{ [self showAlert]; },
                                     ^{ [self showAlert]; },
                                     ^{ [self showAlert]; },
                                     ^{ [self showAlert]; },
                                     ^{ [self showAlert]; },
                                     ^{ [self showAlert]; }
                                    ]
                                    
                                    addToViewController:self];
                                    [self.view addSubview:popUp];
  
```
##### Don't forget to define your own method to perform some action. The ` [self showAlert];` is a kind of operation (passed in a block), to be performed on click of popup item. #####
 
### Menu Buttons & Text

 Use the below method to initialize the `btSimplePopUp` menu with images, titles & callback block operations for each menu.
 
 `-(instancetype)initWithItemImage:(NSArray *)items andTitles:(NSArray *)titleArray andActionArray:(NSArray *)actionArray addToViewController:(UIViewController*)sender;`
 
   <img src="https://raw.githubusercontent.com/balram3429/btSimplePopUp/master/raw/btScreenRCBlue.png" alt="btSimpleSideMenu Screenshot" width="320" height="568" />
 
 Example: 
 
```objective-c

btSimplePopUP *popUp = [[btSimplePopUP alloc]initWithItemImage:@[
                                                      [UIImage imageNamed:@"alert.png"],
                                                      [UIImage imageNamed:@"attach.png"],
                                                      [UIImage imageNamed:@"cloudUp.png"],
                                                      [UIImage imageNamed:@"facebook.png"],
                                                      [UIImage imageNamed:@"camera.png"],
                                                      [UIImage imageNamed:@"dropBox.png"],
                                                      [UIImage imageNamed:@"mic.png"],
                                                      [UIImage imageNamed:@"wi-Fi.png"]
                                                      ]
                                                      
                                      andActionArray:@[
                                     ^{
                                     
                                     __block UIViewController *temp = [[UIViewController alloc]init];
                                     temp.view.backgroundColor = [UIColor blueColor];
                                     [self.navigationController presentViewController:temp
                                                animated:YES
                                              completion:^{
                                                  [temp dismissViewControllerAnimated:YES completion:nil];
                                              }];
    },
    ^{ [self showAlert]; }, 
    ^{ [self showAlert]; },
    ^{ [self showAlert]; },
    ^{ [self showAlert]; },
    ^{ [self showAlert]; },
    ^{ [self showAlert]; },
    ^{ [self showAlert]; }
    ]
    
    addToViewController:self];
    
    [self.view addSubview:popUp];
```
##### Don't forget to define your own method to perform some action. The ` [self showAlert];` is a kind of operation (passed in a block), to be performed on click of popup item. #####


## Properties - Color / Border

 PopUPStyle
 `BTPopUpStyleDefault, BTPopUpStyleMinimalRoundedCorner`

```Objective-c
    [popUp setPopUpStyle:BTPopUpStyleDefault];
```
 PopUpBorderStyle
 `BTPopUpBorderStyleDefaultNone, BTPopUpBorderStyleLightContent, BTPopUpBorderStyleDarkContent`

```Objective-c
    [popUp setPopUpBorderStyle:BTPopUpBorderStyleDefaultNone];
```

 PopUpBackgroundColor Custom Color
```Objective-c
    [popUp setPopUpBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.1 alpha:0.7]];
```
    
## Contact

- tiwari.balram@gmail.com
- <A HREF = "http://stackoverflow.com/users/1307844/balram-tiwari"> @stackOverflow </a>
- <a href = "https://itunes.apple.com/us/artist/balram-tiwari/id693049567"> @Apps Store </a>

## License

btSimplePopUp is available under the MIT license.

Copyright © 2014 Balram Tiwari.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
