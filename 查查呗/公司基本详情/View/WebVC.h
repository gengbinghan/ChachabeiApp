//
//  WebVC.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CompanyDetail;

@interface WebVC : UITableViewCell

@property (nonatomic,strong) CompanyDetail * companyDetail;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
