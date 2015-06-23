//
//  LGTextViewDelegateObject.m
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

#import "LGTextViewDelegateObject.h"

@interface LGTextView (protected)

- (void)placeholderShow;
- (void)placeholderHide;

@end

#pragma mark -

@implementation LGTextViewDelegateObject

#pragma mark - Dealloc

- (void)dealloc
{
    self.delegateLG = nil;
}

#pragma mark - UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(LGTextView *)textView
{
    if (textView.placeholder && !textView.text.length)
        [textView placeholderHide];
    
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewShouldBeginEditing:)])
        delegateResult = [_delegateLG textViewShouldBeginEditing:textView];
    
    return delegateResult;
}

- (BOOL)textViewShouldEndEditing:(LGTextView *)textView
{
    if (textView.isTrimmingWhitespaceAndNewline)
    {
        textView.text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [textView resize];
    }
    
    if (textView.placeholder && !textView.text.length)
        [textView placeholderShow];
    
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewShouldEndEditing:)])
        delegateResult = [_delegateLG textViewShouldEndEditing:textView];
    
    return delegateResult;
}

- (void)textViewDidBeginEditing:(LGTextView *)textView
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewDidBeginEditing:)])
        [_delegateLG textViewDidBeginEditing:textView];
}

- (void)textViewDidEndEditing:(LGTextView *)textView
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewDidEndEditing:)])
        [_delegateLG textViewDidEndEditing:textView];
}

- (BOOL)textView:(LGTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSUInteger lengthOld = textView.text.length;
    NSUInteger lengthReplacement = text.length;
    NSUInteger lengthRange = range.length;
    
    NSUInteger lengthNew = lengthOld - lengthRange + lengthReplacement;
    
    if ([text isEqualToString:@"\n"])
    {
        // If done button pressed hide keyboard
        if (textView.returnKeyType == UIReturnKeyDone)
            [textView resignFirstResponder];
        
        if (textView.returnKeyType != UIReturnKeyDefault)
            return NO;
    }
    
    if (!textView.hasText && [text isEqualToString:@""]) return NO;
    
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        delegateResult = [_delegateLG textView:textView shouldChangeTextInRange:range replacementText:text];
    
    return (delegateResult && (lengthNew <= textView.lengthMax || textView.lengthMax == 0));
}

- (void)textViewDidChange:(LGTextView *)textView
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewDidChange:)])
        [_delegateLG textViewDidChange:textView];
    
    [textView resize];
}

- (BOOL)textView:(LGTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)])
        delegateResult = [_delegateLG textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    
    return delegateResult;
}

- (BOOL)textView:(LGTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    BOOL delegateResult = YES;
    
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)])
        delegateResult = [_delegateLG textView:textView shouldInteractWithURL:URL inRange:characterRange];
    
    return delegateResult;
}

- (void)textViewDidChangeSelection:(LGTextView *)textView
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewDidChangeSelection:)])
        [_delegateLG textViewDidChangeSelection:textView];
}

#pragma mark - LGTextView Delegate

- (void)textViewWillResize:(LGTextView *)textView toSize:(CGSize)sizeNew
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewWillResize:toSize:)])
        [_delegateLG textViewWillResize:textView toSize:sizeNew];
    
    if (textView.willResizeHandler) textView.willResizeHandler(textView, sizeNew);
}

- (void)textViewResizing:(LGTextView *)textView toSize:(CGSize)sizeNew
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewResizing:toSize:)])
        [_delegateLG textViewResizing:textView toSize:sizeNew];
    
    if (textView.resizingHandler) textView.resizingHandler(textView, sizeNew);
}

- (void)textViewDidResize:(LGTextView *)textView
{
    if (_delegateLG && [_delegateLG respondsToSelector:@selector(textViewDidResize:)])
        [_delegateLG textViewDidResize:textView];
    
    if (textView.didResizeHandler) textView.didResizeHandler(textView);
}

@end
