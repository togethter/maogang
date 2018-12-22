//
//  BrushViewController.m
//  maoGang
//
//  Created by xl on 2018/11/23.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "BrushViewController.h"
#import "PenCell.h"
#import "EditionController.h"
#import "FontModel.h"
#import "NODataView.h"
#import "CustomAlertView.h"
#import "YLAlertAddBookTool.h"
#import "AFURLSessionManager.h"
@interface BrushViewController ()<UITableViewDelegate,UITableViewDataSource,PenCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *brushTableView;
@property (nonatomic, strong) NSMutableArray *brushArray;
@property (nonatomic, strong) NODataView *nodataView;
@property(nonatomic,strong) YLAlertAddBookTool * AddbookVc ;


@end

@implementation BrushViewController
-(YLAlertAddBookTool * )AddbookVc{
    if (!_AddbookVc) {
        _AddbookVc = [[YLAlertAddBookTool alloc]initWithFrame:CGRectMake((kScreenWidth-AdaptedWidthValue(584)/2)/2, (kScreenHeight-AdaptedHeightValue(150))/2, AdaptedWidthValue(584)/2, AdaptedHeightValue(150))];
    }
    return _AddbookVc;
    
}
- (NSMutableArray *)brushArray {
    if (!_brushArray) {
        _brushArray = [NSMutableArray array];
    }
    return _brushArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.brushTableView.delegate = self;
    self.brushTableView.dataSource = self;
    self.brushTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (iOS11) {
        self.brushTableView.estimatedSectionFooterHeight = 0;
        self.brushTableView.estimatedSectionFooterHeight = 0;
        self.brushTableView.estimatedRowHeight = 0;
    }
    
    [self.brushTableView registerNib:[UINib nibWithNibName:@"PenCell" bundle:nil] forCellReuseIdentifier:@"PenCell"];
    self.nodataView = [NODataView noDataViewWithImage:@"bar_wushuju" withDescription:@"暂无数据"];
    self.nodataView.hidden = YES;
    [self.brushTableView addSubview:self.nodataView];
    [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.brushTableView);
        make.centerY.mas_equalTo(self.brushTableView.mas_centerY).offset(-70);
    }];
    [self downRefsh];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)downRefsh {
    [self.brushArray removeAllObjects];
    [self network];
}


- (void)laodMoreRefsh {
    
    [self network];
    
}

- (void)fontNetwork {
    //    [self downRefsh];
    [self.brushTableView reloadData];
}
- (void)network {
    
    [self netWorkHelperWithPOST:BasicsTypefacesType parameters:@{@"penType":@"2"} success:^(id responseObject) {
        FontModel *model = [FontModel loadModelWithDictionary:responseObject];
        if ([model.Result isEqualToString:@"200"]) {
            NSArray *fontArray =  responseObject[@"Info"];
            for (NSDictionary *fontDic in fontArray) {
                FontModel *fontModel = [FontModel loadModelWithDictionary:fontDic];
                [self.brushArray addObject:fontModel];
            }
            self.nodataView.hidden = self.brushArray.count;
            [self.brushTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brushArray.count;
}

- (void)downLoadFontWithCell:(PenCell *)cell model:(FontModel *)model IndexPath:(NSIndexPath *)indexPath{
    // 下载字体弹框
    __weak typeof(self)weakSelf = self;
    if ([FontMnager  fontPathisExist:model.DownloadUrl])  {// 下载过了直接将字体替换掉
        [[FontMnager fontInstance] registerFontWithPath:[[FontMnager fontInstance]fileURLWithUrlPath:model.DownloadUrl]];
        
        if (self.brushArray.count > indexPath.row) {
            FontModel *fontModel = self.brushArray[indexPath.row];
            EditionController *vc = [[EditionController alloc] initWithNibName:@"EditionController" bundle:nil titleName:fontModel.TypefaceName];
            vc.fontModel = fontModel;
            vc.fontModelArray = self.brushArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }
    [TipAlert centerAlertShowtipAlertisSureBlock:^(BOOL isSure) {
        if (!isSure) return;
        [weakSelf.AddbookVc show];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fonPath = [path stringByAppendingPathComponent:@"XLFont"];
        NSFileManager *fileManger = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        BOOL isFileExists =  [fileManger fileExistsAtPath:fonPath isDirectory:&isDirectory];
        if (!isFileExists && isDirectory == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:fonPath withIntermediateDirectories:YES attributes:nil error:nil];
            
        }
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString *baseUrl = nil;
        if ([UIDevice currentDevice].systemName.floatValue <= 9.0) {
            baseUrl = [model.DownloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else{
            baseUrl = [model.DownloadUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<>"].invertedSet];
        }
        
        NSURL *URL = [NSURL URLWithString:baseUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.AddbookVc.progressView.progress =  downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                weakSelf.AddbookVc.numberProgressL.text = [NSString stringWithFormat:@"%d%%", (int)floor(weakSelf.AddbookVc.progressView.progress * 100)];
            });
            
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[fonPath stringByAppendingPathComponent:baseUrl.md5]];
            return documentsDirectoryURL;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"File downloaded to: %@", filePath);
            [[FontMnager fontInstance] registerFontWithPath:filePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.AddbookVc close];
                weakSelf.AddbookVc = nil;
                [weakSelf.brushTableView reloadData];
                
            });
            
        }];
        [downloadTask resume];
    }];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PenCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.brushArray.count > indexPath.row) {
        FontModel *fontModel = self.brushArray[indexPath.row];
        [cell.penImageView sd_setImageWithURL:[NSURL URLWithString:fontModel.HomePic] placeholderImage:nil];
        cell.desLabel.text = fontModel.TypefaceName;
        cell.model = fontModel;
        cell.downLoadBtn.hidden = [FontMnager fontPathisExist:fontModel.DownloadUrl];
    }
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.brushArray.count > indexPath.row) {
        FontModel *fontModel = self.brushArray[indexPath.row];
        [self downLoadFontWithCell:nil model:fontModel IndexPath:indexPath];
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
