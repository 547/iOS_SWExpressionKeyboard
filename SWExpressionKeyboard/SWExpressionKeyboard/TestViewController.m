//
//  TestViewController.m
//  SWExpressionKeyboard
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "TestViewController.h"
#import "FunctionView.h"
#import <UIView+SDAutoLayout.h>
#import "Data.h"
#import "CommonFaceDAO.h"
@interface TestViewController ()

@end

@implementation TestViewController
{
    FunctionView *functionView;
    BOOL shouldShow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
//    self.textField = [[UITextField alloc]init];
//    self.textField.sd_layout
//    .leftSpaceToView(self.view,20)
//    .topSpaceToView(self.view,50)
//    .heightIs(25)
//    .widthIs(SCREENWIDTH*0.5);
//    [self.view addSubview:_textField];
    
//    FaceButton *faceButton = [[FaceButton alloc]initWithFrame:CGRectMake(10, 50, 25, 25)];
//   [faceButton setFaceButtonBlock:^(BOOL show) {
//       
//       if (show) {
//           functionView = [[FunctionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 216)];
//           functionView.sd_layout
//           .bottomEqualToView(self.view)
//           .leftEqualToView(self.view)
//           .rightEqualToView(self.view);
//           [self.view addSubview:functionView];
//       }else{
//           [functionView removeFromSuperview];
//       }
//   }];
//    [self.view addSubview:faceButton];
    
    
    UIButton *faceButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 50, 30, 30)];
    [self.view addSubview:faceButton];
    [faceButton setImage:[UIImage imageNamed:@"001.png"] forState:UIControlStateNormal];
    [faceButton addTarget:self action:@selector(faceButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)faceButton:(UIButton *)button
{
    shouldShow = !shouldShow;
    if (shouldShow) {
        functionView = [[FunctionView alloc]initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 216)];
        functionView.sd_layout
        .bottomEqualToView(self.view)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view);
        [self.view addSubview:functionView];
        functionView.plistFileName=@"emoticons";
        
        [functionView setFunctionBlock:^(UIImage *image, NSString *text) {
            CommonFaceDAO *dao=[[CommonFaceDAO alloc]init];
            [dao saveFaceImage:UIImagePNGRepresentation(image) faceText:text];
            NSLog(@"===%@",text);
        }];
        
        }else{
        [functionView removeFromSuperview];
        }
    

}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
