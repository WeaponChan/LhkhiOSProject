//
//  LhkhCalendarView.m
//  NWMJ_B
//
//  Created by LHKH on 2018/4/24.
//  Copyright © 2018年 LHKH. All rights reserved.
//

#import "LhkhCalendarView.h"
@interface LhkhCalendarView()
{
    NSString *dateStr;
    UIButton *_selectBtn;
}

@property (nonatomic, weak) UIButton *preBtn;
@property (nonatomic, weak) UIButton *nextBtn;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *lotLable;
@property (nonatomic, weak) UILabel *selectLable;
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIView *dateView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger firstDays;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSMutableArray *outDataArr;

@end

@implementation LhkhCalendarView

#pragma mark - Life Cycle

+ (instancetype)shareCalendarView
{
    if (IS_iPhoneX_Later) {
        return [[LhkhCalendarView alloc]initWithFrame:CGRectMake(0, 0, Screen_W-10, 360)];
    }else{
        return [[LhkhCalendarView alloc]initWithFrame:CGRectMake(0, 0, Screen_W-10, 345)];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_White;
        UISwipeGestureRecognizer *recognizerR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizerR setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:recognizerR];

        UISwipeGestureRecognizer *recognizerL = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizerL setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:recognizerL];

        _currentDate = [NSDate date];
        UIButton *preBtn = [[UIButton alloc] init];
        [preBtn setImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
        [preBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [preBtn addTarget:self action:@selector(preBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:preBtn];
        self.preBtn = preBtn;
        
        UIButton *nextBtn = [[UIButton alloc] init];
        [nextBtn setImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        self.nextBtn = nextBtn;
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = @"";
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = Color_MainText;
        titleLable.font = systemFontRegular(16);
        [self addSubview:titleLable];
        self.titleLable = titleLable;
        
        UILabel *lotLable = [[UILabel alloc] init];
        lotLable.textAlignment = NSTextAlignmentLeft;
        lotLable.textColor = Color_Theme_Red;
        lotLable.font = systemFontRegular(12);
        [self addSubview:lotLable];
        self.lotLable = lotLable;
        
        UILabel *selectLable = [[UILabel alloc] init];
        selectLable.textAlignment = NSTextAlignmentCenter;
        selectLable.textColor = Color_White;
        selectLable.font = systemFontRegular(14);
        selectLable.backgroundColor = Color_Theme_Red;
        selectLable.numberOfLines = 0;
        [self addSubview:selectLable];
        self.selectLable = selectLable;
        
        UIView *titleView = [[UIView alloc] init];
        titleView.backgroundColor = [UIColor clearColor];
        [self addSubview:titleView];
        self.titleView = titleView;
        
        for (int i = 0; i < self.dateArray.count; i++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.text = self.dateArray[i];
            label.textColor = Color_SubText;
            label.textAlignment = NSTextAlignmentCenter;
            [self.titleView addSubview:label];
            [self.labelArray addObject:label];
        }
        
        UIView *dateView = [[UIView alloc] init];
        dateView.backgroundColor = [UIColor clearColor];
        [self addSubview:dateView];
        self.dateView = dateView;
        [self loadWithDate:_currentDate];
    }
    return self;
}


#pragma mark - Layout SubViews

- (void)layoutSubviews {
    [super layoutSubviews];
    LhkhViewCorner(self, 5);
    self.titleLable.frame = CGRectMake(0, 0, 100, 30);
    self.lotLable.frame = CGRectMake(110, 0, self.width-80-100, 30);
    self.selectLable.frame = CGRectMake(self.width-80, 0, 80, 30);
    
//    self.preBtn.size = CGSizeMake(20, 30);
//    self.preBtn.x = 0;
//    self.preBtn.y = 0;
//
//    self.nextBtn.size = CGSizeMake(20, 30);
//    self.nextBtn.y = 0;
//    self.nextBtn.x = 120;
    
    
    self.titleView.frame = CGRectMake(0, self.titleLable.bottom, self.width, 30);
    self.titleView.backgroundColor = Color_MainBg;
    
    for (int i = 0; i < self.labelArray.count; i++) {
        UILabel *label = self.labelArray[i];
        label.width = self.width / 7;
        label.height = self.titleView.height;
        label.y = 0;
        label.x = i * label.width;
        
    }
    
    self.dateView.frame = CGRectMake(0, self.titleView.bottom+5, self.width,self.height - self.titleView.bottom);
    
    // 计算有多少行
//    NSInteger row = (_firstDays % 7 + _days + 6) / 7;
    
    NSInteger colum = 7;
//    CGFloat buttonH = self.dateView.height / row;
    CGFloat buttonW = self.dateView.width / 7;
    CGFloat buttonH = buttonW;
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = (_firstDays % 7 + i) % colum * buttonW;
        button.y = (_firstDays % 7 + i) / colum * buttonH;
    }
}


#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response

- (void)dayClick:(UIButton*)sender
{
    if (_selectBtn) {
        _selectBtn.layer.borderColor = Color_Clear.CGColor;
        _selectBtn.layer.borderWidth = 0;
        if (_selectBtn.tag == [self getCurrentDay:[NSDate date]]) {
            [_selectBtn setTitleColor:Color_Theme_Red forState:UIControlStateNormal];
        }else{
            [_selectBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        }
    }
    sender.layer.borderColor = Color_Theme_Red.CGColor;
    sender.layer.borderWidth = 1;
    LhkhViewCorner(sender, sender.width/2);
    [sender setTitleColor:Color_Theme_Red forState:UIControlStateNormal];
    _selectBtn = sender;
    
    NSString *days = @"";
    if (sender.tag<10) {
        days = [NSString stringWithFormat:@"0%ld",sender.tag];
    }else{
        days = [NSString stringWithFormat:@"%ld",sender.tag];
    }
    dateStr = [NSString stringWithFormat:@"%@%@日",self.titleLable.text,days];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"年" withString:@"."];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"月" withString:@"."];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    if (dateStr.length==9) {
        NSString *ys = [dateStr substringToIndex:4];
        NSString *ms = [dateStr substringWithRange:NSMakeRange(5, 1)];
        NSString *ds = [dateStr substringFromIndex:7];
        dateStr = [NSString stringWithFormat:@"%@.0%@.%@",ys,ms,ds];
    }
    
    NSDate *datenow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *datenowStr = [formatter stringFromDate:datenow];
    
    
    NSString *weekS = [self getCurrentTimeAndWeekDay:[NSString stringWithFormat:@"%@%@日",self.titleLable.text,days]];//获取到星期几
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer
{
    if(recognizer.direction ==UISwipeGestureRecognizerDirectionLeft) {
        if (self.nextBtn.enabled==YES) {
            [self nextBtnClick];
        }
    }
    
    if(recognizer.direction ==UISwipeGestureRecognizerDirectionRight){
        if (self.preBtn.enabled==YES) {
            [self preBtnClick];
        }
    }
}

- (void)preBtnClick
{
    NSDate *preDate = [self lastMonth:_currentDate];
    [self loadWithDate:preDate];
    [self setNeedsLayout];
    _currentDate = preDate;
}

- (void)nextBtnClick
{
    NSDate *nextDate = [self nextMonth:_currentDate];
    [self loadWithDate:nextDate];
    
    [self setNeedsLayout];
    
    _currentDate = nextDate;
}

#pragma mark - Network requests


#pragma mark - Public Methods


#pragma mark - Private Methods

//获取当前时间日期星期
- (NSString *)getCurrentTimeAndWeekDay:(NSString*)dateS
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formatter dateFromString:dateS];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    long week = [comps weekday];
    
    return  [arrWeek objectAtIndex:week-1];
}

