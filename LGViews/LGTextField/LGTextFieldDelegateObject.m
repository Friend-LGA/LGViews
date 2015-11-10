//
//  LGTextFieldDelegateObject.m
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

#import "LGTextFieldDelegateObject.h"

@implementation LGTextFieldDelegateObject

#pragma mark - Dealloc

- (void)dealloc
{
    _delegateLG = nil;
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(LGTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger lengthOld = textField.text.length;
    NSUInteger lengthReplacement = string.length;
    NSUInteger lengthRange = range.length;
    
    NSUInteger lengthNew = lengthOld - lengthRange + lengthReplacement;
    
    if ([string isEqualToString:@"\n"]) return NO;
    
    if (!textField.hasText && [string isEqualToString:@""]) return NO;
    
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        delegateResult = [_delegateLG textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    return (delegateResult && (lengthNew <= textField.lengthMax || textField.lengthMax == 0));
}

- (BOOL)textFieldShouldBeginEditing:(LGTextField *)textField
{
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        delegateResult = [_delegateLG textFieldShouldBeginEditing:textField];
    
    return delegateResult;
}

- (BOOL)textFieldShouldEndEditing:(LGTextField *)textField
{
    if (textField.isTrimmingWhitespaceAndNewline)
        textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textFieldShouldEndEditing:)])
        delegateResult = [_delegateLG textFieldShouldEndEditing:textField];
    
    return delegateResult;
}

- (BOOL)textFieldShouldReturn:(LGTextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone)
        [textField resignFirstResponder];
    
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textFieldShouldReturn:)])
        delegateResult = [_delegateLG textFieldShouldReturn:textField];
    
    return delegateResult;
}

- (BOOL)textFieldShouldClear:(LGTextField *)textField
{
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textFieldShouldClear:)])
        delegateResult = [_delegateLG textFieldShouldClear:textField];
    
    return delegateResult;
}

- (void)textFieldDidBeginEditing:(LGTextField *)textField
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [_delegateLG textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(LGTextField *)textField
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textFieldDidEndEditing:)])
        [_delegateLG textFieldDidEndEditing:textField];
}

@end
