//
//  LGTextField.m
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

#import "LGTextField.h"
#import "LGTextFieldDelegateObject.h"

@interface LGTextField ()

@property (strong, nonatomic) LGTextFieldDelegateObject *delegateObject;

@end

@implementation LGTextField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _delegateObject = [LGTextFieldDelegateObject new];
    [super setDelegate:_delegateObject];
}

#pragma mark - Dealloc

- (void)dealloc
{
    self.delegateObject = nil;
    self.delegateLG = nil;
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.leftView)
    {
        CGFloat heightDif = self.frame.size.height-_leftViewEdgeInsets.top-_leftViewEdgeInsets.bottom;
        
        self.leftView.center = CGPointMake(self.leftView.center.x+_leftViewEdgeInsets.left, _leftViewEdgeInsets.top+heightDif/2);
    }
    
    if (self.rightView)
    {
        CGFloat heightDif = self.frame.size.height-_rightViewEdgeInsets.top-_rightViewEdgeInsets.bottom;

        self.rightView.center = CGPointMake(self.rightView.center.x-_rightViewEdgeInsets.right, _rightViewEdgeInsets.top+heightDif/2);
    }
}

#pragma mark -

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x += _textEdgeInsets.left;
    bounds.origin.y += _textEdgeInsets.top;
    bounds.size.width -= (_textEdgeInsets.left + _textEdgeInsets.right);
    bounds.size.height -= (_textEdgeInsets.top + _textEdgeInsets.bottom);
    
    if (self.leftView)
    {
        bounds.origin.x += (self.leftView.frame.size.width+_leftViewEdgeInsets.left+_leftViewEdgeInsets.right);
        bounds.size.width -= (self.leftView.frame.size.width+_leftViewEdgeInsets.left+_leftViewEdgeInsets.right);
    }
    if (self.rightView) bounds.size.width -= (self.rightView.frame.size.width+_rightViewEdgeInsets.left+_rightViewEdgeInsets.right);
    
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x += _textEdgeInsets.left;
    bounds.origin.y += _textEdgeInsets.top;
    bounds.size.width -= (_textEdgeInsets.left + _textEdgeInsets.right);
    bounds.size.height -= (_textEdgeInsets.top + _textEdgeInsets.bottom);
    
    if (self.leftView)
    {
        bounds.origin.x += (self.leftView.frame.size.width+_leftViewEdgeInsets.left+_leftViewEdgeInsets.right);
        bounds.size.width -= (self.leftView.frame.size.width+_leftViewEdgeInsets.left+_leftViewEdgeInsets.right);
    }
    if (self.rightView) bounds.size.width -= (self.rightView.frame.size.width+_rightViewEdgeInsets.left+_rightViewEdgeInsets.right);
    
    return bounds;
}

#pragma mark - LGTextField Delegate

- (void)setDelegateLG:(id<LGTextFieldDelegate>)delegateLG
{
    _delegateObject.delegateLG = delegateLG;
}

- (id<LGTextFieldDelegate>)delegateLG
{
    return _delegateObject.delegateLG;
}

#pragma mark -

- (CGRect)caretRect
{
    return [self caretRectForPosition:self.selectedTextRange.start];
}

- (CGPoint)caretPosition
{
    return [self caretRectForPosition:self.selectedTextRange.start].origin;
}

@end
