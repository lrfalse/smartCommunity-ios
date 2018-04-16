//
//  LLSelectCommunity.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLSelectCommunity.h"
#import "LLSelectCommunityView.h"
#import "LLSelectCityCell.h"
#import "LLHouseMessageVC.h"
@interface LLSelectCommunity ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *navView;//导航栏

@property (nonatomic, strong)UIView *homeView;

@property (nonatomic,strong)LLSelectCommunityView *selectCommunityView;


@property (nonatomic,strong)NSMutableArray *ary;
@end

@implementation LLSelectCommunity
//懒加载
- (LLSelectCommunityView *)selectCommunityView
{
    if (!_selectCommunityView) {
        _selectCommunityView = [LLSelectCommunityView loadFromNib];
        
    }
    return _selectCommunityView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self initializationHomeView];
    
    self.ary = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
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
    
    [self.homeView addSubview:self.selectCommunityView];
    [self.selectCommunityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
    self.selectCommunityView.cityListTableView.delegate = self;
    self.selectCommunityView.cityListTableView.dataSource = self;
//    [self.selectCommunityView.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];//下一步按钮点击事件
    
}
#define mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return  self.ary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    LLSelectCityCell *cell = [LLSelectCityCell showScreenCell];
//    cell.nameLB.text = [self.responseArrModel.result[row] shopName];
    [self.ary[row] isEqualToString:@"1"] ? (cell.selectBtn.selected = YES) :  (cell.selectBtn.selected = NO);
//    [self.selectAry[row] isEqualToString:@"0"] ? ([cell.nameLB setTextColor:[UIColor blackColor]]) :  ([cell.nameLB setTextColor:[UIColor orangeColor]]);
    //    cell.titleLB.text = self.Model.titleAry[row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    NSString *str = @"0";
    for (int i = 0; i < self.ary.count; i ++) {
        [self.ary replaceObjectAtIndex:i withObject:str];
    }
    [self.ary replaceObjectAtIndex:row withObject:@"1"];
    [self.selectCommunityView.cityListTableView reloadData];
    
    LLHouseMessageVC *vc = [LLHouseMessageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
