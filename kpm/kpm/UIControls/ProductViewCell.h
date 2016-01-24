//
//  ProductViewCell.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductCost;
@property (weak, nonatomic) IBOutlet UILabel *lblProductQty;
@property (weak, nonatomic) IBOutlet UIButton *btnProductAdd;

@end
