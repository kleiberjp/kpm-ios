//
//  UIViewController+ViewControllerExtension.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@interface UIViewController (ViewControllerExtension)

@property(retain, nonatomic) LoadingView *loadingView;

- (void)showLoadingView;

- (void)hideLoadingView;

-(void) showAlert:(NSString *) title withMessage:(NSString *) message;

@end
