//
//  ParentViewController.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "ParentViewController.h"
#import "NSString+StringExtension.h"
#import "UITextField+TextFieldExtension.h"

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideKeyboardOnTap];
    [self setServices:[[RestServices alloc] initWithSuperView:self]];
}

- (void)viewDidAppear:(BOOL)animated {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *) view;
            [(UIScrollView *) view setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, (CGFloat) ([UIScreen mainScreen].bounds.size.height + 200.0))];
            [(UIScrollView *) view setDelaysContentTouches:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self unregisterKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma methods for keyboard

- (void)hideKeyboardOnTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardOnTapGesture:)];
    tap.cancelsTouchesInView = NO;
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)hideKeyboardOnTapGesture:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


- (void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

- (void)unregisterKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    self.keyboardIsShowing = YES;
    self.keyboardFrame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self moveViewOnKeyboardHide];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    self.keyboardIsShowing = NO;
    [self returnToOriginalFrame];
}

- (void)moveViewOnKeyboardHide {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, (CGFloat) (self.keyboardFrame.size.height + 55.0), 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect view = self.scrollView.frame;
    view.size.height -= self.keyboardFrame.size.height;
    
    if (!CGRectContainsPoint(view, self.activeTextField.frame.origin)) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.scrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
        }];
    }
}

- (void)returnToOriginalFrame {
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

#pragma methods generics

- (void)hideNavigationBar{
    if (self.navigationController) {
        self.navigationController.navigationBarHidden = YES;
    }
}

- (BOOL)validateEmptyField:(UITextField *)uiTextField {
    return ![NSString isEmpty:uiTextField.text];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.activeTextField) {
        [self.activeTextField resignFirstResponder];
        self.activeTextField = nil;
    }
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return !([touch.view isKindOfClass:[UIControl class]] ||
             [touch.view isKindOfClass:[UITableViewCell class]] ||
             [touch.view.superview isKindOfClass:[UITableViewCell class]]);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = self.activeTextField.tag + 1;
    
    // Se ubica el siguiente responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    self.activeTextField = (UITextField *)nextResponder;
    if (nextResponder) {
        // Encontrado el next Responder se setea
        [nextResponder becomeFirstResponder];
    } else {
        // No encontrado se hace dismiss keyboard
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField removeErrors];
    self.activeTextField = textField;
    if (self.keyboardIsShowing) {
        [self moveViewOnKeyboardHide];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeTextField = nil;
}

@end
