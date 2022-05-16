//
//  PDFViewController.m
//  WallPaper
//
//  Created by Never on 2020/4/28.
//  Copyright © 2020 Never. All rights reserved.
//

#import "PDFViewController.h"
#import "PDFReaderMainViewController.h"
#import "PDFReaderSlideController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"PDF";
}
- (IBAction)firstButtonTap:(UIButton *)sender {
    [self.navigationController pushViewController:[PDFReaderMainViewController new] animated:YES];
    
}
- (IBAction)secondBtnTap:(UIButton *)sender {
        [self.navigationController pushViewController:[PDFReaderSlideController new] animated:YES];
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
