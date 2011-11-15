//
//  ViewForImageClass.m
//  XMLParser
//
//  Created by user on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewForImageClass.h"


@implementation ViewForImageClass

@synthesize skuLabel, retailPrice, storePrice, storeQuantity,
            modelTitle, description, image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)insertDataFromImageShell:(ImageShell *) theShell
{
    skuLabel.text = theShell.sku;
    retailPrice.text = theShell.retailPrice;
    storePrice.text = theShell.storePrice;
    storeQuantity.text = theShell.storeQuantity;
    modelTitle.text = theShell.title;
    [description loadHTMLString:theShell.description baseURL:nil];
    image.image = theShell.image;
}

- (void)dealloc
{
    [super dealloc];
}

@end
