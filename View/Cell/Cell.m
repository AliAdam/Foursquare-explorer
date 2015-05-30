//
//  Cell.m
//  MR.SA
//
//  Created by ali adam on 27/3/14.
//  Copyright (c) 2014 ali adam. All rights reserved.
//

#import "Cell.h"

@implementation Cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
