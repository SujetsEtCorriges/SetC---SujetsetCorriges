//
//  XMLParser.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 03/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kItem @"item"
#define kMatiere @"matiere"
#define kAnnee @"annee"
#define kEpreuve @"epreuve"
#define kSujet @"sujet"
#define kCorrige @"corrige"
#define kCorrigePartiel @"corrigePartiel"

@class XMLParser;

@protocol XMLParserDelegate <NSObject>

- (void) xmlParser:(XMLParser*)parser didFinishParsing:(NSArray*)array;
- (void) xmlParser:(XMLParser *)parser didFailWithError:(NSArray *)error;

@end


@interface XMLParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *_textParser;
    
    NSMutableDictionary *_item;
    
    NSString *_currentElement;
    NSMutableString *_currentMatiere;
    NSMutableString *_currentAnnee;
    NSMutableString *_currentEpreuve;
    NSMutableString *_currentSujet;
    NSMutableString *_currentCorrige;
    NSMutableString *_currentCorrigePartiel;
}


- (void)parseXMLFileAtPath:(NSString *)path;

@property (nonatomic, retain) NSMutableArray *sujcor;
@property (nonatomic, assign) id <XMLParserDelegate> delegate;

@end
