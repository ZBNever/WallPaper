//
//  PDFReaderViewController.h
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFPageModel.h"

@interface PDFReaderMainViewController : UIViewController{
    UIPageViewController *pageViewCtrl;
    PDFPageModel *pdfPageModel;
}


-(void) skip: (NSInteger) num;
@end
