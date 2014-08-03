//
//  MGMultipleBuilderImage.h
//  MGMultipleImageExample
//
//  Created by admin on 29/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, MGMultipleImagePath) {
	MGMultipleImagePathCircle,
	MGMultipleImagePathSquare
};

@interface MGMultipleImageBuilder : NSObject

@property (strong, nonatomic) UIImage *frontImage;
@property (strong, nonatomic) UIImage *leftImage;
@property (strong, nonatomic) UIImage *rightImage;
@property (assign) MGMultipleImagePath borderType;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign) CGFloat borderWidth;

- (instancetype)initWithFrontImageSize:(CGSize)size
							 frontImage:(UIImage *)frontImage
							  leftImage:(UIImage *)leftImage
							 rightImage:(UIImage *)rightImage
							 borderType:(MGMultipleImagePath)borderType
							borderColor:(UIColor *)borderColor
							borderWidth:(CGFloat)borderWidth;

- (UIImage *)drawImage;

+ (UIImage *)multipleImageWithFrontImageSize:(CGSize)size
								   frontImage:(UIImage *)frontImage
									leftImage:(UIImage *)leftImage
								   rightImage:(UIImage *)rightImage
								   borderType:(MGMultipleImagePath)borderType
								  borderColor:(UIColor *)borderColor
								  borderWidth:(CGFloat)borderWidth;


@end
