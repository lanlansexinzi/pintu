//
//  HomepageControl.m
//  Treasure
//
//  Created by Viptail on 2017/6/1.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "HomepageControl.h"
#define RGBCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@implementation HomepageControl

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
//设置page的图片
//    [_pagC setValue:[UIImage imageNamed:@"aaaa"] forKeyPath:@"pageImage"];
//    [_pagC setValue:[UIImage imageNamed:@"bbbb"] forKeyPath:@"currentPageImage"];
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
       self.dotH = 5;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dotH = 5;
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //宽高和间距
//    CGFloat dotW = 40;
    CGFloat dotW = 5;
    
    CGFloat magrin = 5;

    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count) * marginX;
    
    if (!isnan(newW)) {
        //设置新frame
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    }
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIView* dot = [self.subviews objectAtIndex:i];
        
        
        if (i == self.currentPage) {
            
            [dot setFrame:CGRectMake(i * marginX - 2, (self.frame.size.height - self.dotH)/2, 8, self.dotH)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, (self.frame.size.height - self.dotH)/2, dotW, self.dotH)];
        }
        
        //添加imageV
        if ([dot.subviews count] == 0) {
            UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
            [dot addSubview:view];
        };
        UIImageView * imageV = dot.subviews[0];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 2.5;
        if (i == self.currentPage) {
            
            imageV.backgroundColor = RGBCOLOR(251, 192, 45);
        }else {
            imageV.backgroundColor = RGBCOLOR(224, 225, 224);
        }
        imageV.frame = dot.bounds;
    }
    
    
}
//-(id) initWithFrame:(CGRect)frame
//
//{
//    
//    self = [super initWithFrame:frame];
//    
//    
//    activeImage = [UIImage imageNamed:@"home"] ;
//    
//    inactiveImage = [UIImage imageNamed:@"news"];
//    
//    
//    return self;
//    
//}
//
//
-(void) updateDots

{
    
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 5;     //自定义圆点的大小
        
        size.width = 5;      //自定义圆点的大小
        
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.height)];
        if (i == self.currentPage){
            dot.backgroundColor = [UIColor blueColor];
        }
        else{
            dot.backgroundColor = [UIColor redColor];
        }
        
    }

    
    
}
//
//-(void) setCurrentPage:(NSInteger)page
//
//{
//    
//    [super setCurrentPage:page];
//    
//    [self updateDots];
//    
//}
@end
