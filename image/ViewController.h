//
//  ViewController.h
//  image
//
//  Created by Marcelo Sampaio on 2/7/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletCamera;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *action;


// work properties
@property(strong,nonatomic) UIImage *imagemEscolhida;
@property(strong,nonatomic) UIImagePickerController *imagePicker;


@end
