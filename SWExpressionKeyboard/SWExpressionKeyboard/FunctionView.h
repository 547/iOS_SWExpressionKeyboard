//
//  FunctionView.h
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 Seven. All rights reserved.
//


/**用于展示表情集合、表情集合下面的Button的视图*/
//表情集合是用scrollView来装的
#import <UIKit/UIKit.h>

//用于数据交互
typedef void(^FunctionBlock)(UIImage *image,NSString *text);
@interface FunctionView : UIView
-(void)setFunctionBlock:(FunctionBlock)block;//接受Block块
@property(nonatomic,strong)NSString *plistFileName;//表情资源文件名

@end
