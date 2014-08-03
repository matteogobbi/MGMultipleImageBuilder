//
//  MGMultipleImageBuilder.m
//  MGMultipleImageExample
//
//  Created by admin on 29/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGMultipleImageBuilder.h"

static const CGFloat kMGPercentageSmallerImage = 80.0;
static const CGFloat kMGVisibleSideImageWidthFactor = 3.0/5.0;

@implementation MGMultipleImageBuilder {
	CGSize _sizeFrontImage;
	CGSize _sizeSideImage;
	CGSize _totalSize;
}

- (id)init
{
	@throw [NSException exceptionWithName:@"Init method not valid"
                                   reason:@"You have to use the custom initializer"
                                 userInfo:nil];
}

- (instancetype)initWithFrontImageSize:(CGSize)size
							 frontImage:(UIImage *)frontImage
							  leftImage:(UIImage *)leftImage
							 rightImage:(UIImage *)rightImage
							 borderType:(MGMultipleImagePath)borderType
							borderColor:(UIColor *)borderColor
							borderWidth:(CGFloat)borderWidth
{
	//Calculate the frame of the side views
	CGFloat frameWidthSideImage = size.width*kMGPercentageSmallerImage/100.0;
	
	//Sides views are for 2/5 hidden behind the front view, and 3/5 visible
	CGFloat frameWidthSideImageVisible = frameWidthSideImage*kMGVisibleSideImageWidthFactor;
	
    self = [super init];
    if (self) {
        // Initialization code
        _frontImage = frontImage;
        _leftImage = leftImage;
        _rightImage = rightImage;
        _borderType = borderType;
        _borderColor = borderColor;
		_borderWidth = borderWidth;
		
		//Calculate the total size
		_sizeFrontImage = size;
		_sizeSideImage = CGSizeMake(frameWidthSideImage, frameWidthSideImage);
		_totalSize = CGSizeMake(size.width + 2 * frameWidthSideImageVisible, size.height);
    }
    return self;
}

+ (UIImage *)multipleImageWithFrontImageSize:(CGSize)size
								   frontImage:(UIImage *)frontImage
									leftImage:(UIImage *)leftImage
								   rightImage:(UIImage *)rightImage
								   borderType:(MGMultipleImagePath)borderType
								  borderColor:(UIColor *)borderColor
								  borderWidth:(CGFloat)borderWidth
{
	
	MGMultipleImageBuilder *builder = [[MGMultipleImageBuilder alloc] initWithFrontImageSize:size
																				   frontImage:frontImage
																					leftImage:leftImage
																				   rightImage:rightImage
																				   borderType:borderType
																				  borderColor:borderColor
																				  borderWidth:borderWidth];
	
	return [builder drawImage];
}

- (UIImage *)drawImage
{
	//Total rect
	CGRect rect = CGRectZero;
    rect.size = _totalSize;
    
	//Rect left Image
	CGRect rectLeftImage = CGRectZero;
	rectLeftImage.origin.y = (_totalSize.height-_sizeSideImage.height)/2.0;
    rectLeftImage.size = _sizeSideImage;
	
	//Rect right Image
	CGRect rectRightImage = CGRectZero;
	rectRightImage.origin.x = _totalSize.width-_sizeSideImage.width;
	rectRightImage.origin.y = (_totalSize.height-_sizeSideImage.height)/2.0;
    rectRightImage.size = _sizeSideImage;
	
	//Rect front Image
    CGRect rectFrontImage = CGRectZero;
	rectFrontImage.origin.x = (_totalSize.width-_sizeFrontImage.width)/2.0;
    rectFrontImage.size = _sizeFrontImage;
    
	
	
	//Design the sides images
    UIGraphicsBeginImageContextWithOptions(rect.size,0,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    switch (_borderType) {
        case MGMultipleImagePathCircle: {
			CGContextAddEllipseInRect(ctx, rectLeftImage);
			CGContextAddEllipseInRect(ctx, rectRightImage);
		}
            break;
        case MGMultipleImagePathSquare: {
			CGContextAddRect(ctx, rectLeftImage);
			CGContextAddRect(ctx, rectRightImage);
		}
            break;
        default:
            break;
    }
	

	CGContextClip(ctx);
	
	[_leftImage drawInRect:rectLeftImage];
	[_rightImage drawInRect:rectRightImage];
	
	CGContextSetStrokeColorWithColor(ctx, [_borderColor CGColor]);
    CGContextSetLineWidth(ctx, _borderWidth);
	
	switch (_borderType) {
        case MGMultipleImagePathCircle: {
			CGContextStrokeEllipseInRect(ctx, rectLeftImage);
			CGContextStrokeEllipseInRect(ctx, rectRightImage);
		}
            break;
        case MGMultipleImagePathSquare: {
			CGContextStrokeRect(ctx, rectLeftImage);
			CGContextStrokeRect(ctx, rectRightImage);
		}
            break;
        default:
            break;
    }
	
	UIImage *imageSide = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
	
	
	
	//Design the center image
	UIGraphicsBeginImageContextWithOptions(rect.size,0,0);
    ctx = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(ctx, [_borderColor CGColor]);
    CGContextSetLineWidth(ctx, _borderWidth);

	switch (_borderType) {
        case MGMultipleImagePathCircle: {
			CGContextAddEllipseInRect(ctx, rectFrontImage);
		}
            break;
        case MGMultipleImagePathSquare: {
			CGContextAddRect(ctx, rectFrontImage);
		}
            break;
        default:
            break;
    }
	
	
	CGContextClip(ctx);
	
	[_frontImage drawInRect:rectFrontImage];
	
	switch (_borderType) {
        case MGMultipleImagePathCircle: {
			CGContextStrokeEllipseInRect(ctx, rectFrontImage);
		}
            break;
        case MGMultipleImagePathSquare: {
			CGContextStrokeRect(ctx, rectFrontImage);
		}
            break;
        default:
            break;
    }
	
	UIImage *imageFront = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
	
	
	
	//Final merge
	UIGraphicsBeginImageContextWithOptions(rect.size,0,0);
	
	[imageSide drawInRect:rect];
	[imageFront drawInRect:rect];
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
	
	return image;
}


@end
