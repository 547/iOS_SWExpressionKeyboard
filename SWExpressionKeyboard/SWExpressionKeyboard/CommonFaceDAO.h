//
//  CommonFaceDAO.h
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**常用表情*/
#import <Foundation/Foundation.h>
#import "CommonFaceModel.h"
@interface CommonFaceDAO : NSObject
/**将使用过的表情的信息保存到本地*/
-(BOOL)saveFaceImage:(NSData *)image faceText:(NSString *)text;

/**查询所有的表情*/
-(NSArray *)queryAllFace;
@end
