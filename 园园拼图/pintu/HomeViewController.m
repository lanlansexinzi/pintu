//
//  HomeViewController.m
//  拼图
//
//  Created by 耿一 on 2018/1/22.
//  Copyright © 2018年 GY. All rights reserved.
//

#import "HomeViewController.h"
#import "RootViewController.h"
#import "HomepageControl.h"
//这是用来适配X的
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define NavBarHeight 44.0
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度
#define TopHeight (StatusBarHeight + NavBarHeight) //整个导航栏高度



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface HomeViewController ()

@end

@implementation HomeViewController
{
    iCarousel * _iCarouselV;
    NSMutableArray * _imgArr;
    HomepageControl * _pageC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor = RGBCOLOR(247, 203, 204);
    _imgArr = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 1; i <= 4; i++) {
        NSString * str = [NSString stringWithFormat:@"big%ld",i];
        [_imgArr addObject:str];
    }
    
    [self createICarouseView];
    
    // Do any additional setup after loading the view.
}
- (void)createICarouseView
{
    _iCarouselV = [[iCarousel alloc]init];
    
    _iCarouselV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/1.2);
    _iCarouselV.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    _iCarouselV.delegate = self;
    _iCarouselV.dataSource = self;
    _iCarouselV.type = iCarouselTypeRotary;
    _iCarouselV.pagingEnabled = YES;
    
    [self.view addSubview:_iCarouselV];
    
    
    _pageC = [[HomepageControl alloc]init];
    
    
    _pageC.frame = CGRectMake(0 , 0, SCREEN_WIDTH, 50);
    _pageC.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 50);
    _pageC.backgroundColor = [UIColor clearColor];
    _pageC.numberOfPages = _imgArr.count;
    NSLog(@"%ld",_pageC.numberOfPages);
    [self.view addSubview:_pageC];
    
    
    [_iCarouselV reloadData];
    [self performSelector:@selector(aafdfdfd) withObject:nil afterDelay:5];
    

    
}
- (void)aafdfdfd
{
    
    [_iCarouselV reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _imgArr.count;
    
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //    CGSize size =self.frame.size;
    
    
    UIImageView * imageV = (UIImageView*)view;
    
    if (imageV == nil) {
        imageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/1.2, _iCarouselV.frame.size.height)];
        imageV.layer.masksToBounds = YES;
        //设置圆角半径
        imageV.layer.cornerRadius = 8;
        //        imageV.layer.borderWidth = 0.5;
        //        imageV.layer.borderColor = [RGBCOLOR(255, 246, 244) CGColor];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    UIImage * image = [UIImage imageNamed:_imgArr[index]];
    imageV.image = image;
    return imageV;
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了:%ld",index);
    
    RootViewController * rootVC = [[RootViewController alloc]init];
    rootVC.index = index;
    [self presentViewController:rootVC animated:YES completion:nil];
    
}
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    
    
    return SCREEN_WIDTH/1.2;
    
    //    return self.iCarouselV.width;
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            //            NSLog(@"value:%f",value);
            return value * 1.1;
        }
        case iCarouselOptionFadeMax:
        {
            
            return value;
        }
        case iCarouselOptionShowBackfaces:
        {
            return NO;
        }
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}
- (void)carouselDidScroll:(iCarousel *)carousel
{
    //    NSLog(@"FFF:%ld",carousel.currentItemIndex);
    if (_pageC.currentPage != carousel.currentItemIndex) {
        _pageC.currentPage = carousel.currentItemIndex;
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

