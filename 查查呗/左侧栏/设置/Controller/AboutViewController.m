//
//  AboutViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate * app;
    NSString * _uid;
    NSString * _request;
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;

}

@property (weak, nonatomic) IBOutlet UITableView *aboutTableView;

@property(nonatomic,strong) NSArray * aboutArray;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    [self loadData];
}
//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar;
    self.title=@"用户协议";
    //为导航栏添加左侧按钮
    Backbutton;
    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-35, 0, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"app04.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(remindButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)loadData
{
    app = [AppDelegate sharedAppDelegate];
    
    _uid = app.uid;
    _request = app.request;
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",_request,@"request", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
//        NSLog(@"\n============网络状态：%zd",status);
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:Home_Agreement_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
//                NSLog(@"用户协议:%@",responseObject[@"result"]);
                self.aboutArray = [aboutModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                app.request = responseObject[@"response"];
                
                [self.aboutTableView reloadData];

            }];

        }else{
            
            noWebhud;

        }
    }];

    
}

-(void)remindButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.aboutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"数组:%@",self.aboutArray);
    
    aboutViewCell * cell=[aboutViewCell cellWithTableView:tableView];

    cell.about = self.aboutArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    aboutModel * about = self.aboutArray[indexPath.row];
    return about.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}

@end
