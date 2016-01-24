//
//  UIView+ViewExtension.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "UIView+ViewExtension.h"

@implementation UIView (ViewExtension)

-(UIImage *)getBackgroundImage
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
    
}

@end
