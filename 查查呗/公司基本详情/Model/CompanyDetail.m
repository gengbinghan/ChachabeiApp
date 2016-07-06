//
//  CompanyDetail.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "CompanyDetail.h"

@implementation CompanyDetail

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [super init]) {
        
        self.company_name = dictionary[@"company_name"];
        self.regist_no = dictionary[@"regist_no"];
        self.registdepartment = dictionary[@"registdepartment"];
        self.establish_data = dictionary[@"establishment_date"];
        self.company_type = dictionary[@"company_type"];
        self.scope = dictionary[@"scope"];
        self.address = dictionary[@"address"];
        self.corporation = dictionary[@"corporation"];
        self.capital = dictionary[@"capital"];
        self.stockholder = dictionary[@"stockholderDetails"];
        self.member = dictionary[@"member"];
        self.branch = dictionary[@"branch"];
        self.modify = dictionary[@"modify"];
        self.busniss_alloted_time_later = dictionary[@"busniss_alloted_time_later"];
        self.busniss_alloted_time_start = dictionary[@"busniss_alloted_time_start"];
    }
    
    return self;
}

@end
