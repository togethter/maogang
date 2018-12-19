//
//  SingleDicViewController.m
//  maoGang
//
//  Created by xl on 2018/12/10.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "SingleDicViewController.h"
#import "SingleDicCell.h"
#import "ListModelOne.h"
#import "ListModelTwo.h"
#import "ListModelThree.h"
#import "EditionController.h"
@interface SingleDicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *singleTableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation SingleDicViewController

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (UITableView *)singleTableView {
    if (!_singleTableView) {
        _singleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _singleTableView.delegate = self;
        _singleTableView.dataSource = self;
        [_singleTableView registerNib:[UINib nibWithNibName:@"SingleDicCell" bundle:nil] forCellReuseIdentifier:@"SingleDicCell"];
    }
    return _singleTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.singleTableView];
    [self.singleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(12);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    if (iOS11) {
        self.singleTableView.estimatedSectionFooterHeight = 0;
        self.singleTableView.estimatedSectionFooterHeight = 0;
        self.singleTableView.estimatedRowHeight = 0;
    }
    self.page = 1;
    self.singleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefsh)];
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(laodMoreRefsh)];
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多内容" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = [UIFont fontWithName:FontName size:14];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blackColor];
    self.singleTableView.mj_footer = footer;
    [self downRefsh];
}
- (void)downRefsh {
    self.page = 1;
    [self.listArray removeAllObjects];
    [self network];
}
- (void)laodMoreRefsh
{
    self.page++;
    [self network];
}

