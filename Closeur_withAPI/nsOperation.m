//
//  nsOperation.m
//  Closeur_withAPI
//
//  Created by Trúc Phương >_< on 02/03/2018.
//  Copyright © 2018 iDev Bao. All rights reserved.
//

#import "nsOperation.h"


static NSString *Name = @"im:name";
static NSString *imageLink = @"im:image";
static NSString *elementNameAPI = @"entry";


@implementation nsOperation{
    NSXMLParser *parser;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self != nil)
    {
        _DatatoParse = data;
        _elementsToParse = @[Name, imageLink];
    }
    return self;
}
-(void)main{
    parser = [[NSXMLParser alloc] initWithData:_DatatoParse];
    parser.delegate = self;
    
    _workingArray = [NSMutableArray array];
    _workingPropertyString = [NSMutableString string];
    
    [parser parse];
    
    if (![self isCancelled])
    {
        // Set appRecordList to the result of our parsing
        _recordDataList = [NSArray arrayWithArray:_workingArray];
    }
    
    _workingArray = nil;
    _workingPropertyString = nil;
    _DatatoParse = nil;

    
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName
    attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
//    entry: { id (link), im:name (app name), im:image (link) }
//    elementName:
//    A string that is the name of an element (in its start tag).<entry>
//    boc tung <> tu tren xuong
    if ([elementName isEqualToString:elementNameAPI]) {
        _workingEntry = [recordData new];
        // entry dc khoi tao  ->if (_workingEntry != nil) {if (_storingCharacterData)
        
    }
    _storingCharacterData = [_elementsToParse containsObject:elementName]; // luu tru entry
    // check object in array
//   feed -> no
// kiem tra xem no co trong mang ko 2 item can lay         _elementsToParse = @[Name, imageLink];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName{
    
    if (_workingEntry != nil)// dc new
    {
        if (_storingCharacterData) // no else if ([elementName isEqualToString:elementNameAPI])
            // yes thi save vao obj _workingEntry luu lai appName sau do duyet tiep de luu lai imgURL xong de do duyet den het </entry> -> gap <entry> quay laij tao
        {
            NSString *trimmedString =
            [_workingPropertyString stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            [_workingPropertyString setString:@""];
            // clear the string for next time
            if ([elementName isEqualToString:Name])
            {
                _workingEntry.appName = trimmedString;
            }
            else if ([elementName isEqualToString:imageLink])
            {
                _workingEntry.imageURL = trimmedString;
            }
        }
        else if ([elementName isEqualToString:elementNameAPI])
        {
            [_workingArray addObject:_workingEntry];
            self.workingEntry = nil;
        }
    }

    

}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_storingCharacterData)
    {
        [_workingPropertyString appendString:string];
    }
}
@end
