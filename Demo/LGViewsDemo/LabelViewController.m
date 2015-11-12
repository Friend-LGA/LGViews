//
//  LabelViewController.m
//  LGViewsDemo
//
//  Created by Grigory Lutkov on 14.03.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "LabelViewController.h"
#import "LGLabel.h"

@interface LabelViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) LGLabel *label1;
@property (strong, nonatomic) LGLabel *label2;
@property (strong, nonatomic) LGLabel *label3;
@property (strong, nonatomic) LGLabel *label4;
@property (strong, nonatomic) LGLabel *label5;
@property (strong, nonatomic) LGLabel *label6;

@end

@implementation LabelViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGLabel";
        
        // -----
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
        
        // -----
        
        UIColor *grayColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.f];
        
        CGFloat inset = 10.f;
        
        _label1 = [LGLabel new];
        _label1.text = @"Label 1";
        _label1.backgroundColor = grayColor;
        _label1.textColor = [UIColor blackColor];
        [_scrollView addSubview:_label1];
        
        _label2 = [LGLabel new];
        _label2.text = @"Label 2";
        _label2.backgroundColor = grayColor;
        _label2.textColor = [UIColor blackColor];
        _label2.contentEdgeInsets = UIEdgeInsetsMake(0.f, inset, 0.f, 0.f);
        [_scrollView addSubview:_label2];
        
        _label3 = [LGLabel new];
        _label3.text = @"Label 3";
        _label3.backgroundColor = grayColor;
        _label3.textColor = [UIColor blackColor];
        _label3.contentEdgeInsets = UIEdgeInsetsMake(0.f, 0.f, 0.f, inset);
        [_scrollView addSubview:_label3];
        
        _label4 = [LGLabel new];
        _label4.text = @"Label 4";
        _label4.backgroundColor = grayColor;
        _label4.textColor = [UIColor blackColor];
        _label4.contentEdgeInsets = UIEdgeInsetsMake(inset, 0.f, 0.f, 0.f);
        [_scrollView addSubview:_label4];
        
        _label5 = [LGLabel new];
        _label5.text = @"Label 5";
        _label5.backgroundColor = grayColor;
        _label5.textColor = [UIColor blackColor];
        _label5.contentEdgeInsets = UIEdgeInsetsMake(0.f, 0.f, inset, 0.f);
        [_scrollView addSubview:_label5];
        
        _label6 = [LGLabel new];
        _label6.text = @"Label 6";
        _label6.backgroundColor = grayColor;
        _label6.textColor = [UIColor blackColor];
        _label6.contentEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
        [_scrollView addSubview:_label6];
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
    
    CGFloat shift = 10.f;
    
    CGSize label1Size = [_label1 sizeThatFits:CGSizeZero];
    _label1.frame = CGRectIntegral(CGRectMake(shift, shift, label1Size.width, label1Size.height));
    
    CGSize label2Size = [_label2 sizeThatFits:CGSizeZero];
    _label2.frame = CGRectIntegral(CGRectMake(shift, _label1.frame.origin.y+_label1.frame.size.height+shift, label2Size.width, label2Size.height));
    
    CGSize label3Size = [_label3 sizeThatFits:CGSizeZero];
    _label3.frame = CGRectIntegral(CGRectMake(shift, _label2.frame.origin.y+_label2.frame.size.height+shift, label3Size.width, label3Size.height));

    CGSize label4Size = [_label4 sizeThatFits:CGSizeZero];
    _label4.frame = CGRectIntegral(CGRectMake(shift, _label3.frame.origin.y+_label3.frame.size.height+shift, label4Size.width, label4Size.height));
    
    CGSize label5Size = [_label5 sizeThatFits:CGSizeZero];
    _label5.frame = CGRectIntegral(CGRectMake(shift, _label4.frame.origin.y+_label4.frame.size.height+shift, label5Size.width, label5Size.height));
    
    CGSize label6Size = [_label6 sizeThatFits:CGSizeZero];
    _label6.frame = CGRectIntegral(CGRectMake(shift, _label5.frame.origin.y+_label5.frame.size.height+shift, label6Size.width, label6Size.height));

    // -----
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _label6.frame.origin.y+_label6.frame.size.height+shift);
}

@end
