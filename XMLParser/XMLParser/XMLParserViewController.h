//
//  XMLParserViewController.h
//  XMLParser
//
//  Created by user on 13.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserModel.h"
#import "ViewForImageClass.h"

@interface XMLParserViewController : UIViewController <UIScrollViewDelegate>
{
    ParserModel *       theParserModel;
    UIScrollView *      scrollView;
    ViewForImageClass * subViewWithImageDescriptionAndEtcFirst;
    ViewForImageClass * subViewWithImageDescriptionAndEtcSecond;
    ViewForImageClass * subViewWithImageDescriptionAndEtcThird;
    int                 currentPage;
    int                 amountOfPages;
    int                 firstView;
    int                 firstViewIsPlacedAtThePageNumber;
    int                 lastViewIsPlacedAtThePageNumber;
    int                 lastView;
}

@property (nonatomic, retain) ViewForImageClass * subViewWithImageDescriptionAndEtcFirst;
@property (nonatomic, retain) ViewForImageClass * subViewWithImageDescriptionAndEtcSecond;
@property (nonatomic, retain) ViewForImageClass * subViewWithImageDescriptionAndEtcThird;
@property (nonatomic, retain) ParserModel *       theParserModel;
@property (nonatomic, retain) UIScrollView *      scrollView;

@property int currentPage;
@property int amountOfPages;
@property int firstView;
@property int lastView;
@property int firstViewIsPlacedAtThePageNumber;
@property int lastViewIsPlacedAtThePageNumber;

@end
