//
//  TypesettingViewController.m
//  maoGang
//
//  Created by xl on 2018/11/28.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "TypesettingViewController.h"
#import "CustomAlertView.h"
#import "FontModel.h"
#import "GXWaterCVCell.h"
#import "GXWaterCollectionViewLayout.h"
@interface TypesettingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,GXWaterCollectionViewLayoutDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UIButton *sender1;
@property (weak, nonatomic) IBOutlet UIButton *sender2;
@property (weak, nonatomic) IBOutlet UIButton *sender0;
@property (weak, nonatomic) IBOutlet UIButton *sender3;
@property (nonatomic, strong) NSMutableArray *senderArray;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) NSInteger numberLineCount;
@property (nonatomic, strong) GXWaterCollectionViewLayout *waterLayout;
@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, assign) BOOL autoFillWords;
@property (nonatomic, assign) BOOL autoClearPunctuation;
@end

@implementation TypesettingViewController

- (NSMutableArray *)textArray {
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}
- (void)configurateNumberOfColumns:(NSInteger)numberOfColumns numberLineCount:(NSInteger)numberLineCount vertical:(BOOL) isvertical successBlock:(void(^)(void))successBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.numberOfColumns = numberOfColumns;// 列数
        self.numberLineCount = numberLineCount;// 行数
        self.waterLayout.numberOfColumns = self.numberOfColumns;// 列数
        self.waterLayout.numberLineCount = self.numberLineCount;// 行数
        self.waterLayout.vertical = isvertical;// 横竖排
        NSInteger colu = numberOfColumns;
        NSInteger line = numberLineCount;
        [self.textArray removeAllObjects];
        __block  NSInteger count = 0;// 下表
        __block  BOOL start = YES;// 是否开启
        __block  NSString *currentStr = self.contentStr;
        
        while (start) {
            if (currentStr.length > colu * line) {// 如果大于个数的话说明有分区
                NSString *str =  [currentStr substringWithRange:NSMakeRange(0, colu * line)];
                [self.textArray addObject:str];
                count +=colu * line;
                // 获取到剩下的字符串
                currentStr = [self.contentStr substringFromIndex:count];
            } else {// 没有分区
                NSString *str = [self.contentStr substringWithRange:NSMakeRange(count, currentStr.length)];
                if (!str) {
                    if (successBlock) {
                        successBlock();
                    }
                    return;
                }
                [self.textArray addObject:str];
                if (successBlock) {
                    successBlock();
                }
                start = NO;// 跳出循环
            }
        }
    });
    
}


- (NSMutableArray *)senderArray {
    if (!_senderArray) {
        _senderArray = [NSMutableArray array];
    }
    return _senderArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.textArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return  self.numberLineCount * self.numberOfColumns;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GXWaterCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GXWaterCVCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.array = self.textArray;
    cell.alertModel = self.customAlertModel;
    return cell;
}

