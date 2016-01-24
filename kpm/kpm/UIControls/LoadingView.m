//
//  LoadingView.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithView:(UIView *)toView{
    
    self = [[LoadingView alloc] initWithFrame:toView.bounds];
    if(!self) return nil;
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    localView = toView;
    self.loadingLabel = [[UILabel alloc] init];
    
    CGRect labelFrame = CGRectMake(0, 0, self.bounds.size.width - 60, 50);
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        localView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = localView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:blurEffectView];
    }
    else {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    
    self.loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.loadingLabel.textColor = [UIColor lightGrayColor];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.font = [self.loadingLabel.font fontWithSize:14];
    self.loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.backgroundColor = [UIColor clearColor];
    indicatorView.color = [UIColor lightGrayColor];
    indicatorView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [indicatorView startAnimating];
    
    CGFloat totalHeight = self.loadingLabel.frame.size.height + indicatorView.frame.size.height;
    labelFrame.origin.x = floor(0.5 * (self.frame.size.width - (self.frame.size.width-60)));
    labelFrame.origin.y = floor(0.5 * (self.frame.size.height - totalHeight));
    self.loadingLabel.frame = labelFrame;
    
    CGRect activityIndicatorRect = indicatorView.frame;
    activityIndicatorRect.origin.x = 0.5 * (self.frame.size.width - activityIndicatorRect.size.width);
    activityIndicatorRect.origin.y = self.loadingLabel.frame.origin.y + self.loadingLabel.frame.size.height;
    indicatorView.frame = activityIndicatorRect;
    

    [self addSubview:indicatorView];
    [self addSubview:self.loadingLabel];
    
    return self;
}

-(void)showLoadingView{
    [indicatorView startAnimating];
    [localView addSubview:self];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    
    [[localView layer] addAnimation:animation forKey:@"layerAnimation"];
}

-(void)removeLoadingView{
    UIView *superview = [self superview];
    [super removeFromSuperview];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    
    [[superview layer] addAnimation:animation forKey:@"layerAnimation"];
}

@end
