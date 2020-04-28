//
//  PDFPageModel.h
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIPageViewController.h>
@class PDFPageController;
@interface PDFPageModel : NSObject <UIPageViewControllerDataSource>
{
    CGPDFDocumentRef pdfDocument;
}

-(id) initWithPDFDocument:(CGPDFDocumentRef) pdfDocument;

- (PDFPageController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(PDFPageController *)viewController;
@end
