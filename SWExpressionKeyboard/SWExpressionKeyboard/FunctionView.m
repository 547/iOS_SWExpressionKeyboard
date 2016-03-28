//
//  FunctionView.m
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FunctionView.h"
#import "CommonFaceModel.h"
#import <UIView+SDAutoLayout.h>
#import "Data.h"
#import "FaceView.h"
#import "CommonFaceDAO.h"
@implementation FunctionView
{
    FunctionBlock functionBlock;
    
    //暂存表情组件回调的表情和含义
    NSString *faceText;
    UIImage *faceImage;
    UIScrollView *facesView;//展示表情集合
    CommonFaceModel *commomFace;//常用表情
}

-(id)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    if (self) {
//        commomFace = [[CommonFaceModel alloc]init];//实例化常用表情
       
        
        //实例化表情集合下面的button
        //常用表情按钮
        UIButton *commomButton = [[UIButton alloc]init];
        commomButton.sd_layout.leftEqualToView(self)
        .topSpaceToView(facesView,10)
        .widthIs(SCREENWIDTH*0.5)
        .heightIs(44);
        commomButton.backgroundColor = [UIColor lightGrayColor];
        [commomButton setTitle:@"常用表情" forState:UIControlStateNormal];
        [commomButton addTarget:self action:@selector(commomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         //所有表情按钮
        UIButton *allButton = [[UIButton alloc]init];
        allButton.sd_layout
        .leftSpaceToView(commomButton,0)
        .widthIs(SCREENWIDTH*0.5)
        .bottomEqualToView(self)
        .rightEqualToView(self)
        .heightIs(44);
        allButton.backgroundColor=[UIColor lightGrayColor];
        [allButton setTitle:@"全部表情" forState:UIControlStateNormal];
        [allButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:commomButton];
        [self addSubview:allButton];
        
        
    }
    return self;
}

//接收回调
-(void)setFunctionBlock:(FunctionBlock)block
{
    functionBlock = block;
}

//常用表情按钮
-(void)commomButtonClick:(UIButton *)commom
{
    CommonFaceDAO *commonFaceDAO = [[CommonFaceDAO alloc]init];
   NSArray *faces = [commonFaceDAO queryAllFace];
    [self showAllface:faces];
}

//全部表情按钮
-(void)allButtonClick:(UIButton *)all
{
    //从plist文件载入资源
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:self.plistFileName ofType:@"plist"];
    
   NSArray *faces = [NSArray arrayWithContentsOfFile:plistPath];
    if (faces.count == 0) {
        NSLog(@"访问的文件不存在");
    }else{
        [self showAllface:faces];//展示所有的表情
    }
}
-(void)setPlistFileName:(NSString *)plistFileName
{
    _plistFileName=plistFileName;
    [self allButtonClick:nil];//默认显示所有表情
}
//展示图片
-(void)showAllface:(NSArray *)faces
{
    [facesView removeFromSuperview];//先移除
    facesView = [[UIScrollView alloc]init];//实例化装表情集合的ScrollView
    facesView.bounces=NO;
    facesView.showsHorizontalScrollIndicator = NO;
    facesView.backgroundColor = [UIColor whiteColor];
    facesView.sd_layout.leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self,10)
    .bottomSpaceToView(self,44)
    .widthIs(SCREENWIDTH)
    .heightIs(self.frame.size.height-44);
    [self addSubview:facesView];
    
     NSLog(@"%@",NSStringFromCGRect(facesView.frame));
    
    CGFloat height = facesView.frame.size.height-10;
    //根据表情的数量来计算ScrollView的宽度
//    CGFloat width = faces.count/(height/30)*30;

    CGFloat width = faces.count/(height/40)*40+60;
    facesView.contentSize = CGSizeMake(width,height);
    facesView.pagingEnabled = YES;
    
    //图片坐标
    CGFloat x = 0;
    CGFloat y = 0;
    
    //往scroll上贴图片
    for (int i=0; i<faces.count; i++) {
        //获取图片信息
        UIImage *faceI;
        NSString *faceStr;
        if ([faces[i][@"png"] isKindOfClass:[NSString class]])
        {
            faceStr=faces[i][@"gif"];
            faceI = [UIImage imageNamed:faces[i][@"png"]];
        }
        else
        {
            faceI = faces[i][@"png"];
        }
        NSString *faceT = faces[i][@"chs"];//获取表情的含义
        
        //计算图片的位置===九宫格的算法
//        y = (i%(int)(height/30))*30;
//        x = (i/(int)(height/30))*30;
        y = (i%(int)(height/40))*(30+10)+10;
        x = (i/(int)(height/40))*(30+10)+10;
        
        FaceView *face=[[FaceView alloc]initWithFrame:CGRectMake(x, y, 0, 0)];
       
        [face setfaceImage:faceStr faceText:faceT];

        [face setfaceBlock:^(UIImage *image, NSString *text) {
            functionBlock(image,text);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
        }];
        [facesView addSubview:face];
    }
    [facesView setNeedsDisplay];
}



















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
