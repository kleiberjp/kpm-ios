//
//  ProductsTableViewController.m
//  kpm
//
//  Created by Kleiber J Perez on 24/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//
#import "ProductsTableViewController.h"
#import "NSString+StringExtension.h"
#import "ProductItem.h"
#import "ProductViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+RJLoader.h"
#import "UIViewController+ViewControllerExtension.h"
#import "UIImage+ImageExtension.h"

@interface ProductsTableViewController ()

@end

@implementation ProductsTableViewController

NSMutableArray *productsToUpdate;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.services = [[RestServices alloc] initWithSuperView:self];
    self.products = [[NSMutableArray alloc] init];
    self.tableView.layer.masksToBounds = NO;
    self.tableView.clipsToBounds = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadDataProductList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setComponentsUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Method generics for UI

-(void) setComponentsUI{
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Logout"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(showAlertLogout)];
    logoutButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Upload"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doUpdate)];
    uploadButton.tintColor = [UIColor whiteColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:77.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    [self.navigationItem setTitle:[NSString getMessageText:@"title-list-products"]];
    [self.navigationItem setRightBarButtonItem:uploadButton];
    [self.navigationItem setLeftBarButtonItem:logoutButton];
    
}


- (void) loadDataProductList{
    self.products = [self.services.userDefaults getListProduct];
    productsToUpdate = [self.services.userDefaults getListProductToUpdate];
    if (self.products == nil || self.products.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.products = [self.services getProducts];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }else{
        [self showLoadingView];
        [self.tableView reloadData];
        [self hideLoadingView];
    }
}

-(void) doUpdate{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.services updateProducts];
    });
    
}

- (void) updateProductsLocalforId:(NSString *)idObject withQuantity:(NSString *)qty{
    if (productsToUpdate == nil || productsToUpdate.count == 0) {
        NSDictionary *item = @{@"idProduct":idObject, @"quantity": qty};
        [productsToUpdate addObject:item];
    }else{
        NSMutableArray *items = [productsToUpdate valueForKey:@"idProduct"];
        if ([items containsObject:idObject]) {
            NSMutableDictionary *newItem = [[NSMutableDictionary alloc] init];
            NSDictionary *item = [productsToUpdate objectAtIndex:[items indexOfObject:idObject]];
            [newItem addEntriesFromDictionary:item];
            [newItem setObject:qty forKey:@"quantity"];
            [productsToUpdate replaceObjectAtIndex:[items indexOfObject:idObject] withObject:newItem];
        } else {
            NSDictionary *item = @{@"idProduct":idObject, @"quantity": qty};
            [productsToUpdate addObject:item];
        }
    }
    
    [self.services.userDefaults setListProductsToUpdate:productsToUpdate];
}

-(void)showAlertLogout{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString getMessageText:@"title-logout"]
                                                                             message:[NSString getMessageText:@"message-logout"]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *_continue = [UIAlertAction actionWithTitle:[NSString getMessageText:@"continue-button"]
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [self doLogout];
                                                      }];
    
    UIAlertAction *_cancel = [UIAlertAction actionWithTitle:[NSString getMessageText:@"cancel-button"]
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [alertController dismissViewControllerAnimated:YES
                                                                                            completion:nil];
                                                    }];
    
    
    [alertController addAction:_continue];
    [alertController addAction:_cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



-(void) doLogout{
    [self showLoadingView];
    [self.services.userDefaults setAlreadyLoged:NO];
    [self.services.userDefaults setPasswordUserIncome:@""];
    [self performSegueWithIdentifier:@"backToLogin" sender:self];
}

- (void) addItemQuantity:(UIButton *) sender{
    
    ProductItem *item = [self.products objectAtIndex:sender.tag];
    NSString *message = [NSString stringWithFormat:[NSString getMessageText:@"message-alert-add"], item.name];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    ProductViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString getMessageText:@"title-alert-item"]
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *_continue = [UIAlertAction actionWithTitle:[NSString getMessageText:@"yes-button"]
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          int value = [item.quantity intValue] + 1;
                                                          item.quantity = [NSString stringWithFormat:@"%d", value];
                                                          [self.products replaceObjectAtIndex:sender.tag withObject:item];
                                                          [self updateProductsLocalforId:item.objectId withQuantity:item.quantity];
                                                          [self.services.userDefaults setListProducts:self.products];
                                                          cell.lblProductQty.text = [NSString stringWithFormat:@"%d", value];
                                                          [alertController dismissViewControllerAnimated:YES
                                                                                              completion:nil];
                                                          
                                                      }];
    
    UIAlertAction *_cancel = [UIAlertAction actionWithTitle:[NSString getMessageText:@"cancel-button"]
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [alertController dismissViewControllerAnimated:YES
                                                                                            completion:nil];
                                                    }];
    
    
    [alertController addAction:_continue];
    [alertController addAction:_cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ProductItem";
    
    ProductViewCell *cell = (ProductViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    ProductItem *item = [self.products objectAtIndex:indexPath.row];
    cell.imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    
    if (item.image) {
        cell.imgProduct.image = item.image;
    }else{
        NSURL *url = [NSURL URLWithString:item.imageURL];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(queue, ^(void) {
            UIImage *notImg = [[UIImage imageNamed:@"ImgNotAvaliable"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            notImg = [notImg imageTintedWithColor:[UIColor colorWithRed:0.302 green:0.765 blue:0.643 alpha:1]];
            [cell.imgProduct startLoaderWithTintColor:[UIColor colorWithRed:0.302 green:0.765 blue:0.643 alpha:1]];
            [cell.imgProduct sd_setImageWithURL:url
                               placeholderImage:notImg
                                        options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached
                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                           [cell.imgProduct updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
                                       }
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          if (image) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  item.image = image;
                                                  [self.products replaceObjectAtIndex:indexPath.row withObject:item];
                                                  [self.services.userDefaults setListProducts:self.products];
                                                  cell.imgProduct.image = image;
                                                  [cell.imgProduct reveal];
                                                  [cell setNeedsLayout];
                                              });
                                          }
                                      }
             ];
        });
    }

    UIImageView *addIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    addIcon.tintColor = [UIColor colorWithRed:0.302 green:0.765 blue:0.643 alpha:1];
    [cell.btnProductAdd addSubview:addIcon];
    cell.tag = indexPath.row;
    cell.lblProductName.text = item.name;
    cell.lblProductCost.text = item.price;
    cell.lblProductQty.text = item.quantity;
    
    cell.btnProductAdd.tag = indexPath.row;
    [cell.btnProductAdd addTarget:self action:@selector(addItemQuantity:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
