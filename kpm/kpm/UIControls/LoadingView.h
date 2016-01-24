//
//  LoadingView.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property UILabel *loadingLabel;
@property UIView *localView, *containerView;
@property UIActivityIndicatorView *indicatorView;
@property UIVisualEffectView *blurEffectView;

-(id) initWithView:(UIView *)toView;
-(void) showLoadingView;
-(void) removeLoadingView;

@end
