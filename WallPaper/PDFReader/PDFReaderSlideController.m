//
//  PDFReaderSlideController.m
//  PDFReader
//
//  Created by  atide on 16/6/7.
//  Copyright © 2016年  atide. All rights reserved.
//

#import "PDFReaderSlideController.h"
#import "PDFView.h"
#import "ContentsViewController.h"
#import "CommentNode.h"
@interface PDFReaderSlideController(){
    CGPDFDocumentRef pdfDocument;
    NSInteger pageNum;
}
@end

@implementation PDFReaderSlideController
@synthesize scale_;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"PDF浏览";
    [self.pdfView layoutIfNeeded];
    CGRect frame = CGRectMake(0, 0, self.pdfView.bounds.size.width, self.pdfView.bounds.size.height);
    CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)@"002.pdf", NULL, NULL);
    pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    CFRelease(pdfURL);
    
     pageNum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;      //整页平移是否开启
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = frame.size;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
   
    offset = 0.0;
    scale_ = 1.0;
    
    
    [self.pdfView addSubview:_scrollView];
    
    _prevPageView = [self createItemView:0];
    
    [_scrollView addSubview:_prevPageView];
    
    _currentPageView = [self createItemView:1];
    [_scrollView addSubview:_currentPageView];
    
    _nextPageView = [self createItemView:2];
    
    [_scrollView addSubview:_nextPageView];
    _scrollView.delegate = self;
    [self updatePageViews];
    UIButton * button = [[UIButton alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        button.frame = CGRectMake(self.view.frame.size.width-30, self.view.frame.size.height-30, 20, 20);
    }else{
        button.frame = CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50, 35, 35);
    }
    [button setBackgroundImage:[UIImage imageNamed:@"mainMore"] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [button addGestureRecognizer:tap];
   [self.view addSubview:button];
    
    _labelPage = [[UILabel alloc] init];
    _labelPage.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _labelPage.textAlignment = NSTextAlignmentCenter;
    _labelPage.textColor = [UIColor whiteColor];
    _labelPage.text = [NSString stringWithFormat:@"1/%ld",(long)pageNum];
    _labelPage.frame = CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-30, 100, 30);
     [self.view addSubview:_labelPage];
}

-(UIScrollView *) createItemView: (NSInteger) index{
    if (index>pageNum) {
        index = pageNum;
    }
    UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    CGRect itemFrame = CGRectMake(0, 0, self.pdfView.bounds.size.width, self.pdfView.bounds.size.height);
    UIScrollView *s = [[UIScrollView alloc] initWithFrame:itemFrame];
    s.backgroundColor = [UIColor clearColor];
    s.contentSize = itemFrame.size;
    s.showsHorizontalScrollIndicator = NO;
    s.showsVerticalScrollIndicator = NO;
    
    s.delegate = self;
    s.minimumZoomScale = 1.0;
    s.maximumZoomScale = 3.0;
    s.tag = index+1;
    [s setZoomScale:1.0];
    
    PDFView *itemView = [[PDFView alloc] initWithFrame:itemFrame atPage:index withPDFDoc:pdfDocument];
    itemView.backgroundColor = [UIColor whiteColor];
    
    itemView.userInteractionEnabled = YES;
    itemView.tag = index+1;
    [itemView addGestureRecognizer:doubleTap];
    [s addSubview:itemView];
    
    return s;
}



-(void) tapClick: (UITapGestureRecognizer *) gesture{
    
    NSArray * contents = [self getPDFContents:pdfDocument];
    if (contents && contents.count>0) {
        ContentsViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContentsViewController"];
        viewController.contents = contents;
        viewController.title = @"Contents";
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此书还没有编辑目录" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    }
    
}

-(void) skip:(NSInteger)num{
    [_prevPageView removeFromSuperview];
    [_currentPageView removeFromSuperview];
    [_nextPageView removeFromSuperview];
    _prevPageView = [self createItemView:num-1];
    
    _currentPageView = [self createItemView:num];
    
    _nextPageView = [self createItemView:num+1];
    
    _currentPageIndex = num-1;
    [_scrollView addSubview:_prevPageView];
    [_scrollView addSubview:_currentPageView];
    [_scrollView addSubview:_nextPageView];
    
    [self updatePageViews];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeCenter:(id)sender{
    
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
}


#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    UIView *view = gesture.view.superview;
    if ([view isKindOfClass:[UIScrollView class]]){
        UIScrollView *s = (UIScrollView *)view;
        [s zoomToRect:zoomRect animated:YES];
    }
}
#pragma mark - Utility methods

-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


#pragma mark Private


- (void)updatePageViews
{
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width,pageNum * _scrollView.frame.size.height);
    [_scrollView setContentOffset:CGPointMake( 0,_currentPageIndex * _scrollView.frame.size.height)];
    
    CGSize pageSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height);
    _currentPageView.frame = CGRectMake(0,_scrollView.contentOffset.y,
                                        pageSize.width, pageSize.height);

    _prevPageView.frame = CGRectMake(0, _currentPageView.frame.origin.y - pageSize.height,
                                     pageSize.width, pageSize.height);
    
    _nextPageView.frame = CGRectMake(0, _currentPageView.frame.origin.y + pageSize.height,
                                     pageSize.width, pageSize.height);
    _currentPageView.alpha = _prevPageView.alpha = _nextPageView.alpha = 1;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView != _scrollView) {
        return;
    }
    
    CGSize pageSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height);
    NSInteger page = floor((scrollView.contentOffset.y - pageSize.height / 2) / pageSize.height) + 1;
    _labelPage.text = [NSString stringWithFormat:@"%d/%ld",page+1,(long)pageNum];
    
    if (_currentPageIndex == page || page > pageNum-1 || page < 0)
    {
        return;
    }
    
    UIScrollView *tempPageView;
    if (_currentPageIndex + 1 == page)
    {
        
        [_prevPageView removeFromSuperview];
        tempPageView = _currentPageView;
        _currentPageView = _nextPageView;
        _prevPageView = tempPageView;
        _nextPageView = [self createItemView:page+2];
        [_scrollView addSubview:_nextPageView];
        
    }
    else
    {
        [_nextPageView removeFromSuperview];
        tempPageView = _currentPageView;
        _currentPageView = _prevPageView;
        
        _nextPageView = tempPageView;
        _prevPageView = [self createItemView:page];
        _prevPageView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:_prevPageView];
        
    }
    
    _currentPageIndex = page;
    _currentPageView.frame = CGRectMake(0,_currentPageIndex * pageSize.height,
                                        pageSize.width, pageSize.height);
    _prevPageView.frame = CGRectMake(0,_currentPageView.frame.origin.y - pageSize.height,
                                     pageSize.width, pageSize.height);
    _nextPageView.frame = CGRectMake(0,_currentPageView.frame.origin.y + pageSize.height,
                                     pageSize.width, pageSize.height);
    
    
    
}


