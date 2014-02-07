//
//  ViewController.m
//  image
//
//  Created by Marcelo Sampaio on 2/7/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize image,outletCamera;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)captureImage:(UIBarButtonItem *)sender
{
    self.imagePicker=[[UIImagePickerController alloc]init];
    self.imagePicker.delegate=self;
    //    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.imagePicker animated:YES completion:nil];

}

//  ImagePicker selecionou uma imagem
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imagemEscolhida=info[UIImagePickerControllerOriginalImage];

    [self.image setImage:self.imagemEscolhida];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// ImagePicker cancelado

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
