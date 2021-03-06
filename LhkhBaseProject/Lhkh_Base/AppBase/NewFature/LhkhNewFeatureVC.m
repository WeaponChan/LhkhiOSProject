//
//  LhkhNewFeatureVC.m
//  Lhkh_Base
//
//  Created by LHKH on 2018/4/25.
//  Copyright © 2018年 LHKH. All rights reserved.
//

#import "LhkhNewFeatureVC.h"
#import "LhkhNewFeatureScrollView.h"
#import "LhkhNewFeatureImageV.h"
#import "UIView+LhkhLayout.h"


NSString *const NewFeatureVersionKey = @"NewFeatureVersionKey";

@interface LhkhNewFeatureVC ()


/** 模型数组 */
@property (nonatomic,strong) NSArray *models;

/** scrollView */
@property (nonatomic,weak) LhkhNewFeatureScrollView *scrollView;

@property (nonatomic,copy) void(^enterBlock)(void);

@end

@implementation LhkhNewFeatureVC

//检查新版本
/*
 *  初始化
 */
+(instancetype)newFeatureVCWithModels:(NSArray *)models enterBlock:(void(^)(void))enterBlock
{
    
    LhkhNewFeatureVC *newFeatureVC = [[LhkhNewFeatureVC alloc] init];
    
    newFeatureVC.models = models;
    
    //记录block
    newFeatureVC.enterBlock = enterBlock;
    
    return newFeatureVC;
}


-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //控制器准备
    [self vcPrepare];
    
    //显示了版本新特性，保存版本号
    [self saveVersion];
}


/*
 *  显示了版本新特性，保存版本号
 */
-(void)saveVersion
{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow = APP_VERSON;
    
    //保存版本号
    [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
}



/*
 *  控制器准备
 */
-(void)vcPrepare
{
    //添加scrollView
    LhkhNewFeatureScrollView *scrollView = [[LhkhNewFeatureScrollView alloc] init];
    
    _scrollView = scrollView;

    //添加
    [self.view addSubview:scrollView];
    
    //添加约束
    [scrollView autoLayoutFillSuperView];
    
    //添加图片
    [self imageViewsPrepare];
}
/*
 *  添加图片
 */
-(void)imageViewsPrepare
{
    __weak typeof(self) weakself = self;
    [self.models enumerateObjectsUsingBlock:^(LhkhNewFeatureModel *model, NSUInteger idx, BOOL *stop) {
        
        LhkhNewFeatureImageV *imageV = [[LhkhNewFeatureImageV alloc] init];
        
        //设置图片
        imageV.image = model.image;
        
        //记录tag
        imageV.tag = idx;
        imageV.userInteractionEnabled = YES;
        if(idx == weakself.models.count -1) {
            UIButton *skipBtn = [[UIButton alloc] initWithFrame:CGRectZero];
            [skipBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [skipBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
            [skipBtn addTarget:self action:@selector(skipClick) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:skipBtn];
            [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(imageV).offset(-100);
                make.centerX.equalTo(imageV.mas_centerX);
                make.height.offset(40);
                make.width.offset(120);
            }];
            skipBtn.layer.borderColor = Color_Theme_Red.CGColor;
            skipBtn.layer.borderWidth = 1;
            LhkhViewCorner(skipBtn, 20);
        }else{
            UIButton *skipBtn = [[UIButton alloc] initWithFrame:CGRectZero];
            [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
            [skipBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
            [skipBtn addTarget:self action:@selector(skipClick) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:skipBtn];
            [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageV).offset(NavigationBar_H/2);
                make.right.equalTo(imageV).offset(-20);
                make.height.offset(60);
                make.width.offset(60);
            }];
        }
        
        [weakself.scrollView addSubview:imageV];
    }];
}

- (void)skipClick
{
    [self dismiss];
}

-(void)dismiss
{
    if(self.enterBlock != nil) _enterBlock();
}

/*
 *  是否应该显示版本新特性页面
 */
+(BOOL)canShowNewFeature
{
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow = APP_VERSON;

    //读取本地版本号
    NSString *versionLocal = [[NSUserDefaults standardUserDefaults] objectForKey:NewFeatureVersionKey];
    NSLog(@"系统版本号为：%@-----本地版本号为：%@",versionValueStringForSystemNow,versionLocal);
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){
        //说明有本地版本记录，且和当前系统版本一致
        return NO;
        
    }else{
        //无本地版本记录或本地版本记录与当前系统版本不一致
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
        
        return YES;
    }
}
@end
