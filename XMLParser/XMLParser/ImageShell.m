//
//  ImageShell.m
//  XMLParser
//
//  Created by user on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageShell.h"


@implementation ImageShell

@synthesize image, title, description, sku, retailPrice, storePrice, storeQuantity;

-(id) init
{
    if ((self = [super init]))
    {
        image = [[UIImageView alloc] init];
        title = [[NSString alloc] init];
        description = [[NSString alloc] init];
        sku = [[NSString alloc] init];
        retailPrice = [[NSString alloc] init];
        storePrice = [[NSString alloc] init];
        storeQuantity = [[NSString alloc] init];
    }
    
    return self;
}

-(ImageShell *) initWithImg: (ImageShell *)img
{
    image = [img.image copy];
    title = [img.title copy];
    description = [img.description copy];
    sku = [img.sku copy];
    retailPrice = [img.retailPrice copy];
    storePrice = [img.storePrice copy];
    storeQuantity = [img.storeQuantity copy];
    return self;
}

-(void) dealloc
{
    [image release];
    [title release];
    [description release];
    [sku release];
    [retailPrice release];
    [storePrice release];
    [storeQuantity release];
    
    [super dealloc];
}

@end