- (CGFloat)sizeWithLayout:(GXWaterCollectionViewLayout*)layout indexPath:(NSIndexPath*)indexPath itemSize:(CGFloat)itemSize {
    return layout.viewHeightOrWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"排版";
    _sender0.tag = 100;
    _sender1.tag = 101;
    _sender2.tag = 102;
    _sender3.tag = 103;
    _sender3.layer.cornerRadius = 30.f/2;
    _sender3.layer.masksToBounds = YES;

    [self.senderArray addObjectsFromArray:@[_sender0,_sender1,_sender2]];
    __weak typeof(self)weakSelf = self;
    GXWaterCollectionViewLayout *waterLayout = [[GXWaterCollectionViewLayout alloc] init];
    self.waterLayout = waterLayout;
    waterLayout.delegate = self;
    self.waterLayout.lineSpacing = 0;
    self.waterLayout.interitemSpacing = 0;
    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.waterLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.contentView.backgroundColor = BACKCOLOR;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.collectionView.bounds collectionViewLayout:waterLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GXWaterCVCell" bundle:nil] forCellWithReuseIdentifier:@"GXWaterCVCell"];
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-40);
    }];
    iPhoneXR||iPhoneXM||iPhoneX?(weakSelf.bottomMargin.constant = 20):0;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

    self.customAlertModel.order = @(1);
    [self senderAction:self.senderArray[1]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bottomLab.textColor = RGBCOLOR(131, 131, 131);
    self.bottomLab.font = [UIFont systemFontOfSize:12];
    [self setHangLie];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    self.contentStr = [self.customAlertModel.txt copy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self configurateNumberOfColumns:self.numberOfColumns numberLineCount:self.numberLineCount vertical:YES successBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                  weakSelf.bottomLab.text = [NSString stringWithFormat:@"共%d个文字,占用%d张%@打印纸",weakSelf.customAlertModel.txt.length,weakSelf.textArray.count,weakSelf.customAlertModel.a3orA4];
                [SVProgressHUD dismiss];
                [weakSelf.collectionView reloadData];
            });
        }];// 横向
    });
    
    
}
// 过滤特殊符号
- (NSString *)filterPunctuation:(NSString *)string {
    return [self getChineseStringWithString:string];
}

- (NSString *)getChineseStringWithString:(NSString *)string
{
    NSRegularExpression *predicate = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z\u4e00-\u9fa5]+" options:0 error:NULL];// 中文的
   __block NSMutableString *chines = @"".mutableCopy;
    [predicate enumerateMatchesInString:string options:0 range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
       NSString *str = [string substringWithRange:result.range];
        [chines appendString:str];
    }];
    return chines;
}


// 自动填满
- (void )manAction {
//     分区个数
    NSInteger section = self.textArray.count;
//     每个分区的个数
    NSInteger row = self.numberLineCount * self.numberOfColumns;
    
//    总的个数
    if (section > 1) {// 多个分区
        // 最后一个分区的分区号
        NSInteger lastSection = section - 1;
        // 最后一个分区的字符串
        if (self.textArray.count > lastSection) {
            NSString *lastStr = self.textArray[lastSection];
            if (lastStr.length < row) {// 小于个数
                // 填满的个数
                NSInteger manLent = row - lastStr.length;
                // 去第一个分区拿
                NSString *str = self.textArray.firstObject;
                // 拿到要填充的字符串
                NSString *strFromFisrtSection = [str substringToIndex:manLent];
                // 最后一个分区生成一个新的字符串
                lastStr = [lastStr stringByAppendingString:strFromFisrtSection];
                if (IS_VALID_STRING(lastStr)) {
                    [self.textArray removeLastObject];
                    [self.textArray addObject:lastStr];
                    
                }
                // 刷新界面
                [self.collectionView reloadData];
            }
        }
    } else {// 就是一个分区
        NSString *fistStr = self.textArray.firstObject;
        if (fistStr.length < row) {// 小于
            
            while (fistStr.length < row) {
                fistStr = [fistStr stringByAppendingString:fistStr];
            }
            if (fistStr.length >= row) {
                fistStr = [fistStr substringToIndex:row];
            }
            if (IS_VALID_STRING(fistStr)) {
                self.textArray[0] = fistStr;
            }
            [self.collectionView reloadData];
        }
    }
     self.bottomLab.text = [NSString stringWithFormat:@"共%d个文字,占用%d张%@self纸",self.contentStr.length,self.textArray.count,self.customAlertModel.a3orA4];
}



