//
//  Cell.h
//  MR.SA
//
//  Created by ali adam on 27/3/14.
//  Copyright (c) 2014 ali adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *Body;
@property (weak, nonatomic) IBOutlet NSString *complainid;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *num_com;
@property (weak, nonatomic) IBOutlet UIButton *num_like;
@property (weak, nonatomic) IBOutlet UIButton *num_view;
@property (weak, nonatomic) IBOutlet UIButton *created;
@property (weak, nonatomic) IBOutlet UIImageView *complain_image;
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UIImageView *left_image;



//////
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@end