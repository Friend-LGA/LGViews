//
//  ViewController.m
//  LGRadioButtonsViewDemo
//
//  Created by Grigory Lutkov on 27.03.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "RadioButtonsViewController.h"
#import "LGRadioButtonsView.h"

@interface RadioButtonsViewController ()

@property (strong, nonatomic) UIScrollView          *scrollView;
@property (strong, nonatomic) LGRadioButtonsView    *radioButtons1;
@property (strong, nonatomic) LGRadioButtonsView    *radioButtons2;
@property (strong, nonatomic) LGRadioButtonsView    *radioButtons3;

@end

@implementation RadioButtonsViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGRadioButtonsView";
        
        // -----
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_scrollView];
        
        UIImage *circleImageNormal = [UIImage imageNamed:@"Circle_Normal"];
        
        UIImage *circleImageHighlighted = [UIImage imageNamed:@"Circle_Selected"];
        
        _radioButtons1 = [[LGRadioButtonsView alloc] initWithNumberOfButtons:3
                                                     actionHandler:^(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index)
                            {
                                NSLog(@"%@, %i", title, (int)index);
                            }];
        _radioButtons1.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.f];
        _radioButtons1.contentEdgeInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        [_radioButtons1 setButtonsTitles:@[@"Title 1 Line 1", @"Title 2 Line 1\nTitle 2 Line 2", @"Title 3 Line 1\nTitle 3 Line 2\nTitle 3 Line 3"] forState:UIControlStateNormal];
        [_radioButtons1 setButtonsTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radioButtons1 setButtonsImage:circleImageNormal forState:UIControlStateNormal];
        [_radioButtons1 setButtonsImage:circleImageHighlighted forState:UIControlStateHighlighted];
        [_radioButtons1 setButtonsImage:circleImageHighlighted forState:UIControlStateSelected];
        [_radioButtons1 setButtonsAdjustsImageWhenHighlighted:NO];
        [_radioButtons1 setButtonsContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_scrollView addSubview:_radioButtons1];
        
        // -----
        
        _radioButtons2 = [[LGRadioButtonsView alloc] initWithNumberOfButtons:3
                                                               actionHandler:^(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index)
                          {
                              NSLog(@"%@, %i", title, (int)index);
                          }];
        _radioButtons2.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.f];
        [_radioButtons2 setButtonsTitles:@[@"Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1 Title 1",
                                           @"Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2 Title 2",
                                           @"Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3 Title 3"]
                                forState:UIControlStateNormal];
        [_radioButtons2 setButtonsTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radioButtons2 setButtonsImage:circleImageNormal forState:UIControlStateNormal];
        [_radioButtons2 setButtonsImage:circleImageHighlighted forState:UIControlStateHighlighted];
        [_radioButtons2 setButtonsImage:circleImageHighlighted forState:UIControlStateSelected];
        [_radioButtons2 setButtonsAdjustsImageWhenHighlighted:NO];
        [_scrollView addSubview:_radioButtons2];
        
        // -----
        
        _radioButtons3 = [[LGRadioButtonsView alloc] initWithNumberOfButtons:3
                                                               actionHandler:^(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index)
                          {
                              NSLog(@"%@, %i", title, (int)index);
                          }];
        _radioButtons3.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.f];
        [_radioButtons3 setButtonsTitles:@[@"Title 1", @"Title 2", @"Title 3"] forState:UIControlStateNormal];
        [_radioButtons3 setButtonsTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radioButtons3 setButtonsImage:circleImageNormal forState:UIControlStateNormal];
        [_radioButtons3 setButtonsImage:circleImageHighlighted forState:UIControlStateHighlighted];
        [_radioButtons3 setButtonsImage:circleImageHighlighted forState:UIControlStateSelected];
        [_radioButtons3 setButtonsAdjustsImageWhenHighlighted:NO];
        [_radioButtons3 setButtonsImagePosition:LGRadioButtonImagePositionRight];
        [_scrollView addSubview:_radioButtons3];
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
    
    CGFloat shift = 10.f;
    
    CGSize radioButtonsSize1 = [_radioButtons1 sizeThatFits:CGSizeMake(self.view.frame.size.width-shift*2, CGFLOAT_MAX)];
    CGRect radioButtonsFrame1 = CGRectMake(shift, shift, radioButtonsSize1.width, radioButtonsSize1.height);
    radioButtonsFrame1 = CGRectIntegral(radioButtonsFrame1);
    _radioButtons1.frame = radioButtonsFrame1;
    
    CGSize radioButtonsSize2 = [_radioButtons2 sizeThatFits:CGSizeMake(self.view.frame.size.width-shift*2, CGFLOAT_MAX)];
    CGRect radioButtonsFrame2 = CGRectMake(shift, _radioButtons1.frame.origin.y+_radioButtons1.frame.size.height+shift, radioButtonsSize2.width, radioButtonsSize2.height);
    radioButtonsFrame2 = CGRectIntegral(radioButtonsFrame2);
    _radioButtons2.frame = radioButtonsFrame2;
    
    CGSize radioButtonsSize3 = [_radioButtons3 sizeThatFits:CGSizeMake((self.view.frame.size.width-shift*2)/2, CGFLOAT_MAX)];
    CGRect radioButtonsFrame3 = CGRectMake(shift, _radioButtons2.frame.origin.y+_radioButtons2.frame.size.height+shift, radioButtonsSize3.width, radioButtonsSize3.height);
    radioButtonsFrame3 = CGRectIntegral(radioButtonsFrame3);
    _radioButtons3.frame = radioButtonsFrame3;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _radioButtons3.frame.origin.y+_radioButtons3.frame.size.height+shift);
}

@end
