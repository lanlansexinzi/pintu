//
//  RootViewController.m
//  拼图
//
//  Created by GY on 15/12/16.
//  Copyright © 2015年 GY. All rights reserved.
//

#import "RootViewController.h"


//这是用来适配X的
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define NavBarHeight 44.0
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度
#define TopHeight (StatusBarHeight + NavBarHeight) //整个导航栏高度



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface RootViewController ()
@property CGFloat width;
@property CGFloat height;
@property UIImageView *tempimage;

@end

@implementation RootViewController
{
    UIColor * _backColor;
    NSMutableArray * _imgArr;
    NSMutableArray * _imgVArr;
    
    NSMutableArray * _allImgArr;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tempimage = [[UIImageView alloc]init];
    
    NSInteger x =arc4random() % 4;
    NSLog(@"%ld",x);
    switch (x) {
        case 0:
            _backColor = RGBCOLOR(174, 160, 174);
            break;
        case 1:
            _backColor = RGBCOLOR(224, 246, 244);
            break;
        case 2:
            _backColor = RGBCOLOR(223, 238, 238);
            break;
        case 3:
            _backColor = RGBCOLOR(247, 203, 204);
            break;
        case 4:
            _backColor = RGBCOLOR(219, 199, 229);
            break;
        default:
            break;
    }
    
    _imgArr = [[NSMutableArray alloc]init];
    _imgVArr = [[NSMutableArray alloc]init];
    
    _allImgArr = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 1; i <= 4; i++) {
        NSString * str = [NSString stringWithFormat:@"small%ld",i];
        [_allImgArr addObject:str];
    }
    
    
    [self createScene];
    
    self.view.backgroundColor = _backColor;
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backBtn.frame = CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 100, 50, 30);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 3;
    backBtn.layer.borderWidth = 0.5;
    backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    
}
- (void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef CGImage = CGImageCreateWithImageInRect(image.CGImage, rect);
    return [UIImage imageWithCGImage:CGImage];
}

- (void)createScene
{
    //    UIImage *bigImg =[self clipImage:[UIImage imageNamed:@"qianqian.jpeg"] withRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *bigImg = [self compressOriginalImage:[UIImage imageNamed:_allImgArr[_index]] toSize:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH)];
    CGFloat fixelW = CGImageGetWidth(bigImg.CGImage);
    NSLog(@"%f",fixelW);
    UIImageView * imageView = [[UIImageView alloc]initWithImage:bigImg];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    imageView.center = CGPointMake(100,SCREEN_HEIGHT - SCREEN_WIDTH/2 + 50);
    
    [self.view addSubview:imageView];
    
    _width = SCREEN_WIDTH/3;
    _height =SCREEN_WIDTH/3;
    for (NSInteger i = 0; i<3; i++) {
        for (NSInteger j = 0; j<3; j++) {
            UIImageView * smallImgV = [[UIImageView alloc]init];
            //           imageview.frame = CGRectMake((_width) * j, (_height) * i+30, _width, _height);
            smallImgV.frame = CGRectMake(_width*(2-j), _height*(2-i)+StatusBarHeight, _width, _height);
            smallImgV.layer.borderWidth = 0.5;
            smallImgV.layer.borderColor = [_backColor CGColor];
            if (i!=2||j!=2) {
                UIImage * image = [self clipImage:bigImg withRect:CGRectMake(_width*j, _height*i, _width, _height)];
                [_imgArr addObject:image];
                [_imgVArr addObject:smallImgV];
                //                imageview.image =[self clipImage:bigImg withRect:CGRectMake(_width*j, _height*i, _width, _height)];
            }else{
                _tempimage = smallImgV;
            }
            
            [self.view addSubview:smallImgV];
            smallImgV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandle:)];
            [smallImgV addGestureRecognizer:tgr];
        }
    }
    
    NSMutableArray * newArr = [self getRandomArrFrome:_imgArr];
    
    for (NSInteger i = 0; i < _imgVArr.count; i++) {
        UIImageView * imgV = _imgVArr[i];
        imgV.image = newArr[i];
    }
}

//随机遍历数组
-(NSMutableArray*)getRandomArrFrome:(NSArray*)arr
{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}
/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param newSize  目标大小
 *
 *  @return 生成图片
 */
-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)newSize
{
    
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
- (void)tapGestureHandle:(UITapGestureRecognizer *)tgr
{
    CGFloat width = tgr.view.frame.size.width;
    CGPoint center = tgr.view.center;
    if (fabs(center.x - _tempimage.center.x)+fabs(center.y - _tempimage.center.y)==width) {
        CGPoint temp = center;
        tgr.view.center = _tempimage.center;
        _tempimage.center = temp;
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

