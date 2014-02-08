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

@synthesize image,outletCamera,action;




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (IBAction)captureImage:(UIBarButtonItem *)sender
{
    self.imagePicker=[[UIImagePickerController alloc]init];
    self.imagePicker.delegate=self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.imagePicker animated:YES completion:nil];

}

//- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error{
//    NSLog(@"inside directory");
//    return [[NSArray alloc]init];
//}

- (IBAction)action:(UIBarButtonItem *)sender
{
    NSLog(@"get photo from documents folder");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    
    NSLog(@"documentsPath=%@",documentsPath);
    
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSArray *array=[fileManager contentsOfDirectoryAtPath:documentsPath error:nil];
    NSLog(@"total de arquivos em File Manager=%d",[array count]);
    
    for (int i=0; i<[array count]; i++) {
        NSLog(@"...... conteudo: %@",[array objectAtIndex:i]);
    }
    
    
    
    
    
    BOOL fileExists = [[NSFileManager defaultManager]fileExistsAtPath:filePath];
    if (fileExists) {
        NSLog(@"file EXISTS");
    }else{
        NSLog(@"file DOES NO+T EXIST");
    }
    
    self.image.image = [UIImage imageWithData:pngData];
    
    // All photos have been taken in UP orientation, so they must be rotated to be seen
    if (self.image.image.imageOrientation==UIImageOrientationUp) {
        UIImage *rotatedImage;
        rotatedImage = [[UIImage alloc] initWithCGImage: self.image.image.CGImage
                                                  scale: 1.0
                                            orientation: UIImageOrientationRight];

        self.image.image=rotatedImage;
    }

}

//  ImagePicker selecionou uma imagem
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imagemEscolhida=info[UIImagePickerControllerOriginalImage];

    [self.image setImage:self.imagemEscolhida];
    [self dismissViewControllerAnimated:YES completion:nil];

    
    // store image in documents folder
    [self storeImageInDocumentsLibrary];
    
    
}

// ImagePicker cancelado

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel action");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)storeImageInDocumentsLibrary
{
    NSLog(@"store in document folder");
    NSData *pngData = UIImagePNGRepresentation(self.image.image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    NSLog(@"pathName=%@",filePath);
    [pngData writeToFile:filePath atomically:YES]; //Write the file

    
    
}

// Store image inside photo library
-(void)storeImageInPhotoLibrary
{
    // Request to save the image to camera roll
    UIImageWriteToSavedPhotosAlbum(self.image.image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        NSLog(@"Error saving the image");
        
    }
    else  // No errors
    {
        NSLog(@"image has been succesfuly stored");
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
