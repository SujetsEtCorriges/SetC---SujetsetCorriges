//
//  DetailEpreuveViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 18/11/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailEpreuveViewController : UIViewController
{
    UILabel *labelConcours;
    UILabel *labelFiliere;
    UILabel *labelAnnee;
    UILabel *labelEpreuve;
    
    UIButton *boutonSujet;
    UIButton *boutonCorrige;
}

@property (strong, nonatomic) NSString *lienSujet;
@property (strong, nonatomic) NSString *lienCorrige;
@property (nonatomic, assign) int corrigePartiel;
@property (strong, nonatomic) NSString *concours;
@property (strong, nonatomic) NSString *annee;
@property (strong, nonatomic) NSString *filiere;
@property (strong, nonatomic) NSString *epreuve;

@end
