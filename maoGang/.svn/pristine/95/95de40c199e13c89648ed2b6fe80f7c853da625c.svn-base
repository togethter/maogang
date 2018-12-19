//
//  NotingPenViewController.m
//  maoGang
//
//  Created by xl on 2018/12/17.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "NotingPenViewController.h"
#import "NotingCell.h"
#import "WhiteViewController.h"
#import "NODataView.h"
#import "FontModel.h"

@interface NotingPenViewController ()<UITableViewDelegate,UITableViewDataSource,NotingCellDelegate,NotingCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NODataView *nodataView;
@property (nonatomic, strong) NSMutableArray *penArray;

@end

@implementation NotingPenViewController

- (NSMutableArray *)penArray {
    if (!_penArray) {
        _penArray = [NSMutableArray array];
    }
    return _penArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"NotingCell" bundle:nil] forCellReuseIdentifier:@"NotingCell"];
    self.tableView.delegate     =   self;
    self.tableView.dataSource   = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.tableFooterView = [UIView new];
    // 暂无数据
    self.nodataView = [NODataView noDataViewWithImage:@"bar_wushuju" withDescription:@"暂无数据"];
    [self.tableView addSubview:self.nodataView];
    [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tableView);
        make.centerY.mas_equalTo(self.tableView.mas_centerY).offset(-70);
    }];
    [self network];
}

- (void)network {
    if (!IS_VALID_STRING(self.penId)) {
        [AlertPool alertMessage:@"penId为空" xlViewController:self WithBlcok:nil];
        return;
    }
    [self netWorkHelperWithPOST:BlankFontIndex parameters:@{@"groupId":self.penId} success:^(id responseObject) {
        BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
        if ([model.Result isEqualToString:@"200"]) {
            NSArray *array = responseObject[@"Info"];
            for (NSDictionary *dic in array) {
                FontModel *fonModel = [FontModel loadModelWithDictionary:dic];
                [self.penArray addObject:fonModel];
            }
            self.nodataView.hidden = self.penArray.count;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.penArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotingCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (self.penArray.count > indexPath.row) {
        FontModel *fontModel = self.penArray[indexPath.row];
        cell.placeHold.contentMode = UIViewContentModeScaleAspectFit;
        [cell.placeHold sd_setImageWithURL:[NSURL URLWithString:fontModel.HomePic] placeholderImage:nil];
        cell.desL.text = fontModel.BlankFontTypeName;
    }
    return cell;
}
- (void)notingCellDidSelectWithModel:(id)model sender:(NotingCell *)cell {
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WhiteViewController *whiteVC = [[WhiteViewController alloc] init];
    if (self.penArray.count > indexPath.row) {
        FontModel *modle = self.penArray[indexPath.row];
        whiteVC.blankFontTypeId = modle.BlankFontTypeId;
    }
    [self.navigationController pushViewController:whiteVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
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
