//
//  Cell.h
//  MR.SA
//
//  Created by ali adam on 27/3/14.
//  Copyright (c) 2014 ali adam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AsyncImageView.h"
@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Distance;
@property (weak, nonatomic) IBOutlet UILabel *Address;

@property (weak, nonatomic) IBOutlet AsyncImageView *image;
@end