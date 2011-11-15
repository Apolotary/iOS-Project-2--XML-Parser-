//
//  ImageShell.h
//  XMLParser
//
//  Created by user on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// this is a small class which will be used as a shell
// which contains description, title and image etc at once
@interface ImageShell : NSObject 
{
    UIImage *     image;
    NSString *    title;
    NSString *    description;
    NSString *    sku;
    NSString *    retailPrice;
    NSString *    storePrice;
    NSString *    storeQuantity;
}

@property (nonatomic, retain) UIImage *     image;
@property (nonatomic, retain) NSString *    title;
@property (nonatomic, retain) NSString *    description;
@property (nonatomic, retain) NSString *    sku;
@property (nonatomic, retain) NSString *    retailPrice;
@property (nonatomic, retain) NSString *    storePrice;
@property (nonatomic, retain) NSString *    storeQuantity;

-(ImageShell *) initWithImg: (ImageShell *)img;

@end
