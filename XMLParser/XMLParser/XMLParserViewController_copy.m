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
            scrollView, currentPage, amountOfPages, firstView, lastView, prevPageCenter;

-(ParserModel *)parserModel
{
    if (!theParserModel)
    {
        theParserModel = [[ParserModel alloc] init];
    }
    return theParserModel;
}

- (void)dealloc
{
    //[subViewWithImageDescriptionAndEtc release];
    [super dealloc];
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint currentCenterOfPage = scrollView.contentOffset;
    int pageAfterDecelerating = currentCenterOfPage.x/self.view.frame.size.width;
    int difference = (currentCenterOfPage.x - prevPageCenter.x) / self.view.frame.size.width;
    if(difference < 0)
    {
        difference *= -1;
    }
    NSLog(@"difference: %d", difference);
    NSLog(@"dec page: %d", pageAfterDecelerating);
    NSLog(@"curr page: %d", currentPage);
    NSLog(@"lastview, firstview: %d %d", lastView, firstView);
    if(pageAfterDecelerating > amountOfPages || pageAfterDecelerating < 0)
    {
        return;
    }
    else if(pageAfterDecelerating != 0 && pageAfterDecelerating < amountOfPages - 1 && difference > 1)
    {
        if (currentPage != 0 || currentPage < amountOfPages)
        {
            if(currentPage < pageAfterDecelerating)
            {
                if(firstView == 1)
                {
                    [subViewWithImageDescriptionAndEtcFirst insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
                    [self.subViewWithImageDescriptionAndEtcFirst setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + (pageAfterDecelerating + 1)*self.view.center.x), self.view.frame.size.height*0.5)];
                    firstView = 2;
                    lastView = 1;
                }
                else if (firstView == 2)
                {
                    [subViewWithImageDescriptionAndEtcSecond insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
                    [self.subViewWithImageDescriptionAndEtcSecond setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + (pageAfterDecelerating + 1)*self.view.center.x), self.view.frame.size.height*0.5)];
                    firstView = 3;
                    lastView = 2;
                }
                else if (firstView == 3)
                {
                    [subViewWithImageDescriptionAndEtcThird insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating + 1)]];
                    [self.subViewWithImageDescriptionAndEtcThird setCenter:CGPointMake(((pageAfterDecelerating + 1)*self.view.frame.size.width + (pageAfterDecelerating + 1)*self.view.center.x), self.view.frame.size.height*0.5)];
                    firstView = 1;
                    lastView = 3;
                }
            }
            else if(currentPage > pageAfterDecelerating)
            {
                if(lastView == 1)
                {
                    [subViewWithImageDescriptionAndEtcFirst insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
                    [self.subViewWithImageDescriptionAndEtcFirst setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + (pageAfterDecelerating - 1)*self.view.center.x), self.view.frame.size.height*0.5)];
                    firstView = 1;
                    lastView = 3;
                }
                else if(lastView == 2)
                {
                    [subViewWithImageDescriptionAndEtcSecond insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
                    [self.subViewWithImageDescriptionAndEtcSecond setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + (pageAfterDecelerating - 1)*self.view.center.x), self.view.frame.size.height*0.5)];
                    firstView = 2;
                    lastView = 1;
                }
                else if(lastView == 3)
                {
                    [subViewWithImageDescriptionAndEtcThird insertDataFromImageShell:[self.parserModel.arrayOfImgs objectAtIndex:(pageAfterDecelerating - 1)]];
                    [self.subViewWithImageDescriptionAndEtcThird setCenter:CGPointMake(((pageAfterDecelerating - 1)*self.view.frame.size.width + (pageAfterDecelerating - 1)*self.view.center.x), self.view.frame.size.height*0.5)];
                    firstView = 3;
                    lastView = 2;
                }
                
            }
        }
    }
    currentPage = pageAfterDecelerating;
    NSLog(@"lastview, firstview after: %d %d", lastView, firstView);
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
    // THIS IS A VERY VERY BAD IDEA ^
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
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
    lastView = 3;
    prevPageCenter = CGPointMake(0, 1);
    
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