- (void)setHangLie {
    NSString *penType = self.customAlertModel.maoGangType.stringValue;
    if (IS_VALID_STRING(penType) && [penType isEqualToString:@"1"]) {// 钢笔
        self.numberLineCount = 18;
        self.numberOfColumns = 12;  // 216
       NSInteger fontsize = self.customAlertModel.fontSizeIndex - 100;
        UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 20, 0);
        if (fontsize == 0) {// 小
            inset.left  =   20 * XLh;
            inset.right =   20 * XLh;
        } else if (fontsize == 1) {// 中
            inset.left  =   18 * XLh;
            inset.right =   18 * XLh;
        } else if (fontsize == 2) {// 大
            inset.left  =   10 * XLh;
            inset.right =   10 * XLh;
        }
        self.waterLayout.sectionInset = inset;

    } else {
        if ([self.customAlertModel.a3orA4 isEqualToString:@"A4"]) {// A4
            switch (self.customAlertModel.fontSizeIndex - 100) {
                case 0:// 小
                {
                    self.numberLineCount = 6;
                    self.numberOfColumns = 4;//24
                    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 90 * XLh, 20, 90 * XLh);
                }
                    break;
                case 1:// 中
                {
                    self.numberLineCount = 4;
                    self.numberOfColumns = 3;//12
                    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 120 * XLh, 20, 120 * XLh);

                }
                    break;
                case 2:// 大
                {
                    self.numberLineCount = 3;
                    self.numberOfColumns = 2;// 6
                    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 135 * XLh, 20, 135 * XLh);

                }
                    break;
                default:
                    break;
            }
        } else if ([self.customAlertModel.a3orA4 isEqualToString:@"A3"]) {//A3
            switch (self.customAlertModel.fontSizeIndex -100) {
                case 0:// 小
                {
                    self.numberLineCount = 7;
                    self.numberOfColumns = 10;//70
                    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 20 * XLh, 20, 20 * XLh);

                }
                    break;
                case 1:// 中
                {
                    self.numberLineCount = 5;
                    self.numberOfColumns = 8;// 40
                    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 40 * XLh, 20, 40 * XLh);

                }
                    break;
                case 2:// 大
                {
                    self.numberLineCount = 3;
                    self.numberOfColumns = 5;// 15
                    self.waterLayout.sectionInset = UIEdgeInsetsMake(20, 80 * XLh, 20, 80 * XLh);
                }
                    break;
                default:
                    break;
            }
        }
    }
    
}
- (void)dealloc {


}
- (void)shareAction:(UIBarButtonItem *)share {
    DLog(@"shareAction");
}





- (void)filterPunctuationActionBlock:(void(^)(void))successBlock
{
    __weak typeof(self)weakSelf = self;
    self.contentStr =  [self filterPunctuation:self.contentStr];
    [self configurateNumberOfColumns:self.numberOfColumns numberLineCount:self.numberLineCount vertical:self.waterLayout.vertical successBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.bottomLab.text = [NSString stringWithFormat:@"共%d个文字,占用%d张%@打印纸",weakSelf.contentStr.length,weakSelf.textArray.count,weakSelf.customAlertModel.a3orA4];
            [SVProgressHUD dismiss];
            if (successBlock) {
                successBlock();
            }
        });
    }];
}

