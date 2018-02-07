//
//  HomepageControl.h
//  Treasure
//
//  Created by Viptail on 2017/6/1.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface HomepageControl : UIPageControl
{
    
    UIImage* activeImage;
    
    UIImage* inactiveImage;
    
}
@property (nonatomic,assign)CGFloat dotH;

@end
