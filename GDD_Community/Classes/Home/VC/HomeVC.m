//
//  HomeVC.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/14.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "HomeVC.h"
#import <AFNetworking.h>
#import "NSString+AES.h"
#import "LLHomeView.h"
#import "ImagePlayerView.h"
#import "LLHomeMenuView.h"
#import <SDCycleScrollView.h>
#import "HomeListCell.h"
#import "HomeListHeadView.h"
#import "HomeBulkCell.h"
@interface HomeVC ()<ImagePlayerViewDelegate,SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *navView;//导航栏
@property (nonatomic, strong)UIView *homeView;
@property (nonatomic,strong)LLHomeView *homeShowView;
@property (nonatomic,strong)LLHomeMenuView *homeMenuView;

@property (strong, nonatomic)ImagePlayerView *imagePlayerView;//顶部轮播
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) NSArray *imageURLs;


@property (strong, nonatomic)HomeListHeadView *homeListHeadView;//活动头部View
//@property (strong, nonatomic)ImagePlayerView *imagePlayerVieww;//社区活动轮播
//@property (nonatomic, strong) NSCache *imageCachee;//社区活动
//@property (nonatomic, strong) NSArray *imageURLss;//社区活动
////@property (nonatomic, strong) NSArray *imageArys;
@end

@implementation HomeVC
- (HomeListHeadView *)homeListHeadView
{
    if (!_homeListHeadView) {
        _homeListHeadView = [HomeListHeadView loadFromNib];
        
    }
    return _homeListHeadView;
}
- (LLHomeMenuView *)homeMenuView
{
    if (!_homeMenuView) {
        _homeMenuView = [LLHomeMenuView loadFromNib];
        
    }
    return _homeMenuView;
}
//懒加载
- (LLHomeNavView *)homeNavBar
{
    if (!_homeNavBar) {
        _homeNavBar = [LLHomeNavView loadFromNib];
        
    }
    return _homeNavBar;
}

- (LLHomeView *)homeShowView
{
    if (!_homeShowView) {
        _homeShowView = [LLHomeView loadFromNib];
        self.imagePlayerView = (ImagePlayerView *)_homeShowView.headAdvertisingView;
        _homeShowView.headAdvertisingView = self.imagePlayerView;
        _homeShowView.listTabView.delegate = self;
        _homeShowView.listTabView.dataSource = self;
        _homeShowView.bulkCollecitionView.delegate = self;
        _homeShowView.bulkCollecitionView.dataSource = self;
        [_homeShowView.bulkCollecitionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeBulkCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeBulkCell"];
        
    }
    return _homeShowView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self settingNav];
    [self initializationHomeView];
    [self initializationplayerView];
    
    NSDictionary *parameters;
    
    parameters = @{@"tag":@"A",@"body":@""};
    
    NSString *kkkk = @"abcd123";
    NSString *encryptStr = [kkkk aci_encryptWithAES];
    NSString *decryptStr = [encryptStr aci_decryptWithAES];
    
    
    NSString *temp = [NSString stringWithFormat:@"{\"type\":\"getpath\",\"path\":\"%@\"}",@""];
    
    NSData *data = [temp dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@",@"http://192.168.1.10:8080/test"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    NSLog(@"requestURL:%@",requestUrl);
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    
    
    [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"~~~");
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"~~~~");
    }];
}

