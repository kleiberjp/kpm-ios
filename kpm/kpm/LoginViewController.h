//
//  ViewController.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "ParentViewController.h"

@interface LoginViewController : ParentViewController

@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end

