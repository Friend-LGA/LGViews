//
//  LGRadioButtonsView.m
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

#import "LGRadioButtonsView.h"

@interface LGRadioButtonsView ()

@property (assign, nonatomic) UIButton *buttonSelected;

@end

@implementation LGRadioButtonsView

- (instancetype)initWithNumberOfButtons:(NSUInteger)numberOfButtons
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableArray *buttons = [NSMutableArray new];
        
        for (NSUInteger i=0; i<numberOfButtons; i++)
        {
            LGRadioButton *button = [LGRadioButton new];
            button.tag = i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            [buttons addObject:button];
        }

        _buttons = buttons;
        
        _spaceBetweenButtons = 6.f;
    }
    return self;
}

+ (instancetype)radioButtonsViewWithNumberOfButtons:(NSUInteger)numberOfButtons
{
    return [[self alloc] initWithNumberOfButtons:numberOfButtons];
}

#pragma mark -

- (instancetype)initWithNumberOfButtons:(NSUInteger)numberOfButtons
                actionHandler:(void(^)(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index))actionHandler
{
    self = [self initWithNumberOfButtons:numberOfButtons];
    if (self)
    {
        _actionHandler = actionHandler;
    }
    return self;
}

+ (instancetype)radioButtonsViewWithNumberOfButtons:(NSUInteger)numberOfButtons
                            actionHandler:(void(^)(LGRadioButtonsView *radioButtonsView, NSString *title, NSUInteger index))actionHandler
{
    return [[self alloc] initWithNumberOfButtons:numberOfButtons
                                   actionHandler:actionHandler];
}

#pragma mark -

- (instancetype)initWithNumberOfButtons:(NSUInteger)numberOfButtons
                     delegate:(id<LGRadioButtonsViewDelegate>)delegate
{
    self = [self initWithNumberOfButtons:numberOfButtons];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

+ (instancetype)radioButtonsViewWithNumberOfButtons:(NSUInteger)numberOfButtons
                                 delegate:(id<LGRadioButtonsViewDelegate>)delegate
{
    return [[self alloc] initWithNumberOfButtons:numberOfButtons
                                        delegate:delegate];
}

#pragma mark - Dealloc

- (void)dealloc
{
#if DEBUG
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
#endif
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    
    CGSize sizeToFit = CGSizeMake(size.width-(_contentEdgeInsets.left+_contentEdgeInsets.right), 0.f);
    if (sizeToFit.width < 0)
        sizeToFit.width = 0.f;
    
    for (NSUInteger i=0; i<_buttons.count; i++)
    {
        LGRadioButton *button = _buttons[i];
        
        CGSize buttonSize = [button sizeThatFits:sizeToFit];
        CGRect buttonFrame = CGRectZero;
        
        if (i == 0)
            buttonFrame = CGRectMake(_contentEdgeInsets.left, _contentEdgeInsets.top, sizeToFit.width, buttonSize.height);
        else
        {
            LGRadioButton *buttonPrev = _buttons[i-1];
            
            buttonFrame = CGRectMake(_contentEdgeInsets.left, buttonPrev.frame.origin.y+buttonPrev.frame.size.height+_spaceBetweenButtons, sizeToFit.width, buttonSize.height);
        }
        
        if ([UIScreen mainScreen].scale == 1.f)
            buttonFrame = CGRectIntegral(buttonFrame);
        button.frame = buttonFrame;
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeToFit = CGSizeMake(size.width-(_contentEdgeInsets.left+_contentEdgeInsets.right), 0.f);
    if (sizeToFit.width < 0)
        sizeToFit.width = 0.f;
    
    CGFloat width = 0.f;
    CGFloat height = 0.f;
    
    for (LGRadioButton *button in _buttons)
    {
        CGSize buttonSize = [button sizeThatFits:sizeToFit];
        
        height += buttonSize.height;
        
        width = MAX(width, buttonSize.width);
    }
    
    height += _spaceBetweenButtons*(_buttons.count-1)+(_contentEdgeInsets.top+_contentEdgeInsets.bottom);
    width += (_contentEdgeInsets.left+_contentEdgeInsets.right);
    
    return CGSizeMake(width, height);
}

#pragma mark - Setters and Getters

- (void)setSpaceBetweenButtons:(CGFloat)spaceBetweenButtons
{
    if (_spaceBetweenButtons != spaceBetweenButtons)
    {
        _spaceBetweenButtons = spaceBetweenButtons;
        
        [self layoutSubviews];
    }
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_contentEdgeInsets, contentEdgeInsets))
    {
        _contentEdgeInsets = contentEdgeInsets;
        
        [self layoutSubviews];
    }
}

#pragma mark -

