//
//  ParserModel.m
//  XMLParser
//
//  Created by user on 13.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParserModel.h"


@implementation ParserModel 

@synthesize urlConnection, allDataRetrievedFromURL, addressParser, 
            arrayOfImgs, anImageWasFound, anImageTitleWasFound, 
            anImageDescriptionWasFound, anImageSKUWasFound,
            anImageRetailPriceWasFound, anImageStorePriceWasFound,
            anImageStoreQuantityWasFound, downloadingAndParsingWereFinished;

-(id)init
{
    if ((self = [super init]))
    {
        allDataRetrievedFromURL = [[NSMutableData alloc] init]; 
        imageWithTitleAndDescription = [[ImageShell alloc] init];
        arrayOfImgs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)retrieveFromURL:(NSString *) urlText
{
    NSLog(@"begin retrieving");
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]];
    urlConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

// this method will be requested multipple times, and it will add data to NSMutableData every time
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"chunk retrieved!");
    //NSLog(@"data: %@", data);
    [allDataRetrievedFromURL appendData:data];
}

-(void)parseXMLFile 
{
    NSLog(@"parsing started");
    BOOL success;
    if (addressParser) // addressParser is an NSXMLParser instance variable
        [addressParser release];
    addressParser = [[NSXMLParser alloc] initWithData:allDataRetrievedFromURL];
    [addressParser setDelegate:self];
    [addressParser setShouldResolveExternalEntities:YES];
    success = [addressParser parse]; // return value not used
    if (success)
    {
        NSLog(@"parsing ended");
        downloadingAndParsingWereFinished = YES;
        for (int i = 0; i < [arrayOfImgs count]; ++i)
        {
            NSLog(@"title: %@", [[arrayOfImgs objectAtIndex:i] title]);
        }
    }
    // if not successful, delegate is informed of error
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Loading finished!");
    //NSLog(@"here's the data %@", allDataRetrievedFromURL);
    [self   parseXMLFile];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                    namespaceURI:   (NSString *)namespaceURI
                                    qualifiedName:  (NSString *)qName 
                                    attributes:     (NSDictionary *)attributeDict 
{
    NSLog(@"found element");
    
    if  ([elementName isEqualToString:@"image_thumb"])
    {
        anImageWasFound = YES;
    }
    
    if ([elementName isEqualToString:@"model"])
    {
        anImageTitleWasFound = YES;
    }
    
    if([elementName isEqualToString:@"description"])
    {
        anImageDescriptionWasFound = YES;
    }
    
    if  ([elementName isEqualToString:@"sku"])
    {
        anImageSKUWasFound = YES;
    }
    
    if  ([elementName isEqualToString:@"retail"])
    {
        anImageRetailPriceWasFound = YES;
    }
    
    if  ([elementName isEqualToString:@"store_price"])
    {
        anImageStorePriceWasFound = YES;
    }
    
    if  ([elementName isEqualToString:@"store_quantity"])
    {
        anImageStoreQuantityWasFound = YES;
    }
        
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"found chars");
    if (anImageWasFound)
    {
        NSLog(@"hey, i've found an image and its: %@", string);
        //download img by url, add to image array
        NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:string]];
        imageWithTitleAndDescription.image = [UIImage imageWithData:imageData];
        [imageData release];
    }
    
    if (anImageTitleWasFound)
    {
        NSLog(@"hey, i've found a title and its: %@", string);
        imageWithTitleAndDescription.title = string;
    }
    
    if (anImageDescriptionWasFound)
    {
        //NSLog(@"hey, i've found a description and its: %@", string);
        imageWithTitleAndDescription.description = string;
    }
    
    if (anImageSKUWasFound)
    {
        NSLog(@"sku = %@", string);
        imageWithTitleAndDescription.sku = string;
    }
    
    if (anImageRetailPriceWasFound)
    {
        imageWithTitleAndDescription.retailPrice = string;
    }
    
    if (anImageStorePriceWasFound)
    {
        imageWithTitleAndDescription.storePrice = string;
    }
    
    if (anImageStoreQuantityWasFound)
    {
        imageWithTitleAndDescription.storeQuantity = string;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                    namespaceURI: (NSString *)namespaceURI 
                                    qualifiedName:(NSString *)qName
{
    NSLog(@"found end of element");
    if ([elementName isEqualToString:@"item"])
    {
        NSLog(@"found end of item");
        NSLog(@"title: %@", imageWithTitleAndDescription.title);
        ImageShell * temp = [[ImageShell alloc] initWithImg:imageWithTitleAndDescription];
        [arrayOfImgs addObject:temp];
        [temp release];
        
    }
    
    if ([elementName isEqualToString:@"image_thumb"])
    {
        NSLog(@"found end of image");
        anImageWasFound = NO;
    }
    
    if ([elementName isEqualToString:@"model"])
    {
        anImageTitleWasFound = NO;
    }
    
    if([elementName isEqualToString:@"description"])
    {
        anImageDescriptionWasFound = NO;
    }
    
    if  ([elementName isEqualToString:@"sku"])
    {
        anImageSKUWasFound = NO;
    }
    
    if  ([elementName isEqualToString:@"retail"])
    {
        anImageRetailPriceWasFound = NO;
    }
    
    if  ([elementName isEqualToString:@"store_price"])
    {
        NSLog(@"found end of price");
        anImageStorePriceWasFound = NO;
    }
    
    if  ([elementName isEqualToString:@"store_quantity"])
    {
        anImageStoreQuantityWasFound = NO;
    }
}

-(void) dealloc
{
    [allDataRetrievedFromURL release];
    [urlConnection release];
    [addressParser release];
    [arrayOfImgs release];
    
    [imageWithTitleAndDescription release];
    
    [super dealloc];
}

@end
