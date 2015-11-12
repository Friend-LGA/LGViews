//
//  ButtonViewController.m
//  LGViewsDemo
//
//  Created by Grigory Lutkov on 14.03.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "ButtonViewController.h"
#import "LGButton.h"

@interface ButtonViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) LGButton *button1;
@property (strong, nonatomic) LGButton *button2;
@property (strong, nonatomic) LGButton *button3;

@property (strong, nonatomic) UIView *separatorView1;

@property (strong, nonatomic) LGButton *button4;
@property (strong, nonatomic) LGButton *button5;
@property (strong, nonatomic) LGButton *button6;
@property (strong, nonatomic) LGButton *button7;
@property (strong, nonatomic) LGButton *button8;

@property (strong, nonatomic) UIView *separatorView2;

@property (strong, nonatomic) LGButton *button9;
@property (strong, nonatomic) LGButton *button10;
@property (strong, nonatomic) LGButton *button11;
@property (strong, nonatomic) LGButton *button12;

@end

@implementation ButtonViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGButton";
        
        // -----
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
        
        // -----
        
        UIColor *blueColor = [UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f];
        UIColor *grayColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.f];
        
        CGFloat inset = 5.f;
        
        _button1 = [LGButton new];
        _button1.backgroundColor = grayColor;
        _button1.adjustsAlphaWhenHighlighted = YES;
        [_button1 setTitle:@"Button 1" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button1.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button1.titleEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        [_scrollView addSubview:_button1];
        
        _button2 = [LGButton new];
        _button2.backgroundColor = grayColor;
        _button2.adjustsAlphaWhenHighlighted = YES;
        [_button2 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button2.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button2.imageEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        [_scrollView addSubview:_button2];
        
        _button3 = [LGButton new];
        _button3.backgroundColor = grayColor;
        _button3.adjustsAlphaWhenHighlighted = YES;
        [_button3 setTitle:@"Button 3" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button3.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button3.titleEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button3.imageEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button3.imageSpacingFromTitle = inset; // or _button3.titleSpacingFromImage = inset;
        _button3.imageOffset = CGPointMake(-inset, 0.f);
        _button3.titleOffset = CGPointMake(inset, 0.f);
        [_scrollView addSubview:_button3];
        
        _separatorView1 = [UIView new];
        _separatorView1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [_scrollView addSubview:_separatorView1];
        
        // -----
        
        _button4 = [LGButton new];
        _button4.animatedStateChanging = YES;
        _button4.adjustsImageWhenHighlighted = NO;
        [_button4 setBackgroundColor:grayColor forState:UIControlStateNormal];
        [_button4 setBackgroundColor:blueColor forState:UIControlStateHighlighted];
        [_button4 setTitle:@"Button 4" forState:UIControlStateNormal];
        [_button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button4 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button4.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button4.imagePosition = LGButtonImagePositionLeft; // or _button4.titlePosition = LGButtonTitlePositionRight;
        [_scrollView addSubview:_button4];
        
        _button5 = [LGButton new];
        _button5.animatedStateChanging = YES;
        _button5.adjustsImageWhenHighlighted = NO;
        [_button5 setBackgroundColor:grayColor forState:UIControlStateNormal];
        [_button5 setBackgroundColor:blueColor forState:UIControlStateHighlighted];
        [_button5 setTitle:@"Button 5" forState:UIControlStateNormal];
        [_button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button5 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button5.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button5.imagePosition = LGButtonImagePositionRight; // or _button5.titlePosition = LGButtonTitlePositionLeft;
        [_scrollView addSubview:_button5];
        
        _button6 = [LGButton new];
        _button6.animatedStateChanging = YES;
        _button6.adjustsImageWhenHighlighted = NO;
        [_button6 setBackgroundColor:grayColor forState:UIControlStateNormal];
        [_button6 setBackgroundColor:blueColor forState:UIControlStateHighlighted];
        [_button6 setTitle:@"Button 6" forState:UIControlStateNormal];
        [_button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button6 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button6.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button6.imagePosition = LGButtonImagePositionTop; // or _button6.titlePosition = LGButtonTitlePositionBottom;
        [_scrollView addSubview:_button6];
        
        _button7 = [LGButton new];
        _button7.animatedStateChanging = YES;
        _button7.adjustsImageWhenHighlighted = NO;
        [_button7 setBackgroundColor:grayColor forState:UIControlStateNormal];
        [_button7 setBackgroundColor:blueColor forState:UIControlStateHighlighted];
        [_button7 setTitle:@"Button 7" forState:UIControlStateNormal];
        [_button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button7 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button7.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button7.imagePosition = LGButtonImagePositionBottom; // or _button7.titlePosition = LGButtonTitlePositionTop;
        [_scrollView addSubview:_button7];
        
        _button8 = [LGButton new];
        _button8.animatedStateChanging = YES;
        _button8.adjustsImageWhenHighlighted = NO;
        [_button8 setBackgroundColor:grayColor forState:UIControlStateNormal];
        [_button8 setBackgroundColor:blueColor forState:UIControlStateHighlighted];
        [_button8 setTitle:@"Button 8" forState:UIControlStateNormal];
        [_button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button8 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button8.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button8.imagePosition = LGButtonImagePositionCenter; // or _button8.titlePosition = LGButtonTitlePositionCenter;
        [_scrollView addSubview:_button8];
        
        _separatorView2 = [UIView new];
        _separatorView2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [_scrollView addSubview:_separatorView2];
        
        // -----
        
        _button9 = [LGButton new];
        _button9.backgroundColor = grayColor;
        [_button9 setTitle:@"Button 9" forState:UIControlStateNormal];
        [_button9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button9 setTitleColor:blueColor forState:UIControlStateHighlighted];
        [_button9 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button9.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button9.imagePosition = LGButtonImagePositionLeft; // or _button9.titlePosition = LGButtonTitlePositionRight;
        _button9.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [_scrollView addSubview:_button9];
        
        _button10 = [LGButton new];
        _button10.backgroundColor = grayColor;
        [_button10 setTitle:@"Button 10" forState:UIControlStateNormal];
        [_button10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button10 setTitleColor:blueColor forState:UIControlStateHighlighted];
        [_button10 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button10.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button10.imagePosition = LGButtonImagePositionLeft; // or _button10.titlePosition = LGButtonTitlePositionRight;
        _button10.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [_scrollView addSubview:_button10];
        
        _button11 = [LGButton new];
        _button11.backgroundColor = grayColor;
        [_button11 setTitle:@"Button 11, Button 11" forState:UIControlStateNormal];
        [_button11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button11 setTitleColor:blueColor forState:UIControlStateHighlighted];
        [_button11 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button11.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button11.imagePosition = LGButtonImagePositionTop; // or _button11.titlePosition = LGButtonTitlePositionBottom;
        _button11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_scrollView addSubview:_button11];
        
        _button12 = [LGButton new];
        _button12.backgroundColor = grayColor;
        [_button12 setTitle:@"Button 12, Button12" forState:UIControlStateNormal];
        [_button12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button12 setTitleColor:blueColor forState:UIControlStateHighlighted];
        [_button12 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _button12.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        _button12.imagePosition = LGButtonImagePositionTop; // or _button12.titlePosition = LGButtonTitlePositionBottom;
        _button12.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_scrollView addSubview:_button12];
    }
    return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

#pragma mark - Appearing

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _scrollView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    
    // -----
    
    CGFloat shift = 5.f;
    
    CGSize button1Size = [_button1 sizeThatFits:CGSizeZero];
    _button1.frame = CGRectIntegral(CGRectMake(shift, shift, button1Size.width, button1Size.height));
    
    CGSize button2Size = [_button2 sizeThatFits:CGSizeZero];
    _button2.frame = CGRectIntegral(CGRectMake(shift, _button1.frame.origin.y+_button1.frame.size.height+shift, button2Size.width, button2Size.height));
    
    CGSize button3Size = [_button3 sizeThatFits:CGSizeZero];
    _button3.frame = CGRectIntegral(CGRectMake(shift, _button2.frame.origin.y+_button2.frame.size.height+shift, button3Size.width, button3Size.height));
    
    // -----
    
    _separatorView1.frame = CGRectIntegral(CGRectMake(shift, _button3.frame.origin.y+_button3.frame.size.height+shift, self.view.frame.size.width-shift*2, 1.f));
    
    // -----
    
    CGSize button4Size = [_button4 sizeThatFits:CGSizeZero];
    _button4.frame = CGRectIntegral(CGRectMake(shift, _separatorView1.frame.origin.y+_separatorView1.frame.size.height+shift, button4Size.width, button4Size.height));
    
    CGSize button5Size = [_button5 sizeThatFits:CGSizeZero];
    _button5.frame = CGRectIntegral(CGRectMake(shift, _button4.frame.origin.y+_button4.frame.size.height+shift, button5Size.width, button5Size.height));
    
    CGSize button6Size = [_button6 sizeThatFits:CGSizeZero];
    _button6.frame = CGRectIntegral(CGRectMake(shift, _button5.frame.origin.y+_button5.frame.size.height+shift, button6Size.width, button6Size.height));
    
    CGSize button7Size = [_button7 sizeThatFits:CGSizeZero];
    _button7.frame = CGRectIntegral(CGRectMake(shift, _button6.frame.origin.y+_button6.frame.size.height+shift, button7Size.width, button7Size.height));
    
    CGSize button8Size = [_button8 sizeThatFits:CGSizeZero];
    _button8.frame = CGRectIntegral(CGRectMake(shift, _button7.frame.origin.y+_button7.frame.size.height+shift, button8Size.width, button8Size.height));
    
    // -----
    
    _separatorView2.frame = CGRectIntegral(CGRectMake(shift, _button8.frame.origin.y+_button8.frame.size.height+shift, self.view.frame.size.width-shift*2, 1.f));
    
    // -----
    
    CGSize button9Size = [_button9 sizeThatFits:CGSizeZero];
    _button9.frame = CGRectIntegral(CGRectMake(shift, _separatorView2.frame.origin.y+_separatorView2.frame.size.height+shift, button9Size.width, button9Size.height));
    
    CGSize button10Size = [_button10 sizeThatFits:CGSizeZero];
    _button10.frame = CGRectIntegral(CGRectMake(shift, _button9.frame.origin.y+_button9.frame.size.height+shift, button10Size.width, button10Size.height));
    
    CGSize button11Size = [_button11 sizeThatFits:CGSizeZero];
    _button11.frame = CGRectIntegral(CGRectMake(shift, _button10.frame.origin.y+_button10.frame.size.height+shift, button11Size.width, button11Size.height));
    
    CGSize button12Size = [_button12 sizeThatFits:CGSizeZero];
    _button12.frame = CGRectIntegral(CGRectMake(shift, _button11.frame.origin.y+_button11.frame.size.height+shift, button12Size.width, button12Size.height));
    
    // -----
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _button12.frame.origin.y+_button12.frame.size.height+shift);
}

@end