// 获取日
- (NSInteger)getCurrentDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger day = [components day];
    return day;
}

// 获取月
- (NSInteger)getCurrentMonth:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger month = [components month];
    return month;
}

// 获取年
- (NSInteger)getCurrentYear:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger year = [components year];
    return year;
}

// 一个月有多少天
- (NSInteger)getTotalDaysInMonth:(NSDate *)date
{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

// 每月第一天
- (NSInteger)getFirstDayOfMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

// 上个月
- (NSDate *)lastMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

// 下个月
- (NSDate *)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (void)loadWithDate:(NSDate *)date
{
    NSDate *pdate = [self getPriousorLaterDateFromDate];//60天前的date
    // 移除所有
    if (self.buttonArray) {
        [self.buttonArray removeAllObjects];
    }
    
    if (self.dateView.subviews.count > 0) {
        [self.dateView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    // 获取当月有多少天
    _days = [self getTotalDaysInMonth:date];
    _firstDays = [self getFirstDayOfMonth:date];
    
    self.titleLable.text = [NSString stringWithFormat:@"%zd年%zd月",[self getCurrentYear:date],[self getCurrentMonth:date]];
    NSString *weekS = [self getCurrentTimeAndWeekDay:[NSString stringWithFormat:@"%@%zd日",self.titleLable.text,[self getCurrentDay:date]]];//获取到星期几
    
    
    if (12==[self getCurrentMonth:date]&&[self getCurrentYear:date]==[self getCurrentYear:[NSDate date]]) {
        self.nextBtn.enabled = NO;
    }else{
        self.nextBtn.enabled = YES;
    }
    
    for (NSInteger i = 1; i <= _days; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:[NSString stringWithFormat:@"%ld",i] forState:UIControlStateNormal];
        [button setTitleColor:Color_MainText forState:UIControlStateNormal];
        [button setTitleColor:Color_TipText forState:UIControlStateDisabled];
        button.titleLabel.font = systemFontRegular(14);
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:pdate];//60天前的
        NSDateComponents *components1 = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];//选择的
        NSDateComponents *components2 = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];//当前时间的
        
        NSInteger year = [components1 year];
        NSInteger cyear = [components2 year];
        NSInteger pmonth = [components month];
        NSInteger month = [components1 month];
        NSInteger cmonth = [components2 month];
        
        NSInteger m = [self getCurrentMonth:_currentDate];
        NSInteger d = [self getCurrentDay:_currentDate];

        NSInteger pd = [self getCurrentDay:pdate];//60天前的那天
        
        NSString *ms = nil;
        NSString *ds = nil;
        
        
        
        if (m<10) {
            ms = [NSString stringWithFormat:@"0%ld",m];
        }else{
            ms = [NSString stringWithFormat:@"%ld",m];
        }
        if (d<10) {
            ds = [NSString stringWithFormat:@"0%ld",d];
        }else{
            ds = [NSString stringWithFormat:@"%ld",d];
        }
        if (year == cyear) {
            if (month > cmonth) {
                self.preBtn.enabled = YES;
                self.nextBtn.enabled = NO;
                button.enabled = NO;
            }else if(month == cmonth){
                self.preBtn.enabled = YES;
                self.nextBtn.enabled = NO;
                if (i == [self getCurrentDay:[NSDate date]]) {
                    [button setTitle:[NSString stringWithFormat:@"%ld\n今天",i] forState:UIControlStateNormal];
                    button.layer.borderColor = Color_Theme_Red.CGColor;
                    button.layer.borderWidth = 1;
                    LhkhViewCorner(button,(Screen_W-10)/14);
                    _selectBtn = button;
                    [button setTitleColor:Color_Theme_Red forState:UIControlStateNormal];
                    self.selectLable.text = @"今天";
                    
                }else if(i > [self getCurrentDay:[NSDate date]]){
                    button.enabled = NO;
                }else{
                    button.enabled = YES;
                }
            }else if(month<cmonth &&month>pmonth){
                self.preBtn.enabled = YES;
                self.nextBtn.enabled = YES;
                button.enabled = YES;
            }else if (month==pmonth){
                self.preBtn.enabled = NO;
                if (i<pd) {
                    button.enabled = NO;
                }else{
                    button.enabled = YES;
                }
            }
        }else if (year < cyear){
            if (month>pmonth) {
                self.preBtn.enabled = YES;
                button.enabled = YES;
            }else if (month==pmonth){
                self.preBtn.enabled = NO;
                if (i<pd) {
                    button.enabled = NO;
                }else{
                    button.enabled = YES;
                }
             }else{
                 self.preBtn.enabled = NO;
                 button.enabled = NO;
             }
            
        }
        NSString *months = nil;
        NSString *days = nil;

        if (month<10) {
            months = [NSString stringWithFormat:@"0%ld",month];
        }else{
            ms = [NSString stringWithFormat:@"%ld",month];
        }
        if (i<10) {
            days = [NSString stringWithFormat:@"0%ld",i];
        }else{
            days = [NSString stringWithFormat:@"%ld",i];
        }
        
        NSString *dateSting = [NSString stringWithFormat:@"%ld-%@-%@",year,months,days];
        
        if ([self.outDataArr containsObject:dateSting]) {
            button.enabled = NO;
        }
        
        button.tag = i;
        [button addTarget:self action:@selector(dayClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.dateView addSubview:button];
        [self.buttonArray addObject:button];
    }
}


- (NSDate*)getPriousorLaterDateFromDate
{
    //获取当前日期
    NSDate *currentDate = [NSDate date];
    //获取60天前的日期
    int days = 60;    // n天后的天数
    NSDate *appointDate;    // 指定日期声明
    NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒
    appointDate = [currentDate initWithTimeIntervalSinceNow: -oneDay * days];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:appointDate options:0];
    return mDate;
}

#pragma mark - Setters

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

- (NSMutableArray *)dateArray
{
    if (!_dateArray) {
        
        _dateArray = [NSMutableArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    }
    return _dateArray;
}

- (NSMutableArray *)outDataArr
{
    if (!_outDataArr) {
        
        _outDataArr = [NSMutableArray array];
    }
    return _outDataArr;
}


#pragma mark - Getters



@end
