//
//  CommonFaceDAO.m
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "CommonFaceDAO.h"
#import "AppDelegate.h"
@implementation CommonFaceDAO
{
    NSManagedObjectContext *managedObjectContext;
}

-(id)init
{
    self = [super init];
    if (self) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        managedObjectContext = delegate.managedObjectContext;
    }
    return self;
}

/**将使用过的表情的信息保存到本地*/
-(BOOL)saveFaceImage:(NSData *)image faceText:(NSString *)text
{
    if (image != nil) {//先查询一下是否已经保存过该表情
       NSArray *faces = [self queryFaceWithFaceText:text];
        CommonFaceModel *commonFace;
        if (faces.count == 0)
        {//如果还没有保存
           commonFace = [NSEntityDescription insertNewObjectForEntityForName:@"CommonFaceModel" inManagedObjectContext:managedObjectContext];
            commonFace.faceImage = image;
            commonFace.faceText = text;
            commonFace.usedTime = [[NSDate date]timeIntervalSince1970];
        }else
        {//如果已经保存
            commonFace = faces[0];
            commonFace.usedTime = [[NSDate date]timeIntervalSince1970];//更新使用时间
        }
        NSError *error = nil;
        //保存
        [managedObjectContext save:&error];
        if (error) {
            NSLog(@"error==%@",error);
            return NO;
        }
    }
    
    return YES;
}

/**根据表情含义查询face*/
-(NSArray *)queryFaceWithFaceText:(NSString *)text
{
    NSArray *faces;
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"CommonFaceModel"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"faceText=%@",text];
    [fetch setPredicate:pre];
    NSError *error = nil;
    [managedObjectContext executeFetchRequest:fetch error:&error];
    if (error) {
        NSLog(@"error===%@",error);
    }
    
    return faces;

}

/**查询所有的表情*/
-(NSArray *)queryAllFace
{
    NSArray *faces;
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"CommonFaceModel"];
    //根据使用时间排序
    NSSortDescriptor *sortDes = [[NSSortDescriptor alloc]initWithKey:@"usedTime" ascending:NO];
    //给请求添加排序
    [fetch setSortDescriptors:@[sortDes]];
    
    //查询
    NSError *error=nil;
   faces = [managedObjectContext executeFetchRequest:fetch error:&error];
    
    if (error) {
        NSLog(@"error===%@",error);
        return nil;
    }
    return faces;
}
@end
