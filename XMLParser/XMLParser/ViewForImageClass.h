//
//  ViewForImageClass.h
//  XMLParser
//
//  Created by user on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageShell.h"

@interface ViewForImageClass : UIView
{
    IBOutlet UILabel *     skuLabel;
    IBOutlet UILabel *     retailPrice;
    IBOutlet UILabel *     storePrice;
    IBOutlet UILabel *     storeQuantity;
    IBOutlet UILabel *     modelTitle;
    IBOutlet UIWebView *   description;
    IBOutlet UIImageView * image;
}

@property (nonatomic, retain) UILabel *     skuLabel;
@property (nonatomic, retain) UILabel *     retailPrice;
@property (nonatomic, retain) UILabel *     storePrice;
@property (nonatomic, retain) UILabel *     storeQuantity;
@property (nonatomic, retain) UILabel *     modelTitle;
@property (nonatomic, retain) UIWebView *   description;
@property (nonatomic, retain) UIImageView * image;

-(void)insertDataFromImageShell:(ImageShell *) theShell;

@end
