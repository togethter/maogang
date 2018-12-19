//
//  YLAllIndividualWorkViewController.m
//  maoGang
//
//  Created by zhangzhen on 2018/12/4.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "YLAllIndividualWorkViewController.h"

#import "YLACollectionOfPersonalTableViewCell.h"
#import "CircleItem.h"
#import "YLWorkDetailsViewController.h"

@interface YLAllIndividualWorkViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _page;
    
}
@property(nonatomic,strong)UITableView * tableV;

@end

@implementation YLAllIndividualWorkViewController
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
        [_tableV registerNib:[UINib nibWithNibName:@"YLACollectionOfPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:@"YLACollectionOfPersonalTableViewCell"];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableV;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataArray removeAllObjects];
    [self loadNewData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"作品集";
    _page = 1;
    [self creatUI];
    
    
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * lineV = [[UIView alloc]init];
    lineV.backgroundColor = BACKCOLOR;
    [self.view addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@2);
    }];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(self.view);
        
        make.top.mas_equalTo(lineV.mas_bottom) ;
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
    _page = 1;
    [self.dataArray removeAllObjects];
    [self loadRequsets];
    
}
-(void)loadMoreData{
    
    _page++;
    [self loadRequsets];
}

- (void)loadRequsets
{
    
  
        [self netWorkHelperWithPOST:MyMyPost parameters:@{@"page":@(_page),@"token":TOKEN} success:^(id responseObject) {
            BaseModel * Bmodel = [BaseModel loadModelWithDictionary:responseObject];
            if ([Bmodel.Result isEqualToString:@"200"]) {

                NSArray * listArr = responseObject[@"Info"];
                if (IS_VALID_ARRAY(listArr)) {
                    for (NSDictionary * listDic in listArr) {
                        CircleItem * model = [CircleItem loadModelWithDictionary:listDic];
                        [self.dataArray addObject:model];
                    }
                }
                
                self.Icon_backImage.hidden = self.dataArray.count;
                self.Icon_label.hidden = self.dataArray.count;
                [self.tableV.mj_footer endRefreshing];
                [self.tableV.mj_header endRefreshing];
                [self.tableV reloadData];
                
            }
            //                else{
            //                    [GiFHUD show:Bmodel.message view:self.view];
            //                }
            
        } failure:^(NSError *error) {
            
        }];
        
        
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50+27;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YLACollectionOfPersonalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YLACollectionOfPersonalTableViewCell" forIndexPath:indexPath];
    if (self.dataArray.count>indexPath.row) {
        CircleItem * model = self.dataArray[indexPath.row];
        [cell addCircleModel:model];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count>indexPath.row) {
        CircleItem * model = self.dataArray[indexPath.row];
        YLWorkDetailsViewController * vc = [[YLWorkDetailsViewController alloc]init];
        vc.postId = model.PostId;
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
