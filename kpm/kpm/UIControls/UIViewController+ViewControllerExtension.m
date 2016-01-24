//
//  UIViewController+ViewControllerExtension.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "UIViewController+ViewControllerExtension.h"
#import "UIView+ViewExtension.h"
#import "NSString+StringExtension.h"
#import <objc/runtime.h>

static char const *const errorPropertyKey = "errorPropertyKey";

@implementation UIViewController (ViewControllerExtension)

@dynamic loadingView;

- (void)setLoadingView:(LoadingView *)loadingView {
    objc_setAssociatedObject(self, errorPropertyKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LoadingView *)loadingView {
    return objc_getAssociatedObject(self, errorPropertyKey);
}


- (void)showLoadingView {
    self.loadingView = [[LoadingView alloc] initWithView:self.view.superview.window];
    self.loadingView.loadingLabel.text = [NSString getMessageText:@"wait"];
    [self.loadingView showLoadingView];
}

- (void)hideLoadingView {
    if (self.loadingView) {
        [self.loadingView performSelector:@selector(removeLoadingView) withObject:nil afterDelay:0.0];
    }
}


-(void) showAlert:(NSString *) title withMessage:(NSString *) message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      [alertController dismissViewControllerAnimated:YES
                                                                                          completion:nil];
                                                  }];
    
    [alertController addAction:alert];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
