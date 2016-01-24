//
//  ProductsTableViewController.h
//  kpm
//
//  Created by Kleiber J Perez on 24/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestServices.h"

@interface ProductsTableViewController : UITableViewController

@property (nonatomic, strong) RestServices *services;
@property (nonatomic, retain) NSMutableArray *products;

@end
