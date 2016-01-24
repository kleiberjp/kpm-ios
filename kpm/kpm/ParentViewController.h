//
//  ParentViewController.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestServices.h"

@interface ParentViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

#define kPreferredTextFieldToKeyboardOffset 20.0

@property(nonatomic) CGRect keyboardFrame;
@property(nonatomic) BOOL keyboardIsShowing;
@property(weak, nonatomic) UITextField *activeTextField;
@property(weak, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) RestServices *services;


#pragma methods keyboard actions
- (void)registerKeyboardNotifications;
- (void)unregisterKeyboardNotifications;
- (void)hideKeyboardOnTap;
- (void)hideKeyboard;

#pragma methods generic view controller
- (void)hideNavigationBar;
- (BOOL)validateEmptyField:(UITextField *)uiTextField;


@end
