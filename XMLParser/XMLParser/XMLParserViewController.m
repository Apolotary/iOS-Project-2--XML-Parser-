//
//  XMLParserViewController.m
//  XMLParser
//
//  Created by user on 13.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParserViewController.h"

@implementation XMLParserViewController

@synthesize theParserModel, subViewWithImageDescriptionAndEtcFirst,
            subViewWithImageDescriptionAndEtcSecond, subViewWithImageDescriptionAndEtcThird,
            scrollView, currentPage, amountOfPages, firstView, lastView,
            firstViewIsPlacedAtThePageNumber, lastViewIsPlacedAtThePageNumber;

-(ParserModel *)parserModel
{
    if (!theParserModel)
    {
        theParserModel = [[ParserModel alloc] init];
    }
    return theParserModel;
}

-(void) loadPageForScrollViewAt: (int) pageAfterDecelerating
{
    NSLog(@"dec page: %d", pageAfterDecelerating);
    NSLog(@"curr page: %d", currentPage);
    NSLog(@"lastview, firstview: %d %d", lastView, firstView);
    NSLog(@"fvisplaced: %d", firstViewIsPlacedAtThePageNumber);
    NSLog(@"tvisplaced: %d", lastViewIsPlacedAtThePageNumber);
    if(pageAfterDecelerating > amountOfPages || pageAfterDecelerating < 0 || pageAfterDecelerating + 1 == amountOfPages || pageAfterDecelerating - 1 < 0)
    {
        return;
    }
    // swiping pages forward
    else if(pageAfterDecelerating == lastViewIsPlacedAtThePageNumber)
    {
        NSLog(@"hey, pageafger = lastview!");
        if(firstView == 1)
        {
            NSLog(@"firstView == 1");
            [subViewWithImageDescriptionAndEtcFirst insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
            [self.subViewWithImageDescriptionAndEtcFirst setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
            firstView = 2;
            lastView = 1;            
        }
        else if (firstView == 2)
        {
            NSLog(@"firstView == 2");
            [subViewWithImageDescriptionAndEtcSecond insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
            [self.subViewWithImageDescriptionAndEtcSecond setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
            firstView = 3;
            lastView = 2;
        }
        else if (firstView == 3)
        {
            NSLog(@"firstView == 3");
            [subViewWithImageDescriptionAndEtcThird insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
            [self.subViewWithImageDescriptionAndEtcThird setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
            firstView = 1;
            lastView = 3;
        }
        firstViewIsPlacedAtThePageNumber = pageAfterDecelerating - 1;
        lastViewIsPlacedAtThePageNumber = pageAfterDecelerating + 1;
    }
    // swiping pages backward
    else if(pageAfterDecelerating == firstViewIsPlacedAtThePageNumber)
    {
        NSLog(@"hey, pageafger = firstview!");
        if(lastView == 1)
        {
            NSLog(@"lastView == 1");
            [subViewWithImageDescriptionAndEtcFirst insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
            [self.subViewWithImageDescriptionAndEtcFirst setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
            firstView = 1;
            lastView = 3;
        }
        else if(lastView == 2)
        {
            NSLog(@"lastView == 2");
            [subViewWithImageDescriptionAndEtcSecond insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
            [self.subViewWithImageDescriptionAndEtcSecond setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
            firstView = 2;
            lastView = 1;
        }
        else if(lastView == 3)
        {
            NSLog(@"lastView == 3");
            [subViewWithImageDescriptionAndEtcThird insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
            [self.subViewWithImageDescriptionAndEtcThird setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
            firstView = 3;
            lastView = 2;
        }
        firstViewIsPlacedAtThePageNumber = pageAfterDecelerating - 1;
        lastViewIsPlacedAtThePageNumber = pageAfterDecelerating + 1;
    }
    NSLog(@"fvisplaced: %d", firstViewIsPlacedAtThePageNumber);
    NSLog(@"tvisplaced: %d", lastViewIsPlacedAtThePageNumber);
    NSLog(@"lastview, firstview after: %d %d", lastView, firstView);
}

-(void) reloadViewsInScrollView: (int) pageAfterDecelerating
{
    // in case if page swiping was too fast and user skipped more than 1 page as a result
    // then we just recreate this triplet on the page where deceleration stopped
    if (pageAfterDecelerating + 1 < amountOfPages && pageAfterDecelerating - 1 >= 0)
    {
        [subViewWithImageDescriptionAndEtcFirst insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
        [self.subViewWithImageDescriptionAndEtcFirst setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
        [subViewWithImageDescriptionAndEtcSecond insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:pageAfterDecelerating]];
        [self.subViewWithImageDescriptionAndEtcSecond setCenter:CGPointMake((pageAfterDecelerating*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
        [subViewWithImageDescriptionAndEtcThird insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
        [self.subViewWithImageDescriptionAndEtcThird setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
        
        firstView = 1;
        lastView = 3;
        firstViewIsPlacedAtThePageNumber = pageAfterDecelerating - 1;
        lastViewIsPlacedAtThePageNumber = pageAfterDecelerating + 1;
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint currentCenterOfPage = scrollView.contentOffset;
    int pageAfterDecelerating = currentCenterOfPage.x/self.view.frame.size.width;
    int difference = pageAfterDecelerating - currentPage;
    if (difference < 0)
    {
        difference *= -1;
    }
    
    if(difference > 1)
    {
        NSLog(@"oh noes, the scroll was too fast!");
        [self reloadViewsInScrollView:pageAfterDecelerating];        
    }
    else
    {
        [self loadPageForScrollViewAt:pageAfterDecelerating];
    }
    currentPage = pageAfterDecelerating;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.parserModel retrieveFromURL:URL_TEXT];
    
    NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"ViewForImage" owner:self options:nil];
    NSArray* arr2 = [[NSBundle mainBundle] loadNibNamed:@"ViewForImage" owner:self options:nil];
    NSArray* arr3 = [[NSBundle mainBundle] loadNibNamed:@"ViewForImage" owner:self options:nil];
    self.subViewWithImageDescriptionAndEtcFirst = [arr objectAtIndex:0];
    self.subViewWithImageDescriptionAndEtcSecond = [arr2 objectAtIndex:0];
    self.subViewWithImageDescriptionAndEtcThird = [arr3 objectAtIndex:0];
    // three views at once, it may be very inefficient and cause lags :(
    
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // wait until page is being parsed
    while(!self.parserModel.downloadingAndParsingWereFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    amountOfPages = [self.parserModel.arrayOfImgs count];
    scrollView.contentSize = CGSizeMake(amountOfPages*self.view.frame.size.width, 1); 
    
    NSLog(@"parsing ended and loop may end");
    NSLog(@"contentwidth: %f", scrollView.contentSize.width);
    NSLog(@"count: %d", amountOfPages);
    
    currentPage = 0;
    firstView = 1;
    firstViewIsPlacedAtThePageNumber = 0;
    lastView = 3;
    lastViewIsPlacedAtThePageNumber = 2;
    
    [subViewWithImageDescriptionAndEtcFirst insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:0]];
    [subViewWithImageDescriptionAndEtcSecond insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:1]];
    [subViewWithImageDescriptionAndEtcThird insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:2]];
    
    [scrollView addSubview:self.subViewWithImageDescriptionAndEtcFirst];
    // add it with center shift
    [self.subViewWithImageDescriptionAndEtcSecond setCenter:CGPointMake((self.view.frame.size.width+ self.view.center.x), self.view.frame.size.height*0.5)];
    [scrollView addSubview:self.subViewWithImageDescriptionAndEtcSecond];
    [self.subViewWithImageDescriptionAndEtcThird setCenter:CGPointMake((2*self.view.frame.size.width + self.view.center.x), self.view.frame.size.height*0.5)];
    [scrollView addSubview:self.subViewWithImageDescriptionAndEtcThird];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    scrollView = nil;
    subViewWithImageDescriptionAndEtcFirst = nil;
    subViewWithImageDescriptionAndEtcSecond = nil;
    subViewWithImageDescriptionAndEtcThird = nil;
}

- (void)dealloc
{
    [theParserModel release];
    [scrollView release];
    [subViewWithImageDescriptionAndEtcFirst release];
    [subViewWithImageDescriptionAndEtcSecond release];
    [subViewWithImageDescriptionAndEtcThird release];
    [super dealloc];
}

@end
