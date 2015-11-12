//
//  LGTextView.h
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

@class LGTextView;

@protocol LGTextViewDelegate <NSObject>

@optional

- (BOOL)textViewShouldBeginEditing:(LGTextView *)textView;
- (BOOL)textViewShouldEndEditing:(LGTextView *)textView;

- (void)textViewDidBeginEditing:(LGTextView *)textView;
- (void)textViewDidEndEditing:(LGTextView *)textView;

- (BOOL)textView:(LGTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(LGTextView *)textView;

- (void)textViewDidChangeSelection:(LGTextView *)textView;

- (BOOL)textView:(LGTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
- (BOOL)textView:(LGTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);

- (void)textViewWillResize:(LGTextView *)textView toSize:(CGSize)sizeNew;
- (void)textViewResizing:(LGTextView *)textView toSize:(CGSize)sizeNew;
- (void)textViewDidResize:(LGTextView *)textView;

@end

IB_DESIGNABLE

@interface LGTextView : UITextView

@property (assign, nonatomic) id<LGTextViewDelegate> delegateLG;

@property (strong, nonatomic) IBInspectable NSString *placeholder;
@property (strong, nonatomic) IBInspectable UIColor  *placeholderColor;

@property (assign, nonatomic) IBInspectable NSUInteger numberOfLinesMin;
@property (assign, nonatomic) IBInspectable NSUInteger numberOfLinesMax;
@property (assign, nonatomic) IBInspectable CGFloat    heightMin;
@property (assign, nonatomic) IBInspectable CGFloat    heightMax;

@property (assign, nonatomic) IBInspectable NSUInteger lengthMax;

@property (assign, nonatomic, getter=isAnimatedResize) IBInspectable BOOL animatedResize;

@property (assign, nonatomic, getter=isTrimmingWhitespaceAndNewline) IBInspectable BOOL trimmingWhitespaceAndNewline;

/** Do not forget about weak referens to self */
@property (strong, nonatomic) void (^willResizeHandler)(LGTextView *textView, CGSize sizeNew);
/** Do not forget about weak referens to self */
@property (strong, nonatomic) void (^resizingHandler)(LGTextView *textView, CGSize sizeNew);
/** Do not forget about weak referens to self */
@property (strong, nonatomic) void (^didResizeHandler)(LGTextView *textView);

- (NSUInteger)numberOfLines;
- (void)resize;

- (CGRect)caretRect;
- (CGPoint)caretPosition;

/** Delegate not available, use delegateLG instead */
- (id<UITextViewDelegate>)delegate __attribute__((unavailable("use delegateLG instead")));
/** Delegate not available, use setDelegateLG instead */
- (void)setDelegate:(id<UITextViewDelegate>)delegate __attribute__((unavailable("use setDelegateLG instead")));

@end
