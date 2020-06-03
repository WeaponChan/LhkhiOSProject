//
//  WPhotoViewController.m
//  photoDemo
//
//  Created by wangxinxu on 2017/6/1.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import "WPhotoViewController.h"
#import <Photos/Photos.h>

@interface WPhotoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *finishBtn;

//显示照片
@property (nonatomic, strong) UICollectionView *ado_collectionView;

//所有照片组的数组（内部是所有相册的组）
@property (nonatomic, strong) NSMutableArray *photoGroupArr;

//所有照片组内的url数组（内部是最大的相册的照片url，这个相册一般名字是 所有照片或All Photos）
@property (nonatomic, strong) NSMutableArray *allPhotoArr;

//所选择的图片数组
@property (nonatomic, strong) NSMutableArray *chooseArray;

//所选择的图片所在cell的序列号数组
@property (nonatomic, strong) NSMutableArray *chooseCellArray;

@property (nonatomic, strong) NSMutableArray *choosePhotoArr;


@property (nonatomic, strong) PHCachingImageManager *imageManager;

@end

@implementation WPhotoViewController

#pragma mark - **************** 懒加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_MainBg;
    self.navigationItem.title = [NSString stringWithFormat:@"已选0/%ld张",_selectPhotoOfMax];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishChoosePhotos:)];
    [self.view addSubview:[self ado_collectionView]];
    [self getAllPhotos];
    
}

#pragma mark GetAllPhotos
- (void)getAllPhotos
{
    [self getHeightVersionAllPhotos];
}

#pragma mark 高版本使用PhotoKit框架
- (void)getHeightVersionAllPhotos {
    
    [WPFunctionView getHeightVersionAllPhotos:^(PHFetchResult *allPhotos) {
        
        self->_imageManager = [[PHCachingImageManager alloc]init];
        
        if (!self->_allPhotoArr) {
            self->_allPhotoArr = [[NSMutableArray alloc]init];
        }
        
        for (NSInteger i = 0; i < allPhotos.count; i++) {
            
            PHAsset *asset = allPhotos[i];
            if (asset.mediaType == PHAssetMediaTypeImage) {
                [self->_allPhotoArr addObject:asset];
            }
            
            NSString *cellId = [NSString stringWithFormat:@"cell%ld", (long)i];
            [self.ado_collectionView registerClass:[myPhotoCell class] forCellWithReuseIdentifier:cellId];
            
        }
        [self.ado_collectionView reloadData];
    }];
}

#pragma mark Collection
-(UICollectionView *)ado_collectionView
{
    if (!_ado_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake((SelfView_W-50)/4, (SelfView_W-50)/4)];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _ado_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SelfView_W, SelfView_H) collectionViewLayout:layout];
        _ado_collectionView.backgroundColor = [UIColor whiteColor];
        _ado_collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _ado_collectionView.dataSource = self;
        _ado_collectionView.delegate = self;
        
        [self.ado_collectionView registerClass:[myPhotoCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _ado_collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allPhotoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_allPhotoArr.count) {
        NSString *cellId = [NSString stringWithFormat:@"cell%ld", (long)indexPath.row];
        myPhotoCell *cell = (myPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        
        PHAsset *asset = _allPhotoArr[_allPhotoArr.count - indexPath.item - 1];
        cell.progressView.hidden = YES;
        cell.representedAssetIdentifier = asset.localIdentifier;
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize cellSize = cell.frame.size;
        CGSize AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
        
        [_imageManager requestImageForAsset:asset
                                 targetSize:AssetGridThumbnailSize
                                contentMode:PHImageContentModeDefault
                                    options:nil
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                  if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                      cell.photoView.image = result;
                                  }
                              }];
        
        return cell;
    } else {
        myPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_chooseArray) {
        _chooseArray = [[NSMutableArray alloc]init];
    }
    if (!_chooseCellArray) {
        _chooseCellArray = [[NSMutableArray alloc]init];
    }
    
    if (self.chooseArray.count == self.selectPhotoOfMax) {
        [MBProgressHUD showTips:[NSString stringWithFormat:@"最多只能选择%ld张",self.selectPhotoOfMax]];
    }
    
    myPhotoCell *cell = (myPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    PHAsset *asset = _allPhotoArr[_allPhotoArr.count-indexPath.row-1];
    
    [WPFunctionView getChoosePicPHImageManager:^(double progress) {
        
        cell.progressView.hidden = NO;
        cell.progressFloat = progress;

    } manager:^(UIImage *result) {
        cell.progressView.hidden = YES;
        if (!result) {
            return;
        } else {
            if (cell.chooseStatus == NO) {
                if ((self->_chooseArray.count+self->_choosePhotoArr.count)< self->_selectPhotoOfMax) {
                    [self->_chooseArray addObject:result];
                    [self->_chooseCellArray addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                    UIImageView *signImage = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-22-5, 5, 22, 22)];
                    signImage.layer.cornerRadius = 22/2;
                    signImage.image = WPhoto_Btn_Selected;
                    signImage.layer.masksToBounds = YES;
                    [cell addSubview:signImage];
                    
                    [WPFunctionView shakeToShow:signImage];
                    cell.chooseStatus = YES;
                    self.navigationItem.title = [NSString stringWithFormat:@"已选%ld/%ld张",self.chooseArray.count,self->_selectPhotoOfMax];
                }
                if ([self.singleType isEqualToString:@"1"] && self.chooseArray.count==self->_selectPhotoOfMax) {
                    [self finishChoosePhotos:nil];
                }
            } else{
                for (NSInteger i = 2; i<cell.subviews.count; i++) {
                    [cell.subviews[i] removeFromSuperview];
                }
                for (NSInteger j = 0; j<self->_chooseCellArray.count; j++) {
                    
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:[self->_chooseCellArray[j] integerValue] inSection:0];
                    
                    if (indexPath.row == ip.row) {
                        [self->_chooseArray removeObjectAtIndex:j];
                    }
                }
                [self->_chooseArray removeObject:result];
                [self->_chooseCellArray removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                cell.chooseStatus = NO;
                self.navigationItem.title = [NSString stringWithFormat:@"已选%ld/%ld张",self.chooseArray.count,self->_selectPhotoOfMax];
            }
        }
    } asset:asset viewSize:self.view.bounds.size];
}


-(void)finishChoosePhotos:(UIButton *)finishbtn
{
    [WPFunctionView finishChoosePhotos:^(NSMutableArray *myChoosePhotoArr) {
        self->_selectPhotosBack(myChoosePhotoArr);
        [self btnClickBack];
    } chooseArray:_chooseArray];
}

#pragma mark 返回
-(void)btnClickBack
{
    if ([self.singleType isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
