//
//  PDFPageController.m
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import "PDFPageController.h"
#import "PDFView.h"

@interface PDFPageController ()

@end

@implementation PDFPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    PDFView *pdfView = [[PDFView alloc] initWithFrame:frame atPage:self.pageNO withPDFDoc:self.pdfDocument];
    pdfView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:pdfView];


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