- (void)endRefush {
    [self.singleTableView.mj_header endRefreshing];
    [self.singleTableView.mj_footer endRefreshing];
    [self.singleTableView reloadData];
}
- (void)network {
    
    if (self.poetryModel) {// 是否有值
        [self netWorkHelperWithPOST:BasicsPoetrysList parameters:@{@"typeId":self.poetryModel.PoetrysTypeId,@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} success:^(id responseObject) {
            BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
            if ([model.Result isEqualToString:@"200"]) {
                NSArray *infoArray = responseObject[@"Info"];
                for (NSDictionary *dic in infoArray) {
                    ListModelOne *oneModel = [ListModelOne loadModelWithDictionary:dic];
                    [self.listArray addObject:oneModel];
                }
                [self endRefush];
            }
        } failure:^(NSError *error) {
            [self endRefush];
        }];
    } else if (IS_VALID_STRING(self.PoetryId)) {
        [self netWorkHelperWithPOST:BasicsPoetryContentByPoetryId parameters:@{@"poetryId":self.PoetryId,@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} success:^(id responseObject) {
            BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
            if ([model.Result isEqualToString:@"200"]) {
                NSArray *infoArray = responseObject[@"Info"];
                for (NSDictionary *dic in infoArray) {
                    ListModelTwo *model = [ListModelTwo loadModelWithDictionary:dic];
                    [self.listArray addObject:model];
                }
               [self endRefush];
            }
        } failure:^(NSError *error) {
            [self endRefush];
        }];
        
    } else if (IS_VALID_STRING(self.PoetryContentId)){
        [self netWorkHelperWithPOST:BasicsPoetryContentByContentId parameters:@{@"contentId":self.PoetryContentId,@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} success:^(id responseObject) {
            BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
            if ([model.Result isEqualToString:@"200"]) {
                NSArray *infoArray = responseObject[@"Info"];
                for (NSDictionary *dic in infoArray) {
                    ListModelThree *listThree = [ListModelThree loadModelWithDictionary:dic];
                    [self.listArray addObject:listThree];
                }
            }
            
           [self endRefush];
        } failure:^(NSError *error) {
            [self endRefush];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.poetryModel.IsMulti isEqualToString:@"1"]) {// 是多层
        if (self.listArray.count > indexPath.row) {
            ListModelOne *modelOne = self.listArray[indexPath.row];
            SingleDicViewController *vc = [[SingleDicViewController alloc] init];
            vc.PoetryId = modelOne.PoetryId;
            vc.shiCiId =  modelOne.PoetryId;// 本地用
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if ([self.poetryModel.IsMulti isEqualToString:@"10"]) {// 单层
        if (self.listArray.count > indexPath.row) {
            EditionController *vc = self.navigationController.childViewControllers[1];
            ListModelOne *listOne = self.listArray[indexPath.row];
            
            if ([vc isMemberOfClass:[EditionController class]]) {
                [vc configurateTXT:listOne.PoetryName shiCiId:listOne.PoetryId contentId:@""];
                [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
            }
        }
    } else if (!self.poetryModel && self.listArray.count > indexPath.row) {// 多层里面的下一级
        id model = self.listArray[indexPath.row];
        if ([model isMemberOfClass:[ListModelTwo class]]) {
            ListModelTwo *twoModel = model;
            if ([twoModel.IsNext isEqualToString:@"1"]) {// 多层
                SingleDicViewController *vc = [[SingleDicViewController alloc] init];
                vc.PoetryContentId = twoModel.PoetryContentId;
                vc.shiCiId = self.shiCiId;
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([twoModel.IsNext isEqualToString:@"10"]) {// 单层
                EditionController *vc = self.navigationController.childViewControllers[1];
                if ([vc isMemberOfClass:[EditionController class]]) {
                    [vc configurateTXT:twoModel.PoetryContent shiCiId:self.shiCiId contentId:twoModel.PoetryContentId];
                    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                }
            }
        } else if ([model isMemberOfClass:[ListModelThree class]]) {
            ListModelThree *threeModel = model;
            if ([threeModel.IsNext isEqualToString:@"1"]) {// 多层
                SingleDicViewController *vc = [[SingleDicViewController alloc] init];
                vc.PoetryContentId = threeModel.PoetryContentId;
                vc.shiCiId = self.shiCiId;
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([threeModel.IsNext isEqualToString:@"10"]) {// 单层
                EditionController *vc = self.navigationController.childViewControllers[1];
                if ([vc isMemberOfClass:[EditionController class]]) {
                    [vc configurateTXT:threeModel.PoetryContent shiCiId:self.shiCiId contentId:threeModel.PoetryContentId];
                    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                }
            }
        }
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SingleDicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleDicCell" forIndexPath:indexPath];
    id model = self.listArray[indexPath.row];
    NSString *txt = @"";
    static NSInteger txtLength = 40;
    if ([model isMemberOfClass:[ListModelOne class]]) {
        ListModelOne *modelOne = model;
        if (modelOne.PoetryName.length >txtLength) {
         txt = [modelOne.PoetryName substringToIndex:txtLength];
        } else {
        txt = [modelOne.PoetryName substringToIndex:modelOne.PoetryName.length];
        }
        txt = [self noWhiteSpaceString:txt];
        cell.nameLb.text = txt;
        cell.authorL.text = modelOne.Author;
    } else if ([model isMemberOfClass:[ListModelTwo class]]) {
        ListModelTwo *modelTwo = model;
        if (modelTwo.PoetryContent.length >txtLength) {
            txt = [modelTwo.PoetryContent substringToIndex:txtLength];
        } else {
            txt = [modelTwo.PoetryContent substringToIndex:modelTwo.PoetryContent.length];
        }
        txt = [self noWhiteSpaceString:txt];
        cell.nameLb.text = txt;
        cell.authorL.text = @"";
    } else if ([model isMemberOfClass:[ListModelThree class]]) {
        ListModelThree *modelThree = model;
        if (modelThree.PoetryContent.length >txtLength) {
            txt = [modelThree.PoetryContent substringToIndex:txtLength];
        } else {
            txt = [modelThree.PoetryContent substringToIndex:modelThree.PoetryContent.length];
        }
        txt = [self noWhiteSpaceString:txt];
        cell.nameLb.text = txt;
        cell.authorL.text = @"";
    }
    return cell;
}

- (NSString*)stringByTrimAllWhitespace:(NSString *)text {
    NSCharacterSet*set = [NSCharacterSet whitespaceCharacterSet];//空格的字符集
    return[[text componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}
- (NSString *)noWhiteSpaceString:(NSString *)text {
    NSString *newString = text;
    //去除掉首尾的空白字符和换行字符
    //    newString = [[[self stringByTrimAllWhitespace:newString] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSArray *array = @[@"\n",@"\r",@"\n ",@"/n"];
    NSInteger index = 0;
    newString = [self stringByTrimAllWhitespace:newString];
    while (index < array.count - 1) {
        NSString *str = array[index];
        newString = [newString stringByReplacingOccurrencesOfString:str withString:@""];
        index++;
    }
    
    return newString;
}


@end
