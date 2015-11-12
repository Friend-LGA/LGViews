//
//  LGRadioButton.m
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

#import "LGRadioButton.h"

@implementation LGRadioButton

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];

        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.imageSpacingFromTitle = 6.f;

        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return self;
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
        CGSize sizeToFit = sizeToFit = CGSizeMake(size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.titleEdgeInsets.left+self.titleEdgeInsets.right),
                                                  size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.titleEdgeInsets.top+self.titleEdgeInsets.bottom));
        
        if (self.imageView.image)
            sizeToFit.width -= (imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right);
        
        if (sizeToFit.width < 0.f)
            sizeToFit.width = 0.f;
        
        if (sizeToFit.height < 0.f)
            sizeToFit.height = 0.f;
        
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
        CGFloat widthDif = size.width-(imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right+titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right+imageSpaceFromTitle);
        
        if (_imagePosition == LGRadioButtonImagePositionRight)
        {
            titleLabelFrame.origin.x = widthDif/2+self.titleEdgeInsets.left;
            imageViewFrame.origin.x = titleLabelFrame.origin.x+titleLabelSize.width+self.titleEdgeInsets.right+imageSpaceFromTitle+self.imageEdgeInsets.left;
        }
        else if (_imagePosition == LGRadioButtonImagePositionLeft)
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
            if (_imagePosition == LGRadioButtonImagePositionRight)
            {
                titleLabelFrame.origin.x -= (imageViewFrame.size.width+imageSpaceFromTitle)/2;
                imageViewFrame.origin.x += (titleLabelFrame.size.width+imageSpaceFromTitle)/2;
            }
            else if (_imagePosition == LGRadioButtonImagePositionLeft)
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
            if (_imagePosition == LGRadioButtonImagePositionRight)
            {
                imageViewFrame.origin.x = size.width-imageViewSize.width-self.imageEdgeInsets.right-self.contentEdgeInsets.right;
            }
            else if (_imagePosition == LGRadioButtonImagePositionLeft)
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
            if (_imagePosition == LGRadioButtonImagePositionRight)
            {
                titleLabelFrame.origin.x = self.contentEdgeInsets.left+self.titleEdgeInsets.left;
            }
            else if (_imagePosition == LGRadioButtonImagePositionLeft)
            {
                imageViewFrame.origin.x = titleLabelFrame.origin.x-imageViewSize.width-self.titleEdgeInsets.right-imageSpaceFromTitle-self.imageEdgeInsets.left;
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
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
    {
        titleLabelFrame.origin.y = self.titleEdgeInsets.top+self.contentEdgeInsets.top;
        imageViewFrame.origin.y = self.imageEdgeInsets.top+self.contentEdgeInsets.top;
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
    {
        titleLabelFrame.origin.y = size.height-titleLabelSize.height-self.titleEdgeInsets.bottom-self.contentEdgeInsets.bottom;
        imageViewFrame.origin.y = size.height-imageViewSize.height-self.imageEdgeInsets.bottom-self.contentEdgeInsets.bottom;
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
        CGSize sizeToFit = CGSizeMake(size.width-(self.contentEdgeInsets.left+self.contentEdgeInsets.right)-(self.titleEdgeInsets.left+self.titleEdgeInsets.right),
                                      size.height-(self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)-(self.titleEdgeInsets.top+self.titleEdgeInsets.bottom));
        
        if (self.imageView.image)
            sizeToFit.width -= (imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right);
        
        if (sizeToFit.width < 0.f)
            sizeToFit.width = 0.f;
        
        if (sizeToFit.height < 0.f)
            sizeToFit.height = 0.f;
        
        titleLabelSize = [self.titleLabel sizeThatFits:sizeToFit];
    }
    else imageSpaceFromTitle = 0.f;
    
    // -----
    
    CGFloat height = 0.f;
    CGFloat width = 0.f;
    
    if (_imagePosition == LGRadioButtonImagePositionRight)
    {
        height = MAX(imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom, titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        width = imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right+imageSpaceFromTitle+titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right;
    }
    else if (_imagePosition == LGRadioButtonImagePositionLeft)
    {
        height = MAX(imageViewSize.height+self.imageEdgeInsets.top+self.imageEdgeInsets.bottom, titleLabelSize.height+self.titleEdgeInsets.top+self.titleEdgeInsets.bottom);
        width = imageViewSize.width+self.imageEdgeInsets.left+self.imageEdgeInsets.right+imageSpaceFromTitle+titleLabelSize.width+self.titleEdgeInsets.left+self.titleEdgeInsets.right;
    }
    
    height += (self.contentEdgeInsets.top + self.contentEdgeInsets.bottom);
    width += (self.contentEdgeInsets.left + self.contentEdgeInsets.right);
    
    return CGSizeMake(width, height);
}

#pragma mark - Setters and Getters

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[LGRadioButton image1x1WithColor:backgroundColor] forState:state];
}

- (void)setImagePosition:(LGRadioButtonImagePosition)imagePosition
{
    if (_imagePosition != imagePosition)
    {
        _imagePosition = imagePosition;
        _titlePosition = (LGRadioButtonTitlePosition)imagePosition;
        
        [self layoutSubviews];
    }
}

- (void)setTitlePosition:(LGRadioButtonTitlePosition)titlePosition
{
    if (_titlePosition != titlePosition)
    {
        _titlePosition = titlePosition;
        _imagePosition = (LGRadioButtonImagePosition)titlePosition;
        
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

#pragma mark - Support

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
