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
    [self setContainerView:[[UIView alloc] init]];
    [self setIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]];
    [self setLocalView:toView];
    [self setLoadingLabel:[[UILabel alloc] init]];
    
    const CGFloat DEFAULT_LABEL_WIDTH = toView.frame.size.width - 60;
    const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
    CGRect labelFrame = CGRectMake(0,0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
    
    self.loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.loadingLabel.textColor = [UIColor lightGrayColor];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.font = [self.loadingLabel.font fontWithSize:14];
    self.loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.backgroundColor = [UIColor clearColor];
    self.indicatorView.color = [UIColor lightGrayColor];
    self.indicatorView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.indicatorView startAnimating];
    
    CGFloat totalHeight = self.loadingLabel.frame.size.height + self.indicatorView.frame.size.height;
    labelFrame.origin.x = floor(0.5 * (self.frame.size.width - DEFAULT_LABEL_WIDTH));
    labelFrame.origin.y = floor(0.5 * (self.frame.size.height - totalHeight));
    self.loadingLabel.frame = labelFrame;
    
    CGRect activityIndicatorRect = self.indicatorView.frame;
    activityIndicatorRect.origin.x = 0.5 * (self.frame.size.width - activityIndicatorRect.size.width);
    activityIndicatorRect.origin.y = self.loadingLabel.frame.origin.y + self.loadingLabel.frame.size.height;
    self.indicatorView.frame = activityIndicatorRect;
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.localView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.blurEffectView.frame = self.localView.bounds;
        self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:self.blurEffectView];
    }
    else {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    
    [self addSubview:self.indicatorView];
    [self addSubview:self.loadingLabel];
    
    return self;
}

-(void)showLoadingView{
    [self.indicatorView startAnimating];
    [self.localView addSubview:self];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    
    [[self.localView layer] addAnimation:animation forKey:@"layerAnimation"];
}

-(void)removeLoadingView{
    UIView *superview = [self superview];
    [super removeFromSuperview];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    
    [[superview layer] addAnimation:animation forKey:@"layerAnimation"];
}

@end
