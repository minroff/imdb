//
//  ASMyCell.h
//  imdbAppTest0
//
//  Created by Vasiliy Kotov on 27.06.14.
//  Copyright (c) 2014 Vasiliy Kotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASMyCell : UITableViewCell {
    UILabel* titleLabel;
    UILabel* countryOrYearLabel;
    UIImageView* posterImg;
    UIImageView* mark;
    UILabel* plot;
}

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UILabel* countryOrYearLabel;
@property (nonatomic, retain) IBOutlet UIImageView* posterImg;
@property (nonatomic, retain) IBOutlet UILabel* plot;
@property (nonatomic, retain) IBOutlet UIImageView *mark;

@end