//初始化界面
- (void)initializationHomeView {
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectW(self.view), CGRectH(self.view) - 64)];
//    self.homeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.homeView];
    
    [self.homeView addSubview:self.homeShowView];
    [self.homeShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
    
    [self.homeShowView.openEnvelopeBtn addTarget:self action:@selector(openEnvelopeBtnClick:) forControlEvents:UIControlEventTouchUpInside];//打开红包按钮点击事件
    
    [self.homeShowView.menuView addSubview:self.homeMenuView];
    [self.homeMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeShowView.menuView);
        make.left.mas_equalTo(self.homeShowView.menuView);
        make.size.mas_equalTo(self.homeShowView.menuView);
    }];
    
    
    NSArray *imageNames = @[@"cofee.jpeg",
                            @"cofee.jpeg",
                            @"cofee.jpeg",
                            @"cofee.jpeg",
                            @"cofee.jpeg" // 本地图片请填写全名
                            ];
    // 本地加载 --- 创建不带标题的图片轮播器
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
//    cycleScrollView.delegate = self;
//    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    [demoContainerView addSubview:cycleScrollView];
//    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 100, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    [self.homeShowView.runAdvertisingView addSubview:cycleScrollView];
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeShowView.runAdvertisingView);
        make.left.mas_equalTo(self.homeShowView.runAdvertisingView);
        make.size.mas_equalTo(self.homeShowView.runAdvertisingView);
    }];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
//设置自定义导航栏
- (void)settingNav
{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self.view), 64)];
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.homeNavBar];
////    self.navBar.titleLB.text = @"去逛逛";
    [self.homeNavBar setingNavSize:self.navView];
//    self.homeNavBar.backBtn.hidden = YES;
    
}
#pragma mark - 抢红包按钮点击事件
- (void)openEnvelopeBtnClick:(UIButton *)sender
{
    [self showEnvelope];
}

//轮播图
- (void)initializationplayerView{
    self.imagePlayerView = [[ImagePlayerView alloc]init];
    [self.homeShowView.headAdvertisingView addSubview:self.imagePlayerView];
    [self.imagePlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeShowView.headAdvertisingView);
        make.left.mas_equalTo(self.homeShowView.headAdvertisingView);
        make.size.mas_equalTo(self.homeShowView.headAdvertisingView);
    }];
    _imageCache = [NSCache new];
    self.imageURLs = @[[NSURL URLWithString:@"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=3e5c55d9953df8dcb23087d2a57818fe/d000baa1cd11728b0983d70cc2fcc3cec3fd2c75.jpg"],
                       [NSURL URLWithString:@"http://img10.3lian.com/sc6/show/s11/19/20110711104956189.jpg"],
                       [NSURL URLWithString:@"http://easyread.ph.126.net/StM1y5oXoiqdSYLY7YI3cw==/7916990594848950407.jpg"]];
//    self.imageArys = @[@"cofee.jpeg",@"cofee.jpeg",@"cofee.jpeg"];
    self.imagePlayerView.imagePlayerViewDelegate = self;
    
    // set auto scroll interval to x seconds
    self.imagePlayerView.scrollInterval = 3.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
    
    // endless scroll
    self.imagePlayerView.endlessScroll = YES;
    
    // adjust edgeInset
    //    self.imagePlayerView.edgeInsets = UIEdgeInsetsMake(10, 20, 30, 40);
    
    [self.imagePlayerView reloadData];
}

#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return self.imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    
    if ([self.homeShowView.headAdvertisingView.subviews containsObject:imagePlayerView]) {
        NSLog(@"试图11111");
    }
    NSLog(@"~%ld",(long)index);
    NSURL *imageURL = [self.imageURLs objectAtIndex:index];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *image = [self.imageCache objectForKey:imageURL.absoluteString];
        if (!image) {
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            image = [UIImage imageWithData:imageData];
            [self.imageCache setObject:image forKey:imageURL.absoluteString];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            imageView.image = image;
        });
    });
    
   
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}



#pragma mark - 榜上有名tableview代理
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
    return  3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    HomeListCell *cell = [HomeListCell showScreenCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH, 200)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:self.homeListHeadView];
    [self.homeListHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view);
        make.left.mas_equalTo(view);
        make.size.mas_equalTo(view);
    }];
    return view;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 300;
}
#pragma mark - 团购UICollectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((CGRectW(self.view) /2) - 30 , 230);
}
/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 30, 5, 5);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"HomeBulkCell";
    HomeBulkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}
@end
