//
//  RedactionCommentViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 20/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RedactionCommentViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    
    UITextField *pseudoField;
    UITextField *adresseMailField;
    UITextView *commentaireField;
    UIButton *boutonEnvoyer;
    
    NSString *pseudoString;
    NSString *adresseMailString;
    NSString *commentaireString;
    NSString *idArticle;
    
    //UINavigationBar *navBar;
    //UINavigationItem *navItem;
    UIBarButtonItem *boutonFinirCommentaire;
    
    UIAlertView *alertWait;
    UIAlertView *alertMessageSend;
}

@property (retain, nonatomic) NSString *idArticle;

-(IBAction)boutonEnvoyerPushed:(id)sender;
-(IBAction)fermerFenetre:(id)sender;
-(IBAction)finirCommentaire:(id)sender;

@end
