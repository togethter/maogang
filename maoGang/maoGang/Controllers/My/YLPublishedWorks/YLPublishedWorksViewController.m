//
//  YLPublishedWorksViewController.m
//  maoGang
//
//  Created by zhangzhen on 2018/12/5.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "YLPublishedWorksViewController.h"
#import "HDragItemListView.h"

#import "LSActionSheet.h"
#import "IWTextView.h"
#import "CRMediaPickerController.h"
#import<AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "YQImageCompressTool.h"
#import "BasicDataViewController.h"
#import "MBProgressHUD.h"

@interface YLPublishedWorksViewController ()<ZLPhotoPickerBrowserViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *V_bg_image;
@property (weak, nonatomic) IBOutlet IWTextView *TextV;
@property (nonatomic, strong) HDragItemListView *itemList;

@property (nonatomic, strong) CRMediaPickerController *mediaPickerController;
@property (assign, nonatomic)CRMediaPickerControllerMediaType selectedMediaType;
@property (assign, nonatomic)CRMediaPickerControllerSourceType selectedSourceType;

/** 新添加图片的数组 或者删除的图片的数组*/
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *zlPhotos;
@end

@implementation YLPublishedWorksViewController

- (NSMutableArray *)zlPhotos
{
    if (!_zlPhotos) {
        _zlPhotos = [NSMutableArray array];
    }
    return _zlPhotos;
}
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
 //一档 0--20   15--20可换二档
//二档 10--30   25--30可换三挡
//三挡 20--40   35--40可换四挡
//四挡 30--50   45--50可换五档
    
}
-(void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    
    self.TextV.placeholder = @"这一刻的想法...";
    self.TextV.font= [UIFont systemFontOfSize:15];
    self.TextV.textColor = RGBCOLOR(131, 131, 131);
    
    HDragItem *item = [[HDragItem alloc] init];
    item.backgroundColor = [UIColor clearColor];
    item.image = [UIImage imageNamed:@"tianjia_zhaopian"];
    item.isAdd = YES;
    item.backgroundColor = BACKCOLOR;
    item.contentMode = UIViewContentModeCenter;

//    // 创建标签列表
    HDragItemListView *itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-60, 0)];
    self.itemList = itemList;
    itemList.backgroundColor = [UIColor clearColor];
    // 高度可以设置为0，会自动跟随标题计算
    // 设置排序时，缩放比例
    itemList.scaleItemInSort = 1.3;
    // 需要排序
    itemList.isSort = YES;
    itemList.isFitItemListH = YES;