- (void)setButtonsTitles:(NSArray *)titles forState:(UIControlState)state
{
    BOOL isChanged = NO;
    
    for (NSUInteger i=0; i<_buttons.count; i++)
    {
        LGRadioButton *button = _buttons[i];
        
        if (![button.titleLabel.text isEqualToString:titles[i]])
        {
            [button setTitle:titles[i] forState:state];
            
            isChanged = YES;
        }
    }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsTitleColor:(UIColor *)titleColor forState:(UIControlState)state
{
    for (LGRadioButton *button in _buttons)
        [button setTitleColor:titleColor forState:state];
}

- (void)setButtonsImage:(UIImage *)image forState:(UIControlState)state
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
    {
        if (!CGSizeEqualToSize(button.imageView.image.size, image.size))
            isChanged = YES;
        
        [button setImage:image forState:state];
    }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state
{
    for (LGRadioButton *button in _buttons)
        [button setBackgroundImage:backgroundImage forState:state];
}

- (void)setButtonsBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    for (LGRadioButton *button in _buttons)
        [button setBackgroundColor:backgroundColor forState:state];
}

- (void)setButtonsTitleFont:(UIFont *)font
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
        if (![button.titleLabel.font isEqual:font])
        {
            button.titleLabel.font = font;
            
            isChanged = YES;
        }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsImagePosition:(LGRadioButtonImagePosition)buttonsImagePosition
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
        if (button.imagePosition != buttonsImagePosition)
        {
            button.imagePosition = buttonsImagePosition;

            button.contentHorizontalAlignment = (buttonsImagePosition == LGRadioButtonImagePositionLeft ? UIControlContentHorizontalAlignmentLeft : UIControlContentHorizontalAlignmentRight);
            
            isChanged = YES;
        }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsTitlePosition:(LGRadioButtonTitlePosition)buttonsTitlePosition
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
        if (button.titlePosition != buttonsTitlePosition)
        {
            button.titlePosition = buttonsTitlePosition;

            button.contentHorizontalAlignment = (buttonsTitlePosition == LGRadioButtonTitlePositionRight ? UIControlContentHorizontalAlignmentLeft : UIControlContentHorizontalAlignmentRight);
            
            isChanged = YES;
        }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsImageSpacingFromTitle:(CGFloat)imageSpacingFromTitle
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
        if (button.imageSpacingFromTitle != imageSpacingFromTitle)
        {
            button.imageSpacingFromTitle = imageSpacingFromTitle;
            
            isChanged = YES;
        }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsTitleSpacingFromImage:(CGFloat)titleSpacingFromImage
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
        if (button.titleSpacingFromImage != titleSpacingFromImage)
        {
            button.titleSpacingFromImage = titleSpacingFromImage;
            
            isChanged = YES;
        }
    
    if (isChanged) [self layoutSubviews];
}

#pragma mark -

- (void)setButtonsClipsToBounds:(BOOL)clipsToBounds
{
    for (LGRadioButton *button in _buttons)
        button.clipsToBounds = clipsToBounds;
}

- (void)setButtonsContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    BOOL isChanged = NO;
    
    for (LGRadioButton *button in _buttons)
        if (!UIEdgeInsetsEqualToEdgeInsets(button.contentEdgeInsets, contentEdgeInsets))
        {
            button.contentEdgeInsets = contentEdgeInsets;
            
            isChanged = YES;
        }
    
    if (isChanged) [self layoutSubviews];
}

- (void)setButtonsContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment
{
    for (LGRadioButton *button in _buttons)
        button.contentVerticalAlignment = contentVerticalAlignment;
}

- (void)setButtonsAdjustsImageWhenHighlighted:(BOOL)adjustsImageWhenHighlighted
{
    for (LGRadioButton *button in _buttons)
        button.adjustsImageWhenHighlighted = adjustsImageWhenHighlighted;
}

#pragma mark -

- (void)setButtonsLayerMasksToBounds:(BOOL)masksToBounds
{
    for (LGRadioButton *button in _buttons)
        button.layer.masksToBounds = masksToBounds;
}

- (void)setButtonsLayerCornerRadius:(CGFloat)cornerRadius
{
    for (LGRadioButton *button in _buttons)
        button.layer.cornerRadius = cornerRadius;
}

- (void)setButtonsLayerBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    for (LGRadioButton *button in _buttons)
    {
        button.layer.borderColor = borderColor.CGColor;
        button.layer.borderWidth = borderWidth;
    }
}

- (void)setButtonsLayerShadowColor:(UIColor *)shadowColor shadowOpacity:(float)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius
{
    for (LGRadioButton *button in _buttons)
    {
        button.layer.shadowColor = shadowColor.CGColor;
        button.layer.shadowOpacity = shadowOpacity;
        button.layer.shadowOffset = shadowOffset;
        button.layer.shadowRadius = shadowRadius;
    }
}

#pragma mark -

- (void)deselectAllButtonsExept:(NSUInteger)buttonTag
{
    for (LGRadioButton *button in _buttons)
        if (button.tag != buttonTag)
        {
            button.selected = NO;
            button.userInteractionEnabled = YES;
        }
}

- (void)buttonAction:(LGRadioButton *)button
{
    if (!button.isSelected)
    {
        [self deselectAllButtonsExept:button.tag];
        
        button.selected = YES;
        button.userInteractionEnabled = NO;
        
        _buttonSelected = button;
        
        if (_actionHandler) _actionHandler(self, button.titleLabel.text, button.tag);
        
        if (_delegate && [_delegate respondsToSelector:@selector(radioButtonsView:buttonPressedWithTitle:index:)])
            [_delegate radioButtonsView:self buttonPressedWithTitle:button.titleLabel.text index:button.tag];
    }
}

@end
