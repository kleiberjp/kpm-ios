//
//  ViewController.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//
#import "LoginViewController.h"
#import "NSString+StringExtension.h"
#import "UITextField+TextFieldExtension.h"
#import "UIViewController+ViewControllerExtension.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize tfUserName = _tfUserName, tfPassword = _tfPassword;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hideNavigationBar];
}

- (void)viewDidLoad {
    [self hideKeyboardOnTap];
    [super registerKeyboardNotifications];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tfUserName resignFirstResponder];
    if (![[self.services.userDefaults getLastUserIncome] isEqualToString:@""]) {
        [self.tfUserName setText:[self.services.userDefaults getLastUserIncome]];
        [self.tfPassword setText:[self.services.userDefaults getPasswordUserIncome]];
        [self doLogin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [super unregisterKeyboardNotifications];
}

- (IBAction)loginUser:(id)sender {
    [self doLogin];
}

-(void) doLogin{
    [super hideKeyboard];
    if ([self validarCampos]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL result= [self.services loginUser:self.tfUserName.text withPassword:self.tfPassword.text];
            if (result) {
                [super showAlert:@"INFO" withMessage:@"Login Success"];
                //[self performSegueWithIdentifier:@"goToMain" sender:self];
                return;
            }
        });
    }
}


#pragma methods general use controller

- (BOOL) validarCampos {
    BOOL camposValidos = YES;
    BOOL error = NO;
    
    if (![self validateEmptyField: self.tfPassword]) {
        [self.tfPassword becomeFirstResponder];
        [self.tfPassword setError:[NSString getMessageTextError:@"field-required"]];
        error = YES;
    }
    
    if (![self validateEmptyField:self.tfUserName]) {
        [self.tfUserName becomeFirstResponder];
        [self.tfUserName setError:[NSString getMessageTextError:@"field-required"]];
        error = YES;
    } else {
        if (![self validateEmail:self.tfUserName]) {
            [self.tfUserName becomeFirstResponder];
            [self.tfUserName setError:[NSString getMessageTextError:@"mail-invalid"]];
            error = YES;
        }
    }
    
    if (error) {
        camposValidos = NO;
    }
    
    return camposValidos;
}


@end