//    itemList.itemListH = 80;
    [itemList addItem:item];

    __weak typeof(self) weakSelf = self;
    /**
     * 点击
     */
    [itemList setClickItemBlock:^(HDragItem *item) {
        if (item.isAdd) {
            DLog(@"添加");
            [weakSelf showUIImagePickerController];
        }else{
            DLog(@"%ld",item.tag);
            [weakSelf showImageListToindex:item.tag];
        }
    }];
    /**
     * 滑动
     */
    [itemList setClickItemShiftPositionBlock:^(HDragItem *item, HDragItem *ToItem) {
        if (weakSelf.zlPhotos.count>item.tag) {
            ZLPhotoPickerBrowserPhoto *photo =weakSelf.zlPhotos[item.tag];
            [weakSelf.zlPhotos removeObject:photo];
            [weakSelf.zlPhotos insertObject:photo atIndex:ToItem.tag];
        }

    }];

    /**
     * 移除tag 高度变化，得重设
     */
    itemList.deleteItemBlock = ^(HDragItem *item) {
        if (weakSelf.zlPhotos.count>item.tag) {
            [weakSelf.zlPhotos removeObjectAtIndex:item.tag];
        }
        HDragItem *lastItem = [weakSelf.itemList.itemArray lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!lastItem.isAdd) {
                HDragItem *item = [[HDragItem alloc] init];
                item.backgroundColor = [UIColor clearColor];
                item.image = [UIImage imageNamed:@"tianjia_zhaopian"];
                item.isAdd = YES;
                item.backgroundColor = BACKCOLOR;
                item.contentMode = UIViewContentModeCenter;
                [weakSelf.itemList addItem:item];
            }
            [weakSelf updateHeaderViewHeight];
        });
    };
    
    [self.V_bg_image addSubview:itemList];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (IBAction)LeftItemButtonClicked:(UIButton *)sender {
     [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark  ---- 发布   15062144135
- (IBAction)RightItemButtonClicked:(UIButton *)sender {

    [self.view endEditing:YES];
    
    if (self.zlPhotos.count==0) {
        [GiFHUD show:@"请至少上传一张图片~" view:self.view];
        return;
    }
    
    NSString * text ;
    if (IS_VALID_STRING(self.TextV.text)) {
        text = self.TextV.text;
    }else{
        text = @"";
    }
    NSMutableArray * Arr = [NSMutableArray array];
    for (ZLPhotoPickerBrowserPhoto * photo in self.zlPhotos) {
        [Arr addObject:photo.photoImage];
    }
    DLog(@"%@",Arr);
    sender.userInteractionEnabled = NO;
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [[YXHTTPRequst shareInstance]uploadImagesWithURL:MyPostesPostMessage parameters:@{@"token":TOKEN,@"content":text} name:@"imageFiles" images:Arr fileNames:nil imageScale:1 imageType:@"png" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        DLog(@"%@",responseObject);
        sender.userInteractionEnabled = YES;
        LRWeakSelf(self);
        BaseModel *baseModel = [BaseModel loadModelWithDictionary:responseObject];
        //17-1-12      18-12-6
        if ([baseModel.Result isEqualToString:@"200"]) {
            
            [SVProgressHUD dismiss];
            [AlertPool alertMessage:baseModel.message xlViewController:self WithBlcok:^{
                [weakself dismissViewControllerAnimated:YES completion:nil];
                
            }];
        }else if ([baseModel.Result isEqualToString:@"201"]){
             [SVProgressHUD dismiss];
            [AlertPool alertMessage:baseModel.message xlViewController:self WithBlcok:^{
                BasicDataViewController  * vc = [[BasicDataViewController alloc]init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }];
           
            
        }
        else {
            [SVProgressHUD dismiss];
            [AlertPool alertMessage:baseModel.message xlViewController:self WithBlcok:nil];
        }
        
    } failure:^(NSError *error) {
         [SVProgressHUD dismiss];
          sender.userInteractionEnabled = YES;
          [AlertPool alertMessage:@"服务器内部错误~" xlViewController:self WithBlcok:nil];
        DLog(@"error--%@",error.description);
    }];
    

    
}

-(void)showImageListToindex:(NSInteger)index{
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    pickerBrowser.photos = self.zlPhotos;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndex = index;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
    
    
}
#pragma mark -- 删除图片
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndex:(NSInteger)index
{
     if (self.itemList.itemArray.count>index) {
         [self.itemList deleteItem:self.itemList.itemArray[index]];
    }
  
}


-(void)showUIImagePickerController{
    
    [LSActionSheet showWithTitle:nil destructiveTitle:nil otherTitles:@[@"拍照",@"相册"] block:^(int index) {
         [self actionSheetclickedButtonAtIndex:index];
    } withImages:@[@"icon_zhushou_0",@"icon_zhushou_1"] withBgBackgroundColor:RGBACOLOR(0, 0, 0, .3)];
  
    
}
-(void)updateHeaderViewHeight{
    
    
    
}
-(void)actionSheetclickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0: // 相机
        {
            //相机
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
            {
                // 开启相册权限
                [AlertPool alertPermissionsWithSomeMessage:@"您没有开启照片权限，前往设置。" selectedType:@"确定" WithXlViewController:self];
                
                return;
                
            }
            if (self.zlPhotos.count>=8) {
                [GiFHUD show:@"最多可上传8张照片" view:self.view];
                return;
            }
            [self openCamera];
        }
            break;
        case 1: // 相册
        {
            NSString *mediaType = AVMediaTypeVideo;
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                [AlertPool alertPermissionsWithSomeMessage:@"您没有开启相机权限，前往设置。" selectedType:@"确定" WithXlViewController:self];
                
                return;
                
            }
            //相册
            [self photoSelecte];
        }
            break;
        case 2: // 取消
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)photoSelecte{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    if (self.zlPhotos.count<9) {
        pickerVc.maxCount=9-self.zlPhotos.count;
    }else{
        pickerVc.maxCount = 0;
    }
    // Jump AssetsVc
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Recoder Select Assets
    //        pickerVc.selectPickers = self.assets;
    // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = YES;
    // CallBack
    //    typedef void(^callBackBlock)(NSArray<ZLPhotoAssets *> *assets);
   
    pickerVc.callBack = ^(NSArray <ZLPhotoAssets *>*assets) {
        
        [GiFHUD GeneralButtonActionView:self.view title:@"图片压缩中"];

        dispatch_group_t group = dispatch_group_create();
        for (ZLPhotoAssets *zlPhoto in assets) {
            //网络请求一
            
            dispatch_group_enter(group);
                [YQImageCompressTool CompressToImageAtBackgroundWithImage:zlPhoto.originImage ShowSize:zlPhoto.originImage.size FileSize:900*2 block:^(UIImage *resultImage) {
                   
                    dispatch_group_leave(group);
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//                        NSString * imagePath = [path stringByAppendingPathCompone nt:[NSString stringWithFormat:@"myImage-%d.png",i]];
//
//                        BOOL success = [UIImageJPEGRepresentation(resultImage, 1) writeToFile:imagePath  atomically:YES];
//
//                        if (success){
//
//                            DLog(@"写入本地成功--%@",imagePath);
//
//                        }
  
                        HDragItem *item = [[HDragItem alloc] init];
                        item.image = resultImage;
                        item.backgroundColor = [UIColor purpleColor];
                        [self.itemList addItem:item];
                        
                        [self.imageArray addObject:resultImage];
                        ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:resultImage];
                        [self.zlPhotos addObject:photo];
                        
                    });
                    
                }];
            
    
        }
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{

            [GiFHUD hideHUDForView:self.view];
        });
        
      
        
    };
    [pickerVc showPickerVc:self];
}

- (void)openCamera

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = NO; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        NSLog(@"没有摄像头");
        
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{
    
    DLog(@"finish..");
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
                    UIImage *images = nil;
                    if ([image isKindOfClass:[UIImage class]]) {
                        images = (UIImage *)image;
                    } else {

                        return;
                    }

            [GiFHUD GeneralButtonActionView:self.view title:@"图片压缩中"];
            [YQImageCompressTool CompressToImageAtBackgroundWithImage:images ShowSize:images.size FileSize:900*2 block:^(UIImage *resultImage) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [GiFHUD hideHUDForView:self.view];
                    
                    HDragItem *item = [[HDragItem alloc] init];
                    item.image = resultImage;
                    item.backgroundColor = [UIColor purpleColor];
                    [self.itemList addItem:item];
                    
                    [self.imageArray addObject:resultImage];
                    
                    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:resultImage];
                    [self.zlPhotos addObject:photo];
                    
                });
                
            }];
 
        //图片存入相册
        
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        
    } 
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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