//
//  PDFView.m
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import "PDFView.h"
@implementation PDFView

-(id)initWithFrame:(CGRect)frame atPage:(long)index withPDFDoc:(CGPDFDocumentRef) pdfDoc{
    self = [super initWithFrame:frame];
    //self.backgroundColor = [UIColor redColor];
    pageNO = (int)index;
    pdfDocument = pdfDoc;
    return self;
}

-(void)drawInContext:(CGContextRef)context atPageNo:(int)page_no{
    // PDF page drawing expects a Lower-Left coordinate system, so we flip the coordinate system
    // before we start drawing.
    
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGRect drawBounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    long pageSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    NSLog(@"pageSum = %ld", pageSum);
    if (pageNO == 0) {
        pageNO = 1;
    }
    CGPDFPageRef page = CGPDFDocumentGetPage(pdfDocument, pageNO);
    CGContextSaveGState(context);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, drawBounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect {
    
    [self drawInContext:UIGraphicsGetCurrentContext() atPageNo:pageNO];
}

@end
