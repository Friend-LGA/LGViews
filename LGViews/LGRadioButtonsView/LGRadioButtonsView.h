//
//  LGRadioButtonsView.h
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
#import "LGRadioButton.h"

@class LGRadioButtonsView;

@protocol LGRadioButtonsViewDelegate <NSObject>

@optional

- (void)radioButtonsView:(LGRadioButtonsView *)radioButtonsView buttonPressedWithTitle:(NSString *)title index:(NSUInteger)index;

@end

IB_DESIGNABLE

@interface LGRadioButtonsView : UIView

@property (strong, nonatomic) NSArray *buttons;
@property (assign, nonatomic, readonly) UIButton *buttonSelected;
/** Default is 6.f */
@property (assign, nonatomic) IBInspectable CGFloat spaceBetweenButtons;
@property (assign, nonatomic) IBInspectable UIEdgeInsets contentEdgeInsets;

/** Do not forget about weak referens to self */
@property (strong, nonatomic) void (^actionHandler)(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index);

@property (assign, nonatomic) id<LGRadioButtonsViewDelegate> delegate;

- (instancetype)initWithNumberOfButtons:(NSUInteger)numberOfButtons;
+ (instancetype)radioButtonsViewWithNumberOfButtons:(NSUInteger)numberOfButtons;

#pragma mark -

/** Do not forget about weak referens to self for actionHandler block */
- (instancetype)initWithNumberOfButtons:(NSUInteger)numberOfButtons
                          actionHandler:(void(^)(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index))actionHandler;

/** Do not forget about weak referens to self for actionHandler block */
+ (instancetype)radioButtonsViewWithNumberOfButtons:(NSUInteger)numberOfButtons
                                      actionHandler:(void(^)(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index))actionHandler;

#pragma mark -

- (instancetype)initWithNumberOfButtons:(NSUInteger)numberOfButtons
                               delegate:(id<LGRadioButtonsViewDelegate>)delegate;

+ (instancetype)radioButtonsViewWithNumberOfButtons:(NSUInteger)numberOfButtons
                                           delegate:(id<LGRadioButtonsViewDelegate>)delegate;

#pragma mark -

- (void)setButtonsTitles:(NSArray *)titles forState:(UIControlState)state;
- (void)setButtonsTitleColor:(UIColor *)titleColor forState:(UIControlState)state;
- (void)setButtonsImage:(UIImage *)image forState:(UIControlState)state;
- (void)setButtonsBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state;
- (void)setButtonsBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)setButtonsTitleFont:(UIFont *)font;
- (void)setButtonsImagePosition:(LGRadioButtonImagePosition)buttonsImagePosition;
- (void)setButtonsTitlePosition:(LGRadioButtonTitlePosition)buttonsTitlePosition;
- (void)setButtonsImageSpacingFromTitle:(CGFloat)imageSpacingFromTitle;
- (void)setButtonsTitleSpacingFromImage:(CGFloat)titleSpacingFromImage;

#pragma mark -

- (void)setButtonsClipsToBounds:(BOOL)clipsToBounds;
- (void)setButtonsContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;
- (void)setButtonsContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment;
- (void)setButtonsAdjustsImageWhenHighlighted:(BOOL)adjustsImageWhenHighlighted;

#pragma mark -

- (void)setButtonsLayerMasksToBounds:(BOOL)masksToBounds;
- (void)setButtonsLayerCornerRadius:(CGFloat)cornerRadius;
- (void)setButtonsLayerBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (void)setButtonsLayerShadowColor:(UIColor *)shadowColor shadowOpacity:(float)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius;

#pragma mark -

/** Unavailable, use +radioButtonsViewWithNumberOfButtons... instead */
+ (instancetype)new __attribute__((unavailable("use +radioButtonsViewWithNumberOfButtons... instead")));
/** Unavailable, use -initWithNumberOfButtons... instead */
- (instancetype)init __attribute__((unavailable("use -initWithNumberOfButtons... instead")));
/** Unavailable, use -initWithNumberOfButtons... instead */
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("use -initWithNumberOfButtons... instead")));

@end
