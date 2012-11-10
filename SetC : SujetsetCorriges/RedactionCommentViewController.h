//
//  RedactionCommentViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 20/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface RedactionCommentViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    
    UITextField *pseudoField_;
    UITextField *adresseMailField_;
    UITextView *commentaireField_;
    UIButton *boutonEnvoyer_;
    
    NSString *pseudoString_;
    NSString *adresseMailString_;
    NSString *commentaireString_;
    
    //UINavigationBar *navBar;
    //UINavigationItem *navItem;
    //UIBarButtonItem *boutonFinirCommentaire_;
    
    UIAlertView *alertWait_;
    UIAlertView *alertMessageSend_;
}

@property (strong, nonatomic) NSString *idArticle;

-(IBAction)boutonEnvoyerPushed:(id)sender;
-(IBAction)fermerFenetre:(id)sender;
-(IBAction)finirCommentaire:(id)sender;

@end
