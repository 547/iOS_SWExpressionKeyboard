//
//  CommonFaceModel+CoreDataProperties.h
//  
//
//  Created by mac on 16/3/26.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//


/**常用表情*/
#import "CommonFaceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonFaceModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *faceImage;//表情的图片
@property (nullable, nonatomic, retain) NSString *faceText;//表情的含义
@property (nonatomic) NSTimeInterval usedTime;//表情的使用时间


@end

NS_ASSUME_NONNULL_END