#pragma mark 获取pdf文件目录
- (NSArray *)getPDFContents: (CGPDFDocumentRef) myDocument
{
    
    CGPDFDictionaryRef mycatalog= CGPDFDocumentGetCatalog(myDocument);
    CommentNode *rootNode = [[CommentNode alloc] initWithCatalog:mycatalog];
    CommentNode *rootOutlineNode = [rootNode childrenForName:@"/Outlines"];
    CommentNode *pagesNode = [rootNode childrenForName:@"/Pages"];
    NSArray *pagesArray = [self getPagesFromPagesNode:pagesNode];
    CommentNode *destsNode = [rootNode childrenForName:@"/Dests"];
    
    return [self getContentsForOutlineNode:rootOutlineNode pages:pagesArray destsNode:destsNode];
}

- (NSArray *)getContentsForOutlineNode:(CommentNode *)rootOutlineNode pages:(NSArray *)pagesArray destsNode:(CommentNode *)destsNode
{
    NSMutableArray *outlineArray = [[NSMutableArray alloc] init];
    CommentNode *firstOutlineNode = [rootOutlineNode childrenForName:@"/First"];
    CommentNode *outlineNode = firstOutlineNode;
    while (outlineNode) {
        NSString *title = [[outlineNode childrenForName:@"/Title"] value];
        CommentNode *destNode = [outlineNode childrenForName:@"/Dest"];
        NSMutableDictionary *outline = [NSMutableDictionary dictionaryWithDictionary:@{@"Title": title}];
        int index = 0;
        if (destNode) {
            if ([[destNode typeAsString] isEqualToString:@"Array"]) {
                CGPDFObjectRef dest = (__bridge CGPDFObjectRef)[[[destNode children] objectAtIndex:0] object];
                index = [self getIndexInPages:pagesArray forPage:dest];
            } else if ([[destNode typeAsString] isEqualToString:@"Name"]) {
                NSString *destName = [destNode value];
                CGPDFObjectRef dest = (__bridge CGPDFObjectRef)[[[[[destsNode childrenForName:destName] childrenForName:@"/D"] children] objectAtIndex:0] object];
                index = [self getIndexInPages:pagesArray forPage:dest];
            }
        } else {
            CommentNode *aNode = [outlineNode childrenForName:@"/A"];
            if (aNode) {
                CommentNode *dNode = [aNode childrenForName:@"/D"];
                if (dNode) {
                    CommentNode *d0Node = [[dNode children] objectAtIndex:0];
                    if ([[d0Node typeAsString] isEqualToString:@"Dictionary"]) {
                        CGPDFObjectRef dest = (CGPDFObjectRef)[d0Node object];
                        index = [self getIndexInPages:pagesArray forPage:dest];
                    }
                }
            }
        }
        [outline setObject:@(index) forKey:@"Index"];
        NSArray *subOutlines = [self getContentsForOutlineNode:outlineNode pages:pagesArray destsNode:destsNode];
        [outline setObject:subOutlines forKey:@"SubContents"];
        [outlineArray addObject:outline];
        outlineNode = [outlineNode childrenForName:@"/Next"];
    }
    return outlineArray;
}

- (NSArray *)getPagesFromPagesNode:(CommentNode *)pagesNode
{
    NSMutableArray *pages = [NSMutableArray new];
    CommentNode *kidsNode = [pagesNode childrenForName:@"/Kids"];
    for (CommentNode *node in [kidsNode children]) {
        NSString *type = [[node childrenForName:@"/Type"] value];
        if ([type isEqualToString:@"/Pages"]) {
            NSArray *kidsPages = [self getPagesFromPagesNode:node];
            [pages addObjectsFromArray:kidsPages];
        } else {
            [pages addObject:node];
        }
    }
    return pages;
}

- (int)getIndexInPages:(NSArray *)pages forPage:(CGPDFObjectRef)page
{
    for (int k = 0; k < pages.count; k++) {
        CommentNode *node = [pages objectAtIndex:k];
        if ([node object] == page)
            return k+1;
    }
    return 1;
}

@end
