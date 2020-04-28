//
//  PDFPageController.h
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFPageController : UIViewController
@property (assign, nonatomic) CGPDFDocumentRef pdfDocument;
@property (assign, nonatomic) long pageNO;
@end
