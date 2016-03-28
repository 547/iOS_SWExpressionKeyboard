//
//  FaceView.m
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FaceView.h"
#import <YLImageView.h>
#import <YLGIFImage.h>

@implementation FaceView
{
    YLImageView *ylImageView;
    UIImageView *imageView;//用于展示表情图片
    FaceBlock faceblock;
}
//初始化图片
-(id)initWithFrame:(CGRect)frame
{
    //表情的大小
    frame.size = (CGSize){30,30};
    self = [super initWithFrame:frame];
    
    if (self) {
        ylImageView = [[YLImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self addSubview:ylImageView];
        ylImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *pan=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
-(void)setfaceBlock:(FaceBlock)block
{
    faceblock = block;
}

-(void)setImage:(UIImage *)image faceText:(NSString *)text
{
    [imageView setImage:image];
    //存储图片
    self.faceImage = image;
    self.faceText = text;
}

-(void)setfaceImage:(NSString *)imageStr faceText:(NSString *)text
{
    //显示图片
//    imageView.image=image;
//    [imageView setImage:image];
    ylImageView.image = [YLGIFImage imageNamed:imageStr];
   
    //存储图片
    self.faceImage = [UIImage imageNamed:imageStr];
    self.faceText = text;
}
-(void)tap:(UIPanGestureRecognizer *)t
{
   NSString *fa = [t.view valueForKeyPath:@"faceText"];
    UIImage *face = [t.view valueForKeyPath:@"faceImage"];
    //利用block将被点击的表情的图片和含义传到controller中
    faceblock(face,fa);
}
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    NSLog(@"===%@",NSStringFromCGPoint(point));
//    if (CGRectContainsPoint(self.frame, point)) {
//        NSString *fa = [self valueForKeyPath:@"faceText"];
//        UIImage *face = [self valueForKeyPath:@"faceImage"];
//        NSLog(@"fa===%@",fa);
//        faceblock(face,fa);
//    }
//}











/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


