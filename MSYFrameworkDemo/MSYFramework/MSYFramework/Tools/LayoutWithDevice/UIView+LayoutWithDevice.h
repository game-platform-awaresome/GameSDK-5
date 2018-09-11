//
//  UIView+LayoutWithDevice.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/17.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutWithDevice)
-(CGSize)GZLayoutWithDevice:(UIView *)superView
          AndPad_land_width:(float)pad_land_width
          AndPad_land_height:(float)pad_land_height
       AndPad_portrait_width:(float)pad_portrait_width
      AndPad_portrait_height:(float)pad_portrait_height
         AndPhone_land_width:(float)phone_land_width
         AndPhone_land_height:(float)phone_land_height
     AndPhone_portrait_width:(float)phone_portrait_width
    AndPhone_portrait_height:(float)phone_portrait_height
             AndX_land_width:(float)X_land_width
        AndX_land_height:(float)X_land_height
     AndX_portrait_width:(float)X_portrait_width
        AndX_portrait_height:(float)X_portrait_height;


@end
