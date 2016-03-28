//
//  FaceView.h
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 Seven. All rights reserved.
//


/**表情类*/
#import <UIKit/UIKit.h>
//声明表情对应的block，用于把用户的点击图片和含义传到上层视图
typedef void(^FaceBlock)(UIImage *image,NSString *text);

@interface FaceView : UIView

@property(nonatomic,copy)NSString *faceText;//表情的含义
@property(nonatomic,copy)UIImage *faceImage;//表情图片
-(void)setfaceBlock:(FaceBlock)block;//设置Block的回调
//设置表情的图片和含义
-(void)setfaceImage:(NSString *)imageStr faceText:(NSString *)text;
-(void)setImage:(UIImage *)image faceText:(NSString *)text;

@end
