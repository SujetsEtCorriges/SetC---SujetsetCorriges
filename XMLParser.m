//
//  XMLParser.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 03/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

@synthesize sujcor = _sujcor;
@synthesize delegate = _delegate;

-(void) parseXMLFileAtPath:(NSString *)path
{
    self.sujcor = [[NSMutableArray alloc] init];
    //NSURL *xmlURL = [NSURL fileURLWithPath:path];
    NSURL *xmlURL = [NSURL URLWithString:path];
    
    _textParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    [_textParser setDelegate:self];
    
    [_textParser parse];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _currentElement = [elementName copy];
    
    if ([elementName isEqualToString:kItem])
    {
        _item = [[NSMutableDictionary alloc] init];
        
        _currentMatiere = [[NSMutableString alloc] init];
        _currentAnnee = [[NSMutableString alloc] init];
        _currentEpreuve = [[NSMutableString alloc] init];
        _currentSujet = [[NSMutableString alloc] init];
        _currentCorrige = [[NSMutableString alloc] init];
        _currentCorrigePartiel = [[NSMutableString alloc] init];
        
        
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_currentElement isEqualToString:kMatiere])
    {
        [_currentMatiere appendString:string];
    }
    else if ([_currentElement isEqualToString:kAnnee])
    {
        [_currentAnnee appendString:string];
    }
    else if ([_currentElement isEqualToString:kEpreuve])
    {
        [_currentEpreuve appendString:string];
    }
    else if ([_currentElement isEqualToString:kSujet])
    {
        [_currentSujet appendString:string];
    }
    else if ([_currentElement isEqualToString:kCorrige])
    {
        [_currentCorrige appendString:string];
    }
    else if ([_currentElement isEqualToString:kCorrigePartiel])
    {
        [_currentCorrigePartiel appendString:string];
    }


}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:kItem])
    {
        [_item setObject:_currentMatiere forKey:kMatiere];
        [_item setObject:_currentAnnee forKey:kAnnee];
        [_item setObject:_currentEpreuve forKey:kEpreuve];
        [_item setObject:_currentSujet forKey:kSujet];
        [_item setObject:_currentCorrige forKey:kCorrige];
        [_item setObject:_currentCorrigePartiel forKey:kCorrigePartiel];
        
        [self.sujcor addObject:_item];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [self.delegate xmlParser:self didFinishParsing:[NSArray arrayWithArray:self.sujcor]];
                   });
        
}

- (void) informDelegateOfError:(NSError*)error
{
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [self.delegate xmlParser:self didFailWithError:error];
                   });
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [self informDelegateOfError:parseError];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    [self informDelegateOfError:validationError];
}

@end
