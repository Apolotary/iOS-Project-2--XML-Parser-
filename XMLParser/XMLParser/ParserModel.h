//
//  ParserModel.h
//  XMLParser
//
//  Created by user on 13.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageShell.h"
#define URL_TEXT @"http://www1.bodycandy.com/cgi-bin/iphone.pl?action=items&id=retainers&start=0&limit=11"

@interface ParserModel : NSObject <NSXMLParserDelegate>
{
    NSMutableData *     allDataRetrievedFromURL;
    NSURLConnection *   urlConnection;
    NSXMLParser *       addressParser;
    NSMutableArray *    arrayOfImgs;
    
    ImageShell *        imageWithTitleAndDescription;
    
    BOOL                anImageWasFound;
    BOOL                anImageTitleWasFound;
    BOOL                anImageDescriptionWasFound;
    BOOL                anImageSKUWasFound;
    BOOL                anImageRetailPriceWasFound;
    BOOL                anImageStorePriceWasFound;
    BOOL                anImageStoreQuantityWasFound;
    BOOL                downloadingAndParsingWereFinished;
}

@property (nonatomic, retain) NSMutableData *     allDataRetrievedFromURL;
@property (nonatomic, retain) NSURLConnection *   urlConnection;
@property (nonatomic, retain) NSXMLParser *       addressParser;

@property (nonatomic, retain) NSMutableArray *    arrayOfImgs;

@property BOOL                                    anImageWasFound;
@property BOOL                                    anImageTitleWasFound;
@property BOOL                                    anImageDescriptionWasFound;
@property BOOL                                    anImageSKUWasFound;
@property BOOL                                    anImageRetailPriceWasFound;
@property BOOL                                    anImageStorePriceWasFound;
@property BOOL                                    anImageStoreQuantityWasFound;
@property BOOL                                    downloadingAndParsingWereFinished;

-(void)retrieveFromURL:(NSString *) urlText;
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//ToDo: methods for xml parser
-(void)parseXMLFile;
-(void)parser:(NSXMLParser *)parser didStartElement:  (NSString *)elementName 
                                       namespaceURI:  (NSString *)namespaceURI 
                                       qualifiedName: (NSString *)qName 
                                       attributes:    (NSDictionary *)attributeDict;

-(void)parser:(NSXMLParser *)parser foundCharacters:  (NSString *)string;

-(void)parser:(NSXMLParser *)parser didEndElement:    (NSString *)elementName 
                                    namespaceURI:     (NSString *)namespaceURI 
                                    qualifiedName:    (NSString *)qName;
@end
