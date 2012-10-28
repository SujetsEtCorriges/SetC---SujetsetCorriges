//
//  XMLParser.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 03/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

@synthesize XMLData = _XMLData;
@synthesize delegate = _delegate;

-(void) parseXMLFileAtData:(NSString *)data
{
    self.XMLData = [[NSMutableArray alloc] init];
    
    typeParse = @"sujcor";
    
    NSData* list=[data dataUsingEncoding:NSUTF8StringEncoding];
    
    _textParser = [[NSXMLParser alloc] initWithData:list];
    
    [_textParser setShouldProcessNamespaces:NO];
	[_textParser setShouldReportNamespacePrefixes:NO];
	[_textParser setShouldResolveExternalEntities:NO];
    
    [_textParser setDelegate:self];
    
    [_textParser parse];
}

- (void) parseXMLFileAtURL:(NSString *)url
{
    self.XMLData = [[NSMutableArray alloc] init];
    
    typeParse = @"posts";
    
    NSURL *xmlURL = [NSURL URLWithString:url];
    
    _textParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    [_textParser setShouldProcessNamespaces:NO];
	[_textParser setShouldReportNamespacePrefixes:NO];
	[_textParser setShouldResolveExternalEntities:NO];
    
    [_textParser setDelegate:self];
    
    [_textParser parse];
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _currentElement = [elementName copy];
    
    if ([elementName isEqualToString:kItem])
    {
        if ([typeParse isEqualToString:@"sujcor"])
        {
            _item = [[NSMutableDictionary alloc] init];
            
            _currentMatiere = [[NSMutableString alloc] init];
            _currentAnnee = [[NSMutableString alloc] init];
            _currentEpreuve = [[NSMutableString alloc] init];
            _currentSujet = [[NSMutableString alloc] init];
            _currentCorrige = [[NSMutableString alloc] init];
            _currentCorrigePartiel = [[NSMutableString alloc] init];
            _currentNom = [[NSMutableString alloc] init];
        }
        else if ([typeParse isEqualToString:@"posts"])
        {
            _item = [[NSMutableDictionary alloc] init];
            
            _title = [[NSMutableString alloc] init];
            _date = [[NSMutableString alloc] init];
            _summary = [[NSMutableString alloc] init];
            _link = [[NSMutableString alloc] init];
            _message = [[NSMutableString alloc] init];
            _id = [[NSMutableString alloc] init];
        }
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([typeParse isEqualToString:@"sujcor"])
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
        else if ([_currentNom isEqualToString:kNom])
        {
            [_currentNom appendString:string];
        }
    }
    else if ([typeParse isEqualToString:@"posts"])
    {
        if ([_currentElement isEqualToString:@"title"])
        {
            [_title appendString:string];
            [_title setString: [self cleaningString:_title]];
        }
        else if ([_currentElement isEqualToString:@"pubDate"])
        {
            [_date appendString:string];
            [_date setString: [self cleaningString:_date]];
        }
        else if ([_currentElement isEqualToString:@"content:encoded"])
        {
            [_summary appendString:string];
            [_summary setString: [self cleaningString:_summary]];
        }
        else if ([_currentElement isEqualToString:@"link"])
        {
            [_link appendString:string];
            [_link setString: [self cleaningString:_link]];
        }
        else if ([_currentElement isEqualToString:@"description"])
        {
            [_message appendString:string];
            [_message setString: [self cleaningString:_message]];
        }
        else if ([_currentElement isEqualToString:@"guid"])
        {
            [_id appendString:string];
            [_id setString: [self cleaningString:_id]];
        }
    }
}


-(NSString *)cleaningString:(NSString *)dirtyString
{
    //On nettoie les chaînes
    NSString *cleanString = [dirtyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet nonBaseCharacterSet]];
    return cleanString;
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:kItem])
    {
        if ([typeParse isEqualToString:@"sujcor"])
        {
            [_item setObject:_currentMatiere forKey:kMatiere];
            [_item setObject:_currentAnnee forKey:kAnnee];
            [_item setObject:_currentEpreuve forKey:kEpreuve];
            [_item setObject:_currentSujet forKey:kSujet];
            [_item setObject:_currentCorrige forKey:kCorrige];
            [_item setObject:_currentCorrigePartiel forKey:kCorrigePartiel];
            [_item setObject:_currentNom forKey:kNom];
            
            [self.XMLData addObject:_item];
        }
        else if ([typeParse isEqualToString:@"posts"])
        {
            [_item setObject:_title forKey:@"title"];
            [_item setObject:_date forKey:@"date"];
            [_item setObject:_summary forKey:@"summary"];
            [_item setObject:_link forKey:@"link"];
            [_item setObject:_message forKey:@"message"];
            [_item setObject:[[_id componentsSeparatedByString:@"="] objectAtIndex:1] forKey:@"id"];
            
            [self.XMLData addObject:_item];
        }
       
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [self.delegate xmlParser:self didFinishParsing:[NSArray arrayWithArray:self.XMLData]];
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
