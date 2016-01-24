//
//  LoadingView.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView{
    UIView *localView;
    UIActivityIndicatorView *indicatorView;
    UIVisualEffectView *blurEffectView;
}

@property UILabel *loadingLabel;

-(id) initWithView:(UIView *)toView;
-(void) showLoadingView;
-(void) removeLoadingView;

@end
