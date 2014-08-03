//
//  MGViewController.m
//  MGMultipleImageExample
//
//  Created by admin on 29/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGViewController.h"
#import "MGMultipleImageBuilder.h"

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
    //Get images
	UIImage *frontImage = [UIImage imageNamed:@"face1"];
	UIImage *leftImage = [UIImage imageNamed:@"face2"];
	UIImage *rightImage = [UIImage imageNamed:@"face3"];
	
    //Create image
	UIImage *image = [MGMultipleImageBuilder multipleImageWithFrontImageSize:CGSizeMake(80, 80)
																  frontImage:frontImage
																   leftImage:leftImage
																  rightImage:rightImage
                                                                borderType:MGMultipleImagePathCircle
																 borderColor:[UIColor blueColor]
																 borderWidth:3.0];
	
    //Add image
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];
	[imageView setCenter:self.view.center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
