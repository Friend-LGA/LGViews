//
//  TextFieldViewController.m
//  LGViewsDemo
//
//  Created by Grigory Lutkov on 14.03.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "TextFieldViewController.h"
#import "LGTextField.h"

@interface TextFieldViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) LGTextField *textField1;
@property (strong, nonatomic) LGTextField *textField2;
@property (strong, nonatomic) LGTextField *textField3;
@property (strong, nonatomic) LGTextField *textField4;

@end

@implementation TextFieldViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGTextField";
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
        gesture.delegate = self;
        [_scrollView addGestureRecognizer:gesture];
        
        // -----

        UIColor *grayColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.f];
        
        CGFloat inset = 10.f;
        
        _textField1 = [LGTextField new];
        _textField1.placeholder = @"TextField 1 placeholder";
        _textField1.backgroundColor = grayColor;
        _textField1.leftView = [self makeImageView];
        _textField1.rightView = [self makeImageView];
        _textField1.leftViewMode = UITextFieldViewModeAlways;
        _textField1.rightViewMode = UITextFieldViewModeAlways;
        _textField1.returnKeyType = UIReturnKeyDone;
        _textField1.trimmingWhitespaceAndNewline = YES;
        _textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_scrollView addSubview:_textField1];
        
        _textField2 = [LGTextField new];
        _textField2.placeholder = @"TextField 2 placeholder";
        _textField2.backgroundColor = grayColor;
        _textField2.leftView = [self makeImageView];
        _textField2.rightView = [self makeImageView];
        _textField2.leftViewMode = UITextFieldViewModeAlways;
        _textField2.rightViewMode = UITextFieldViewModeAlways;
        _textField2.textEdgeInsets = UIEdgeInsetsMake(0.f, inset, inset, inset);
        _textField2.leftViewEdgeInsets = UIEdgeInsetsMake(0.f, inset, inset, 0.f);
        _textField2.rightViewEdgeInsets = UIEdgeInsetsMake(0.f, 0.f, inset, inset);
        _textField2.returnKeyType = UIReturnKeyDone;
        _textField2.trimmingWhitespaceAndNewline = YES;
        _textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_scrollView addSubview:_textField2];
        
        _textField3 = [LGTextField new];
        _textField3.placeholder = @"TextField 3 placeholder";
        _textField3.backgroundColor = grayColor;
        _textField3.leftView = [self makeImageView];
        _textField3.rightView = [self makeImageView];
        _textField3.leftViewMode = UITextFieldViewModeAlways;
        _textField3.rightViewMode = UITextFieldViewModeAlways;
        _textField3.textEdgeInsets = UIEdgeInsetsMake(inset, inset, 0.f, inset);
        _textField3.leftViewEdgeInsets = UIEdgeInsetsMake(inset, inset, 0.f, 0.f);
        _textField3.rightViewEdgeInsets = UIEdgeInsetsMake(inset, 0.f, 0.f, inset);
        _textField3.returnKeyType = UIReturnKeyDone;
        _textField3.trimmingWhitespaceAndNewline = YES;
        _textField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_scrollView addSubview:_textField3];
        
        _textField4 = [LGTextField new];
        _textField4.placeholder = @"TextField 4 placeholder";
        _textField4.backgroundColor = grayColor;
        _textField4.leftView = [self makeImageView];
        _textField4.rightView = [self makeImageView];
        _textField4.leftViewMode = UITextFieldViewModeAlways;
        _textField4.rightViewMode = UITextFieldViewModeAlways;
        _textField4.textEdgeInsets = UIEdgeInsetsMake(0.f, inset, 0.f, inset);
        _textField4.leftViewEdgeInsets = UIEdgeInsetsMake(0.f, inset, 0.f, 0.f);
        _textField4.rightViewEdgeInsets = UIEdgeInsetsMake(0.f, 0.f, 0.f, inset);
        _textField4.returnKeyType = UIReturnKeyDone;
        _textField4.trimmingWhitespaceAndNewline = YES;
        _textField4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_scrollView addSubview:_textField4];
        
        // -----
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideAction:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (UIImageView *)makeImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
    
    return imageView;
}

#pragma mark - Dealloc

- (void)dealloc
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Appearing

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _scrollView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    
    // -----
    
    CGFloat shift = 10.f;
    CGFloat height = 44.f;
    
    CGFloat topInset = 0.f;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        topInset += (self.navigationController.navigationBarHidden ? 0.f : MIN(self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height));
        topInset += ([UIApplication sharedApplication].statusBarHidden ? 0.f : MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height));
    }
    
    _textField1.frame = CGRectIntegral(CGRectMake(shift, shift, self.view.frame.size.width-shift*2, height));
    
    _textField2.frame = CGRectIntegral(CGRectMake(shift, _textField1.frame.origin.y+_textField1.frame.size.height+shift, self.view.frame.size.width-shift*2, height));
    
    _textField3.frame = CGRectIntegral(CGRectMake(shift, _textField2.frame.origin.y+_textField2.frame.size.height+shift, self.view.frame.size.width-shift*2, height));

    _textField4.frame = CGRectIntegral(CGRectMake(shift, _scrollView.frame.size.height-topInset-shift-height, self.view.frame.size.width-shift*2, height));
    
    // -----
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _textField4.frame.origin.y+_textField4.frame.size.height+shift);
}

#pragma mark - Keyboard

- (void)keyboardShowHideAction:(NSNotification *)notification
{
    CGFloat keyboardHeight = (notification.userInfo[UIKeyboardFrameEndUserInfoKey] ? [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height : 0.f);

    if (!keyboardHeight) return;

    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int animationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];

    CGFloat bottomInset = (notification.name == UIKeyboardWillShowNotification ? keyboardHeight : 0.f);

    _scrollView.contentInset = UIEdgeInsetsMake(_scrollView.contentInset.top, 0.f, bottomInset, 0.f);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(_scrollView.contentInset.top, 0.f, bottomInset, 0.f);

    if (notification.name == UIKeyboardWillShowNotification)
        [_scrollView scrollRectToVisible:[self firstResponder].frame animated:NO];

    [UIView commitAnimations];
}

- (UIView *)firstResponder
{
    UIView *firstResponderView = nil;

    for (UIView *subview in _scrollView.subviews)
    {
        if (subview.canBecomeFirstResponder && subview.isFirstResponder)
            firstResponderView = subview;

        if (firstResponderView) break;
    }

    return firstResponderView;
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![touch.view isKindOfClass:[UIControl class]];
}

#pragma mark -

- (void)gestureAction
{
    [self.view endEditing:YES];
}

@end
