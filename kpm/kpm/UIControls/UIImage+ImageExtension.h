//
//  UIImage+ImageExtension.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageExtension)

#pragma Mark - Methods for effects for image

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
- (UIImage *)cropImage:(CGRect)rect;
- (UIImage *)blurWithImageEffects;

#pragma Mark - Methods for changing aspect image

- (UIImage *)imageTintedWithColor:(UIColor *)color;


@end
