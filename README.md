MGMultipleImageBuilder
======================

MGMultipleImageBuilder is a builder which allow you to create multi-face avatar such as that for a group chat.

<img src='http://www.matteogobbi.it/files-hosting/MGMultipleImageBuilder.png' width='260'/>

## Info

This code must be used under ARC. 
If your code doesn't use ARC you can [mark this source with the compiler flag](http://www.codeography.com/2011/10/10/making-arc-and-non-arc-play-nice.html) `-fobjc-arc` 

## Example Usage

```objective-c
//Create image
UIImage *image = [MGMultipleImageBuilder multipleImageWithFrontImageSize:CGSizeMake(80, 80) 
							      frontImage:frontImage 
							       leftImage:leftImage 
							      rightImage:rightImage 
							      borderType:MGMultipleImagePathCircle 
							     borderColor:[UIColor blueColor] 
							     borderWidth:3.0];
```
