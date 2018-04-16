//
//  LLHouseMessageVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/29.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLHouseMessageVC.h"
#import "LLHouseMessageView.h"
#import "LLHouseMessageCell.h"
@interface LLHouseMessageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIView *navView;//导航栏

@property (nonatomic, strong)UIView *homeView;

@property (nonatomic,strong)LLHouseMessageView *houseMessageView;

@property (nonatomic,strong)UITableView *tableView;//

@property (nonatomic,strong)NSMutableArray *addressAry;
@property (nonatomic,strong)NSMutableArray *typeAry;

@end

@implementation LLHouseMessageVC
//懒加载
- (LLHouseMessageView *)houseMessageView
{
    if (!_houseMessageView) {
        _houseMessageView = [LLHouseMessageView loadFromNib];
        
    }
    return _houseMessageView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.houseMessageView.detailBtn.frame), CGRectGetMaxY(self.houseMessageView.detailBtn.frame) + 70, CGRectW(self.houseMessageView.detailBtn), 120)];
        
        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNav];
    [self initializationHomeView];
}

//设置自定义导航栏
- (void)settingNav
{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self.view), 64)];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navBar];
    //    self.navBar.titleLB.text = @"忘记密码";
    [self.navBar setingNavSize:self.navView];
    self.navBar.titleLB.hidden = YES;
    //    self.navBar.backBtn.hidden = ;
    
}
//初始化界面
- (void)initializationHomeView {
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectW(self.view), CGRectH(self.view) - 64)];
    self.homeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.homeView];
    
    [self.homeView addSubview:self.houseMessageView];
    [self.houseMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
        [self.houseMessageView.detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];//地址按钮点击事件
    [self.houseMessageView.typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];//产权按钮点击事件
    
}
- (void)detailBtnClick:(UIButton *)sender{

    [self settingTableView];
    CGRect fm = self.tableView.frame;
    fm.origin.x = CGRectGetMinX(sender.frame);
    fm.origin.y = CGRectGetMaxY(sender.frame) + 70;
    self.tableView.frame = fm;
}

- (void)typeBtnClick:(UIButton *)sender{
    
    [self settingTableView];
    CGRect fm = self.tableView.frame;
    fm.origin.x = CGRectGetMinX(sender.frame);
    fm.origin.y = CGRectGetMaxY(sender.frame) + 70;
    self.tableView.frame = fm;
}

- (void)settingTableView
{
    if (self.tableView.hidden == YES) {
        self.tableView.hidden = NO;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
#define mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return  5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    LLHouseMessageCell *cell = [LLHouseMessageCell showScreenCell];
    cell.titleLB.text = @"1111";
//    cell.shopTitleLB.text = [self.respModel.body[row] title];
//    [cell.shopHeadImg sd_setImageWithURL:[NSURL URLWithString:[self.respModel.body[row] logo]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.hidden = YES;
//    NSInteger row = indexPath.row;
//    self.uniacid = [self.respModel.body[row] id];
//    self.shopHeadRest = [self.respModel.body[row] is_rest];
//    self.shopHeadImg = [self.respModel.body[row] logo];
//    [self.loginView.shopListBtn setTitle:[self.respModel.body[row] title]  forState:UIControlStateNormal];
}
@end
