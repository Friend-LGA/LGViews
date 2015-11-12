//
//  TextViewViewController.m
//  LGViewsDemo
//
//  Created by Grigory Lutkov on 24.03.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "TextViewViewController.h"
#import "LGTextView.h"

@interface TextViewViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) LGTextView *textView;

@end

@implementation TextViewViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGTextView";
        
        // -----
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)];
        gesture.delegate = self;
        [_scrollView addGestureRecognizer:gesture];
        
        // -----
        
        UIColor *grayColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.f];
        
        _textView = [LGTextView new];
        _textView.placeholder = @"LGTextView placeholder";
        _textView.placeholderColor = [UIColor grayColor];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = grayColor;
        _textView.font = [UIFont systemFontOfSize:16.f];
        _textView.numberOfLinesMin = 1;
        _textView.numberOfLinesMax = 5;
        _textView.trimmingWhitespaceAndNewline = YES;
        [_scrollView addSubview:_textView];
        
        __weak typeof(self) wself = self;
        
        _textView.resizingHandler = ^(LGTextView *textView, CGSize sizeNew)
        {
            if (wself)
            {
                __strong typeof(wself) self = wself;
                
                CGFloat shift = 10.f;
                
                self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.textView.frame.origin.y+sizeNew.height+shift);
                
                [self.scrollView scrollRectToVisible:self.textView.frame animated:NO];
            }
        };
        
        // -----
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideAction:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
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
    
    CGFloat topInset = 0.f;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        topInset += (self.navigationController.navigationBarHidden ? 0.f : MIN(self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height));
        topInset += ([UIApplication sharedApplication].statusBarHidden ? 0.f : MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height));
    }
    
    CGSize textViewSize = [_textView sizeThatFits:CGSizeMake(self.view.frame.size.width-shift*2, 0.f)];
    _textView.frame = CGRectIntegral(CGRectMake(shift, _scrollView.frame.size.height-topInset-shift-textViewSize.height, self.view.frame.size.width-shift*2, textViewSize.height));

    // -----
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _textView.frame.origin.y+_textView.frame.size.height+shift);
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
        [_scrollView scrollRectToVisible:_textView.frame animated:NO];

    [UIView commitAnimations];
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
