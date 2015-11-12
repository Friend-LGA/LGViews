//
//  LGButton.h
//  LGViews
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Grigory Lutkov <Friend.LGA@gmail.com>
//  (https://github.com/Friend-LGA/LGViews)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface LGButton : UIButton

typedef NS_ENUM(NSUInteger, LGButtonImagePosition)
{
    LGButtonImagePositionLeft   = 0,
    LGButtonImagePositionRight  = 1,
    LGButtonImagePositionTop    = 2,
    LGButtonImagePositionBottom = 3,
    LGButtonImagePositionCenter = 4
};

typedef NS_ENUM(NSUInteger, LGButtonTitlePosition)
{
    LGButtonTitlePositionRight  = 0,
    LGButtonTitlePositionLeft   = 1,
    LGButtonTitlePositionBottom = 2,
    LGButtonTitlePositionTop    = 3,
    LGButtonTitlePositionCenter = 4
};

@property (assign, nonatomic) IBInspectable LGButtonImagePosition imagePosition;
/** Default is 6.f */
@property (assign, nonatomic) IBInspectable CGFloat imageSpacingFromTitle;
@property (assign, nonatomic) IBInspectable CGPoint imageOffset;

@property (assign, nonatomic) IBInspectable LGButtonTitlePosition titlePosition;
/** Default is 6.f */
@property (assign, nonatomic) IBInspectable CGFloat titleSpacingFromImage;
@property (assign, nonatomic) IBInspectable CGPoint titleOffset;

@property (strong, nonatomic, readonly) IBInspectable UIImage *maskImage;

@property (assign, nonatomic, getter=isTitleLabelWidthUnlimited)    IBInspectable BOOL titleLabelWidthUnlimited;
@property (assign, nonatomic, getter=isAdjustsAlphaWhenHighlighted) IBInspectable BOOL adjustsAlphaWhenHighlighted;
@property (assign, nonatomic, getter=isAnimatedStateChanging)       IBInspectable BOOL animatedStateChanging;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

- (void)setMaskAlphaImage:(UIImage *)maskImage;
- (void)setMaskBlackAndWhiteImage:(UIImage *)maskImage;

@end
