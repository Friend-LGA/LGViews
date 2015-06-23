//
//  LGButton.m
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

#import "LGButton.h"

@interface LGButton ()

typedef enum
{
    LGButtonMaskImageTypeNone,
    LGButtonMaskImageTypeAlpha,
    LGButtonMaskImageTypeBlackAndWhite
}
LGButtonMaskImageType;

@property (strong, nonatomic) NSMutableArray *maskArray;
@property (assign, nonatomic) LGButtonMaskImageType maskType;

@end

@implementation LGButton

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
    self.imageSpacingFromTitle = 6.f;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark -

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, point))
    {
        if (_maskType == LGButtonMaskImageTypeAlpha)
            return [LGButton maskAlphaImage:_maskImage pointIsCorrect:point containerSize:self.bounds.size];
        else if (_maskType == LGButtonMaskImageTypeBlackAndWhite)
            return [LGButton maskBlackAndWhiteImage:_maskImage pointIsCorrect:point containerSize:self.bounds.size];
        else
            return [super pointInside:point withEvent:event];
    }
    else return NO;
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    
    CGFloat imageSpaceFromTitle = _imageSpacingFromTitle;
    
    CGRect imageViewFrame = CGRectZero;
    CGRect titleLabelFrame = CGRectZero;
    
    // -----
    
    CGSize imageViewSize = CGSizeZero;
    
    if (self.imageView.image)
    {
        CGSize sizeToFit = CGSizeMake(size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.imageEdgeInsets.left+self.imageEdgeInsets.right),
                                      size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.imageEdgeInsets.top+self.imageEdgeInsets.bottom));
        
        if (sizeToFit.width < 0.f)
            sizeToFit.width = 0.f;
        
        if (sizeToFit.height < 0.f)
            sizeToFit.height = 0.f;
        
        imageViewSize = [self.imageView sizeThatFits:sizeToFit];
        
        if (imageViewSize.width > sizeToFit.width)
            imageViewSize.width = size.width;
        
        if (imageViewSize.height > sizeToFit.height)
            imageViewSize.height = size.height;
        
        imageViewFrame = CGRectMake(0.f, 0.f, imageViewSize.width, imageViewSize.height);
    }
    else imageSpaceFromTitle = 0.f;
    
    // -----
    
    CGSize titleLabelSize = CGSizeZero;
    
    if (self.titleLabel.text.length)
    {
        CGSize sizeToFit = CGSizeZero;
        
        if (self.isTitleLabelWidthUnlimited)
            sizeToFit = CGSizeZero;
        else
        {
            sizeToFit = CGSizeMake(size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.titleEdgeInsets.left+self.titleEdgeInsets.right),
                                   size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.titleEdgeInsets.top+self.titleEdgeInsets.bottom));
            
            if (self.imageView.image)
            {
                if (_titlePosition == LGButtonTitlePositionTop || _titlePosition == LGButtonTitlePositionBottom)
                    sizeToFit.height -= (imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom);
                else
                    sizeToFit.width -= (imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right);
            }
            
            if (sizeToFit.width < 0.f)
                sizeToFit.width = 0.f;
            
            if (sizeToFit.height < 0.f)
                sizeToFit.height = 0.f;
        }
        
        titleLabelSize = [self.titleLabel sizeThatFits:sizeToFit];
        
        titleLabelFrame = CGRectMake(0.f, 0.f, titleLabelSize.width, titleLabelSize.height);
    }
    else imageSpaceFromTitle = 0.f;

    // -----
    
    titleLabelFrame.origin.x = size.width/2-titleLabelSize.width/2;
    titleLabelFrame.origin.y = size.height/2-titleLabelSize.height/2;

    imageViewFrame.origin.x = size.width/2-imageViewSize.width/2;
    imageViewFrame.origin.y = size.height/2-imageViewSize.height/2;
    
    if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
    {
        //
    }
    else
    {
        CGFloat heightDif = size.height-(imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom+titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom+imageSpaceFromTitle);
        CGFloat widthDif = size.width-(imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right+titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right+imageSpaceFromTitle);
        
        if (_imagePosition == LGButtonImagePositionTop)
        {
            imageViewFrame.origin.y = heightDif/2+self.imageEdgeInsets.top;
            titleLabelFrame.origin.y = imageViewFrame.origin.y+imageViewSize.height+self.imageEdgeInsets.bottom+imageSpaceFromTitle+self.titleEdgeInsets.top;
        }
        else if (_imagePosition == LGButtonImagePositionRight)
        {
            titleLabelFrame.origin.x = widthDif/2+self.titleEdgeInsets.left;
            imageViewFrame.origin.x = titleLabelFrame.origin.x+titleLabelSize.width+self.titleEdgeInsets.right+imageSpaceFromTitle+self.imageEdgeInsets.left;
        }
        else if (_imagePosition == LGButtonImagePositionBottom)
        {
            titleLabelFrame.origin.y = heightDif/2+self.titleEdgeInsets.top;
            imageViewFrame.origin.y = titleLabelFrame.origin.y+titleLabelSize.height+self.titleEdgeInsets.bottom+imageSpaceFromTitle+self.imageEdgeInsets.top;
        }
        else if (_imagePosition == LGButtonImagePositionLeft)
        {
            imageViewFrame.origin.x = widthDif/2+self.imageEdgeInsets.left;
            titleLabelFrame.origin.x = imageViewFrame.origin.x+imageViewSize.width+self.imageEdgeInsets.right+imageSpaceFromTitle+self.titleEdgeInsets.left;
        }
    }
    
    // -----
    
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill)
    {
        titleLabelFrame.origin.x = self.contentEdgeInsets.left+self.titleEdgeInsets.left;
        titleLabelFrame.size.width = self.frame.size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.titleEdgeInsets.left+self.titleEdgeInsets.right);
        
        imageViewFrame.origin.x = self.contentEdgeInsets.left+self.imageEdgeInsets.left;
        imageViewFrame.size.width = self.frame.size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.imageEdgeInsets.left+self.imageEdgeInsets.right);
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter)
    {
        CGFloat titleLabelAvailableWidth = self.frame.size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.titleEdgeInsets.left+self.titleEdgeInsets.right);
        CGFloat imageViewAvailableWidth = self.frame.size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.imageEdgeInsets.left+self.imageEdgeInsets.right);
        
        titleLabelFrame.origin.x = self.contentEdgeInsets.left+self.titleEdgeInsets.left+(titleLabelAvailableWidth/2-titleLabelFrame.size.width/2);
        imageViewFrame.origin.x = self.contentEdgeInsets.left+self.imageEdgeInsets.left+(imageViewAvailableWidth/2-imageViewFrame.size.width/2);
        
        if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
        {
            //
        }
        else
        {
            if (_imagePosition == LGButtonImagePositionTop || _imagePosition == LGButtonImagePositionBottom)
            {
                //
            }
            else if (_imagePosition == LGButtonImagePositionRight)
            {
                titleLabelFrame.origin.x -= (imageViewFrame.size.width+imageSpaceFromTitle)/2;
                imageViewFrame.origin.x += (titleLabelFrame.size.width+imageSpaceFromTitle)/2;
            }
            else if (_imagePosition == LGButtonImagePositionLeft)
            {
                titleLabelFrame.origin.x += (imageViewFrame.size.width+imageSpaceFromTitle)/2;
                imageViewFrame.origin.x -= (titleLabelFrame.size.width+imageSpaceFromTitle)/2;
            }
        }
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        titleLabelFrame.origin.x = self.contentEdgeInsets.left+self.titleEdgeInsets.left;
        imageViewFrame.origin.x = self.contentEdgeInsets.left+self.imageEdgeInsets.left;
        
        if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
        {
            //
        }
        else
        {
            if (_imagePosition == LGButtonImagePositionTop || _imagePosition == LGButtonImagePositionBottom)
            {
                //
            }
            else if (_imagePosition == LGButtonImagePositionRight)
            {
                imageViewFrame.origin.x = titleLabelFrame.origin.x+titleLabelSize.width+self.titleEdgeInsets.right+imageSpaceFromTitle+self.imageEdgeInsets.left;
            }
            else if (_imagePosition == LGButtonImagePositionLeft)
            {
                titleLabelFrame.origin.x = imageViewFrame.origin.x+imageViewSize.width+self.imageEdgeInsets.right+imageSpaceFromTitle+self.titleEdgeInsets.left;
            }
        }
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight)
    {
        titleLabelFrame.origin.x = size.width-titleLabelSize.width-self.titleEdgeInsets.right-self.contentEdgeInsets.right;
        imageViewFrame.origin.x = size.width-imageViewSize.width-self.imageEdgeInsets.right-self.contentEdgeInsets.right;
        
        if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
        {
            //
        }
        else
        {
            if (_imagePosition == LGButtonImagePositionTop || _imagePosition == LGButtonImagePositionBottom)
            {
                //
            }
            else if (_imagePosition == LGButtonImagePositionRight)
            {
                imageViewFrame.origin.x = titleLabelFrame.origin.x+titleLabelSize.width+self.titleEdgeInsets.right+imageSpaceFromTitle+self.imageEdgeInsets.left;
            }
            else if (_imagePosition == LGButtonImagePositionLeft)
            {
                titleLabelFrame.origin.x = imageViewFrame.origin.x+imageViewSize.width+self.imageEdgeInsets.right+imageSpaceFromTitle+self.titleEdgeInsets.left;
            }
        }
    }
    
    // -----
    
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentFill)
    {
        titleLabelFrame.origin.y = self.contentEdgeInsets.top+self.titleEdgeInsets.top;
        titleLabelFrame.size.height = self.frame.size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        
        imageViewFrame.origin.y = self.contentEdgeInsets.top+self.imageEdgeInsets.top;
        imageViewFrame.size.height = self.frame.size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.imageEdgeInsets.top+self.imageEdgeInsets.bottom);
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter)
    {
        CGFloat titleLabelAvailableHeight = self.frame.size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        CGFloat imageViewAvailableHeight = self.frame.size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.imageEdgeInsets.top+self.imageEdgeInsets.bottom);
        
        titleLabelFrame.origin.y = self.contentEdgeInsets.top+self.titleEdgeInsets.top+(titleLabelAvailableHeight/2-titleLabelFrame.size.height/2);
        imageViewFrame.origin.y = self.contentEdgeInsets.top+self.imageEdgeInsets.top+(imageViewAvailableHeight/2-imageViewFrame.size.height/2);
        
        if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
        {
            //
        }
        else
        {
            if (_imagePosition == LGButtonImagePositionLeft || _imagePosition == LGButtonImagePositionRight)
            {
                //
            }
            else if (_imagePosition == LGButtonImagePositionTop)
            {
                titleLabelFrame.origin.y += (imageViewFrame.size.height+imageSpaceFromTitle)/2;
                imageViewFrame.origin.y -= (titleLabelFrame.size.height+imageSpaceFromTitle)/2;
            }
            else if (_imagePosition == LGButtonImagePositionBottom)
            {
                titleLabelFrame.origin.y -= (imageViewFrame.size.height+imageSpaceFromTitle)/2;
                imageViewFrame.origin.y += (titleLabelFrame.size.height+imageSpaceFromTitle)/2;
            }
        }
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
    {
        titleLabelFrame.origin.y = self.titleEdgeInsets.top+self.contentEdgeInsets.top;
        imageViewFrame.origin.y = self.imageEdgeInsets.top+self.contentEdgeInsets.top;
        
        if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
        {
            //
        }
        else
        {
            if (_imagePosition == LGButtonImagePositionLeft || _imagePosition == LGButtonImagePositionRight)
            {
                //
            }
            else if (_imagePosition == LGButtonImagePositionTop)
            {
                titleLabelFrame.origin.y = imageViewFrame.origin.y+imageViewSize.height+self.imageEdgeInsets.bottom+imageSpaceFromTitle+self.titleEdgeInsets.top;
            }
            else if (_imagePosition == LGButtonImagePositionBottom)
            {
                imageViewFrame.origin.y = titleLabelFrame.origin.y+titleLabelSize.height+self.titleEdgeInsets.bottom+imageSpaceFromTitle+self.imageEdgeInsets.top;
            }
        }
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
    {
        titleLabelFrame.origin.y = size.height-titleLabelSize.height-self.titleEdgeInsets.bottom-self.contentEdgeInsets.bottom;
        imageViewFrame.origin.y = size.height-imageViewSize.height-self.imageEdgeInsets.bottom-self.contentEdgeInsets.bottom;
        
        if (CGSizeEqualToSize(imageViewSize, CGSizeZero) || CGSizeEqualToSize(titleLabelSize, CGSizeZero))
        {
            //
        }
        else
        {
            if (_imagePosition == LGButtonImagePositionLeft || _imagePosition == LGButtonImagePositionRight)
            {
                //
            }
            else if (_imagePosition == LGButtonImagePositionTop)
            {
                titleLabelFrame.origin.y = imageViewFrame.origin.y+imageViewSize.height+self.imageEdgeInsets.bottom+imageSpaceFromTitle+self.titleEdgeInsets.top;
            }
            else if (_imagePosition == LGButtonImagePositionBottom)
            {
                imageViewFrame.origin.y = titleLabelFrame.origin.y+titleLabelSize.height+self.titleEdgeInsets.bottom+imageSpaceFromTitle+self.imageEdgeInsets.top;
            }
        }
    }
    
    // -----
    
    titleLabelFrame.origin.x += self.titleOffset.x;
    titleLabelFrame.origin.y += self.titleOffset.y;
    
    imageViewFrame.origin.x += self.imageOffset.x;
    imageViewFrame.origin.y += self.imageOffset.y;
    
    // -----
    
    if ([UIScreen mainScreen].scale == 1.f)
    {
        titleLabelFrame = CGRectIntegral(titleLabelFrame);
        imageViewFrame = CGRectIntegral(imageViewFrame);
    }
    
    self.imageView.frame = imageViewFrame;
    self.titleLabel.frame = titleLabelFrame;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat imageSpaceFromTitle = _imageSpacingFromTitle;
    
    // -----
    
    CGSize imageViewSize = CGSizeZero;
    
    if (self.imageView.image)
    {
        CGSize sizeToFit = CGSizeMake(size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.imageEdgeInsets.left+self.imageEdgeInsets.right),
                                      size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.imageEdgeInsets.top+self.imageEdgeInsets.bottom));
        
        if (sizeToFit.width < 0.f)
            sizeToFit.width = 0.f;
        
        if (sizeToFit.height < 0.f)
            sizeToFit.height = 0.f;
        
        imageViewSize = [self.imageView sizeThatFits:sizeToFit];
        
        if (sizeToFit.width > 0.f && imageViewSize.width > sizeToFit.width)
            imageViewSize.width = size.width;
        
        if (sizeToFit.height > 0.f && imageViewSize.height > sizeToFit.height)
            imageViewSize.height = size.height;
    }
    else imageSpaceFromTitle = 0.f;
    
    // -----
    
    CGSize titleLabelSize = CGSizeZero;
    
    if (self.titleLabel.text.length)
    {
        CGSize sizeToFit = CGSizeZero;
        
        if (self.isTitleLabelWidthUnlimited)
            sizeToFit = CGSizeZero;
        else
        {
            sizeToFit = CGSizeMake(size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.titleEdgeInsets.left+self.titleEdgeInsets.right),
                                   size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.titleEdgeInsets.top+self.titleEdgeInsets.bottom));
            
            if (self.imageView.image)
            {
                if (_titlePosition == LGButtonTitlePositionTop || _titlePosition == LGButtonTitlePositionBottom)
                    sizeToFit.height -= (imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom);
                else
                    sizeToFit.width -= (imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right);
            }
            
            if (sizeToFit.width < 0.f)
                sizeToFit.width = 0.f;
            
            if (sizeToFit.height < 0.f)
                sizeToFit.height = 0.f;
        }
        
        titleLabelSize = [self.titleLabel sizeThatFits:sizeToFit];
    }
    else imageSpaceFromTitle = 0.f;
    
    // -----
    
    CGFloat height = 0.f;
    CGFloat width = 0.f;
    
    if (_imagePosition == LGButtonImagePositionTop)
    {
        height = imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom+imageSpaceFromTitle+titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom;
        width = MAX(imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right, titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right);
    }
    else if (_imagePosition == LGButtonImagePositionRight)
    {
        height = MAX(imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom, titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        width = imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right+imageSpaceFromTitle+titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right;
    }
    else if (_imagePosition == LGButtonImagePositionBottom)
    {
        height = imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom+imageSpaceFromTitle+titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom;
        width = MAX(imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right, titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right);
    }
    else if (_imagePosition == LGButtonImagePositionLeft)
    {
        height = MAX(imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom, titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        width = imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right+imageSpaceFromTitle+titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right;
    }
    else if (_imagePosition == LGButtonImagePositionCenter)
    {
        height = MAX(imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom, titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        width = MAX(imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right, titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right);
    }
    
    height += (self.contentEdgeInsets.top + self.contentEdgeInsets.bottom);
    width += (self.contentEdgeInsets.left + self.contentEdgeInsets.right);
    
    return CGSizeMake(width, height);
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (self.isAdjustsAlphaWhenHighlighted)
    {
        if (highlighted) self.alpha = 0.5;
        else self.alpha = 1.f;
    }
    
    if (self.isAnimatedStateChanging)
        [UIView transitionWithView:self
                          duration:0.1
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (self.isAnimatedStateChanging)
        [UIView transitionWithView:self
                          duration:0.1
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
}

#pragma mark -

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    [self setBackgroundImage:(color ? [LGButton image1x1WithColor:color] : nil) forState:state];
}

- (void)setAdjustsAlphaWhenHighlighted:(BOOL)adjustsAlphaWhenHighlighted
{
    _adjustsAlphaWhenHighlighted = adjustsAlphaWhenHighlighted;
    
    if (adjustsAlphaWhenHighlighted)
        self.adjustsImageWhenHighlighted = NO;
}

- (void)setAdjustsImageWhenHighlighted:(BOOL)adjustsImageWhenHighlighted
{
    [super setAdjustsImageWhenHighlighted:adjustsImageWhenHighlighted];
    
    if (adjustsImageWhenHighlighted)
        _adjustsAlphaWhenHighlighted = NO;
}

#pragma mark -

- (void)setImagePosition:(LGButtonImagePosition)imagePosition
{
    if (_imagePosition != imagePosition)
    {
        _imagePosition = imagePosition;
        _titlePosition = (LGButtonTitlePosition)imagePosition;
        
        [self layoutSubviews];
    }
}

- (void)setTitlePosition:(LGButtonTitlePosition)titlePosition
{
    if (_titlePosition != titlePosition)
    {
        _titlePosition = titlePosition;
        _imagePosition = (LGButtonImagePosition)titlePosition;
        
        [self layoutSubviews];
    }
}

- (void)setImageSpacingFromTitle:(CGFloat)imageSpacingFromTitle
{
    if (_imageSpacingFromTitle != imageSpacingFromTitle)
    {
        _imageSpacingFromTitle = imageSpacingFromTitle;
        _titleSpacingFromImage = imageSpacingFromTitle;
        
        [self layoutSubviews];
    }
}

- (void)setTitleSpacingFromImage:(CGFloat)titleSpacingFromImage
{
    if (_titleSpacingFromImage != titleSpacingFromImage)
    {
        _titleSpacingFromImage = titleSpacingFromImage;
        _imageSpacingFromTitle = titleSpacingFromImage;
        
        [self layoutSubviews];
    }
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    if (!CGPointEqualToPoint(_imageOffset, imageOffset))
    {
        _imageOffset = imageOffset;
        
        [self layoutSubviews];
    }
}

- (void)setTitleOffset:(CGPoint)titleOffset
{
    if (!CGPointEqualToPoint(_titleOffset, titleOffset))
    {
        _titleOffset = titleOffset;
        
        [self layoutSubviews];
    }
}

#pragma mark -

- (void)setMaskAlphaImage:(UIImage *)maskImage
{
    _maskImage = maskImage;
    
    _maskType = (_maskImage ? LGButtonMaskImageTypeAlpha : LGButtonMaskImageTypeNone);
}

- (void)setMaskBlackAndWhiteImage:(UIImage *)maskImage
{
    _maskImage = maskImage;
    
    _maskType = (_maskImage ? LGButtonMaskImageTypeBlackAndWhite : LGButtonMaskImageTypeNone);
}

#pragma mark - Support

+ (BOOL)maskAlphaImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point containerSize:(CGSize)containerSize
{
    CGSize imageSize = maskImage.size;
    
    point.x *= (containerSize.width != 0) ? (imageSize.width / containerSize.width) : 1;
    point.y *= (containerSize.height != 0) ? (imageSize.height / containerSize.height) : 1;
    
    UIColor *pixelColor = [LGButton image:maskImage colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    
    return alpha > 0.f;
}

+ (BOOL)maskBlackAndWhiteImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point containerSize:(CGSize)containerSize
{
    CGSize imageSize = maskImage.size;
    
    point.x *= (containerSize.width != 0) ? (imageSize.width / containerSize.width) : 1;
    point.y *= (containerSize.height != 0) ? (imageSize.height / containerSize.height) : 1;
    
    UIColor *pixelColor = [LGButton image:maskImage colorAtPixel:point];
    
    return ![pixelColor isEqual:[UIColor blackColor]];
}

+ (UIColor *)image:(UIImage *)image colorAtPixel:(CGPoint)point
{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point))
        return nil;
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)image1x1WithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.f, 0.f, 1.f, 1.f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
