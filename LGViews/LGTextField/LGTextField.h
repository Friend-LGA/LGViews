//
//  LGTextField.h
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

@class LGTextField;

@protocol LGTextFieldDelegate <NSObject>

@optional

- (BOOL)textFieldShouldBeginEditing:(LGTextField *)textField; // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(LGTextField *)textField;    // became first responder
- (BOOL)textFieldShouldEndEditing:(LGTextField *)textField;   // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(LGTextField *)textField;      // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(LGTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; // return NO to not change text

- (BOOL)textFieldShouldClear:(LGTextField *)textField;        // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(LGTextField *)textField;       // called when 'return' key pressed. return NO to ignore.

@end

IB_DESIGNABLE

@interface LGTextField : UITextField

@property (assign, nonatomic) IBOutlet id<LGTextFieldDelegate> delegateLG;

@property (assign, nonatomic) IBInspectable NSUInteger lengthMax;

@property (assign, nonatomic) IBInspectable UIEdgeInsets textEdgeInsets;
@property (assign, nonatomic) IBInspectable UIEdgeInsets leftViewEdgeInsets;
@property (assign, nonatomic) IBInspectable UIEdgeInsets rightViewEdgeInsets;

@property (assign, nonatomic, getter=isTrimmingWhitespaceAndNewline) IBInspectable BOOL trimmingWhitespaceAndNewline;

- (CGRect)caretRect;
- (CGPoint)caretPosition;

/** Delegate not available, use delegateLG instead */
- (id<UITextFieldDelegate>)delegate __attribute__((unavailable("use delegateLG instead")));
/** Delegate not available, use setDelegateLG instead */
- (void)setDelegate:(id<UITextFieldDelegate>)delegate __attribute__((unavailable("use setDelegateLG instead")));

@end
