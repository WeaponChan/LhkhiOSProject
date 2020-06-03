//
//  LhkhPickerView.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/10/23.
//  Copyright © 2017 LHKH. All rights reserved.
//
#define PICKVIEW_HEIGHT 216.0f
#import "LhkhPickerView.h"
#import "LhkhPCAModel.h"
@interface LhkhPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    BOOL _isSingle;
}
@property (strong, nonatomic) NSArray *pickerDataSource;
@property (strong, nonatomic) NSDictionary *pickerMoreDataSource;

@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *areaArray;
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) LhkhProvince *currentProvince;
@property (strong, nonatomic) LhkhCity *currentCity;

@end

@implementation LhkhPickerView

#pragma mark - Life Cycle

+ (instancetype)pickerView:(NSArray *)pickerData single:(BOOL)isSingle
{
    return [[[self class] alloc] initWithDataSource:pickerData single:isSingle];
}

+ (instancetype)pickerViewWithMore:(NSDictionary *)pickerData single:(BOOL)isSingle{
    return [[[self class] alloc] initWithMoreDataSource:pickerData single:isSingle];
}

- (instancetype)initWithDataSource:(NSArray*)dataSource single:(BOOL)isSingle{
    if (self = [super init]) {
        self.pickerDataSource = dataSource;
        _isSingle = isSingle;
        self.frame = CGRectMake(0, 0, 0, PICKVIEW_HEIGHT);
        self.dataSource = self;
        self.delegate = self;
        [self pickerView:self didSelectRow:0 inComponent:0];
    }
    return self;
}

- (instancetype)initWithMoreDataSource:(NSDictionary*)dataSource single:(BOOL)isSingle{
    if (self = [super init]) {
        self.pickerMoreDataSource = dataSource;
        _isSingle = isSingle;
        self.frame = CGRectMake(0, 0, 0, PICKVIEW_HEIGHT);
        self.dataSource = self;
        self.delegate = self;
        [self pickerView:self didSelectRow:0 inComponent:0];
    }
    return self;
}


#pragma mark <UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_isSingle) {
        return 1;
    }
    return self.datas.count;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_isSingle) {
        return self.pickerDataSource.count;
    }else{
        NSArray *tempA = self.datas[component];
        return tempA.count;
    }
}


#pragma mark <UIPickerViewDelegate>
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (_isSingle) {
        return [self.pickerDataSource objectAtIndex:row];
    }else{
        if (component == 0) {
            LhkhProvince *province = self.provinceArray[component];
            return province.name;
        } else if (component == 1) {
            self.currentCity = self.cityArray[row];
            return self.currentCity.name;
        } else {
            return self.areaArray[row];
        }
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (_isSingle) {
        self.selectedTitle = [self.pickerDataSource objectAtIndex:row];
    }else{
        if (component == 0) {
            [pickerView reloadComponent:1];
        }else if(component == 1){
            self.currentCity = self.cityArray[row];
            [self.areaArray removeAllObjects];
            [self.areaArray addObjectsFromArray:self.currentCity.area];
            [pickerView reloadComponent:2];
        }
        
        LhkhProvince *pModel = [self.provinceArray objectAtIndex:[self selectedRowInComponent:0]];
        LhkhCity *cModel = [self.cityArray objectAtIndex:[self selectedRowInComponent:1]];
        
        
        self.selectedTitle = [NSString stringWithFormat: @"%@ %@ %@",pModel.name,cModel.name,[self.areaArray objectAtIndex:[self selectedRowInComponent:2]]];
    }
    
}


#pragma getter & setter

- (NSMutableArray*)provinceArray
{
    if (!_provinceArray) {
        LhkhProvince *model = [LhkhProvince mj_objectWithKeyValues:self.pickerMoreDataSource];
        _provinceArray = [NSMutableArray array];
        [_provinceArray addObject:model];
        self.currentProvince = _provinceArray.firstObject;
    }
    return _provinceArray;
}

- (NSMutableArray*)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
        [_cityArray addObjectsFromArray:[LhkhCity mj_objectArrayWithKeyValuesArray:self.currentProvince.city]];
        self.currentCity = _cityArray.firstObject;
    }
    return _cityArray;
}

- (NSMutableArray*)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
        [_areaArray addObjectsFromArray:self.currentCity.area];
    }
    return _areaArray;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray arrayWithObjects:self.provinceArray, self.cityArray, self.areaArray, nil];
    }
    return _datas;
}

@end