- (void)restAction:(void(^)(void))successBlock {
    __weak typeof(self)weakSelf = self;
    [self configurateNumberOfColumns:self.numberOfColumns numberLineCount:self.numberLineCount vertical:self.waterLayout.vertical successBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.bottomLab.text = [NSString stringWithFormat:@"共%d个文字,占用%d张%@打印纸",weakSelf.customAlertModel.txt.length,weakSelf.textArray.count,weakSelf.customAlertModel.a3orA4];
                [SVProgressHUD dismiss];
                if (successBlock) {
                    successBlock();
                }
            });
    }];// 横向
}
- (IBAction)senderAction:(UIButton *)sender {
    
    NSArray *array = @[@"icon_paiban_shezhi_a",@"icon_paiban_shu_a",@"icon_paiban_heng_a"];
    NSArray *seletarray = @[@"icon_paiban_shezhi_b",@"icon_paiban_shu_b",@"icon_paiban_heng_b"];
    [self.senderArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *conBtn = obj;
        if ([sender isEqual:conBtn]) {
            [conBtn setImage:[UIImage imageNamed:seletarray[conBtn.tag - 100]] forState:UIControlStateNormal];
        } else {
            [conBtn setImage:[UIImage imageNamed:array[conBtn.tag - 100]] forState:UIControlStateNormal];
        }
    }];
    switch (sender.tag) {
        case 100:
        {
            __weak typeof(self)weakSelf = self;
            [WordsSet congigureLookFontsSetBlockFillWords:self.autoFillWords autoClearPunctuation:self.autoClearPunctuation setBlock:^(BOOL autoFillWords, BOOL autoClearPunctuation) {
                self.autoClearPunctuation = autoClearPunctuation;
                self.autoFillWords = autoFillWords;
                if (autoFillWords && autoClearPunctuation) {// 去掉标点符号自动填充
                    [weakSelf filterPunctuationActionBlock:^{
                        [weakSelf manAction];
                    }];
                } else if (autoFillWords && !autoClearPunctuation) {// 自动填充
                    weakSelf.contentStr = [self.customAlertModel.txt copy];
                    [weakSelf restAction:^{
                        [weakSelf manAction];
                    }];
                } else if (autoClearPunctuation && !autoFillWords) {// 去掉标点符号
                    [weakSelf filterPunctuationActionBlock:^{
                        [weakSelf.collectionView reloadData];
                    }];
                } else {// 原始值
                    weakSelf.contentStr = [self.customAlertModel.txt copy];
                    [weakSelf restAction:^{
                        [weakSelf.collectionView reloadData];
                    }];
                }
                
                
            }];
            
        }
            break;
        case 101:// 左右 1
        {
            self.customAlertModel.order = @(1);
            self.waterLayout.vertical = YES;
            [self.collectionView reloadData];
           
            
        }
            break;
        case 102:// 上下 2
        {
            self.customAlertModel.order = @(2);
            self.waterLayout.vertical = NO;
            [self.collectionView reloadData];
            break;
        }
            case 103:
        {
            // 生成字帖
            isCanLogin;
            NSString *token = TOKEN;
            NSDictionary *parm =  self.customAlertModel.parm;
            // 排版
            // 自动填满空白格 1 是 10 否
            NSString *fullScren = self.autoFillWords? @"1":@"10";
            // 自动清除标点符号 1 是 10 否
            NSString *Punctuation = self.autoClearPunctuation? @"1":@"10";
            NSMutableDictionary *newParm = nil;
            if (IS_VALID_STRING(self.customAlertModel.shiciId) || IS_VALID_STRING(self.customAlertModel.contentId)) {//如果有诗词的id或者内容的id 不用穿content
                newParm =                       @{
                                                  @"Punctuation":Punctuation,
                                                  @"FullScreen":fullScren,
                                                  @"token":token,
                                                  @"content":@""

                                                  }.mutableCopy;
            } else {
                // 需要穿content
                newParm =                       @{
                                                  @"Punctuation":Punctuation,
                                                  @"FullScreen":fullScren,
                                                  @"token":token,
                                                  @"content":IS_VALID_STRING(self.contentStr)?self.contentStr:@"",
                                                  }.mutableCopy;
                
            }
           
            [newParm addEntriesFromDictionary:parm];
            [SVProgressHUD show];
            [self netWorkHelperWithPOST:CopybookCreate parameters:newParm success:^(id responseObject) {
                [SVProgressHUD dismiss];
                BaseModel *baseModel = [BaseModel loadModelWithDictionary:responseObject];
                if ([baseModel.Result isEqualToString:@"200"]) {
                    NSString *url = responseObject[@"Info"];
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"字帖已完成" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"生成下载链接" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        [TipCopyAlert centerAlertShowtipAlertisSureBlock:^(BOOL isCopy) {
                            if (isCopy) {
                                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                                pasteboard.string= url;
                            }
                        } urlString:url];
                    }];
                    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertVC addAction:action1];
//                    [alertVC addAction:action2];
                    [alertVC addAction:action3];
                    
                    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];

            }];
           
        }
            
            break;
        default:
            break;
    }
}



@end
