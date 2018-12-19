//
//  YLMyAttentionViewController.m
//  maoGang
//
//  Created by zhangzhen on 2018/12/6.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "YLMyAttentionViewController.h"
#import "YLMyFansOfTableViewCell.h"
#import "YLMyFansOfModel.h"
#import "YLPersonalDetailsPageViewController.h"


@interface YLMyAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
}

@property(nonatomic,strong)UITableView * tableV;

@end

@implementation YLMyAttentionViewController

-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableV.backgroundColor = [UIColor clearColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        if (iOS11) {
            _tableV.estimatedRowHeight = 0;
            _tableV.estimatedSectionHeaderHeight = 0;
            _tableV.estimatedSectionFooterHeight = 0;
        }
        [_tableV registerNib:[UINib nibWithNibName:@"YLMyFansOfTableViewCell" bundle:nil] forCellReuseIdentifier:@"YLMyFansOfTableViewCell"];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    [self creatUI];
    _page = 1;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}
-(void)creatUI{
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(5);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    // 设置footer
    self.tableV.mj_footer = footer;
    
    
    [self.tableV addSubview:self.Icon_label];
    [self.tableV addSubview:self.Icon_backImage];
    [self.Icon_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tableV);
        make.centerY.equalTo(self.tableV).offset(-20);
    }];
    
    [self.Icon_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Icon_backImage.mas_bottom).offset(5);
        make.centerX.equalTo(self.Icon_backImage);
    }];
    
    
}
-(void)loadNewData{
    [self.dataArray removeAllObjects];
    _page = 1;
    [self downLoad];
}
-(void)loadMoreData{
    _page++;
    [self downLoad];
    
}

-(void)downLoad{
    
    [self netWorkHelperWithPOST:MyMyFollow parameters:@{@"token":TOKEN,@"page":@(_page)} success:^(id responseObject) {
        BaseModel * BModel = [BaseModel loadModelWithDictionary:responseObject];
        if ([BModel.Result isEqualToString:@"200"]) {
            NSArray * arr = responseObject[@"Info"];
            if (IS_VALID_ARRAY(arr)) {
                for (NSDictionary * dic in arr) {
                    YLMyFansOfModel * model = [YLMyFansOfModel loadModelWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
            }
            
        }
        self.Icon_label.hidden = self.dataArray.count;
        self.Icon_backImage.hidden = self.dataArray.count;
        [self.tableV.mj_footer endRefreshing];
        [self.tableV.mj_header endRefreshing];
        [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLMyFansOfTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YLMyFansOfTableViewCell" forIndexPath:indexPath];
    if (self.dataArray.count>indexPath.row) {
        [cell addModel:self.dataArray[indexPath.row]];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count>indexPath.row) {
        YLMyFansOfModel * model = self.dataArray[indexPath.row];
        YLPersonalDetailsPageViewController * vc = [[YLPersonalDetailsPageViewController alloc]init];
        vc.memberId = model.MemberId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
