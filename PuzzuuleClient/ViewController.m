//
//  ViewController.m
//  PuzzuuleClient
//
//  Created by 泰治 宮部 on 12/02/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"

@implementation ViewController

- (void)uploadPhoto:(NSString*)path {
    // set url and generate request
    //NSURL *url = [NSURL URLWithString:@"http://localhost:3000/puzzuules"];
    NSURL *url = [NSURL URLWithString:@"http://ec2-176-34-34-137.ap-northeast-1.compute.amazonaws.com/puzzuule/photos"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    NSData *photoImage = [NSData dataWithContentsOfFile:path];
    
    // set http parameter and multipart data
    // [request setPostValue:@"dudada.png" forKey:@"puzzuule[name]"];
    // [request setData:photoImage forKey:@"puzzuule[image]"];
    [request setPostValue:@"test.png" forKey:@"photo[name]"];
    [request setData:photoImage forKey:@"content"];
    [request setPostValue:@"json" forKey:@"format"];
    //[request setFile:path forKey:@"puzzuule[image]"];
    
    // send request
    [request startSynchronous];
    
    // get reponse (json)
    // NSString *response = [request responseString];
    NSData *response = [request responseData];
    //NSLog(@"response=%@", response);
    
    // parse joson
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSDictionary *url_dict = [json_string JSONValue];
    NSString *dst_url = (NSString*)[url_dict objectForKey:@"p_url"];
    NSLog(@"dsr_url = %@", dst_url);
    
    /* sample codes (remove before release)
    NSArray *durls = [json_string JSONValue];
    for (NSDictionary *durl in durls)
    {
        //NSLog(@"%@", [durl objectForKey:@"name"]);
        //NSlog(@"@%", durl);
    }
    //[durls objectAtIndex:3];
    NSLog(@"%d", [durls count]);
    */
}

- (NSString*)postPhoto {
    //set url and generate request
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/puzzuules"];
    //NSURL *url = [NSURL URLWithString:@"http://ec2-176-34-34-137.ap-northeast-1.compute.amazonaws.com/puzzuule/photos"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    //NSData *photoImage = data;
    NSLog(@"data size = %d", [photoData length]);
    
    //set http parameter and multipart data
    [request setPostValue:@"dudada.png" forKey:@"puzzuule[name]"];
    [request setData:photoData forKey:@"puzzuule[image]"];
    //[request setPostValue:@"test.png" forKey:@"photo[name]"];
    //[request setData:photoImage forKey:@"content"];
    [request setPostValue:@"json" forKey:@"format"];
    
    // send request
    [request startSynchronous];
    
    // get reponse (json)
    // NSString *response = [request responseString];
    NSData *response = [request responseData];
    //NSLog(@"response=%@", response);
    
    // parse joson
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSDictionary *url_dict = [json_string JSONValue];
    NSString *dst_url = (NSString*)[url_dict objectForKey:@"p_url"];
    NSLog(@"dsr_url = %@", dst_url);
    
    return dst_url;
}

- (void)showImagePicker
{
    // generate image picker
    UIImagePickerController* imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker autorelease];
    imagePicker.allowsImageEditing = YES;
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    
    // show image picker
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)takePicture
{
    sourceType = UIImagePickerControllerSourceTypeCamera;
    [self showImagePicker];
}

- (IBAction)selectSavedPhoto
{
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self showImagePicker];
}

- (void)convertUIImage2NSData:(UIImage*)image
{
    CGFloat compressionQuality = 0.8;
    photoData = UIImageJPEGRepresentation(image, compressionQuality);
}

- (void)imagePickerController:(UIImagePickerController*)picker 
        didFinishPickingImage:(UIImage*)image 
                  editingInfo:(NSDictionary*)editingInfo
{
    // convert data from UIImage to NSData
    photoIimage = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
    [self convertUIImage2NSData:photoIimage];
    [self postPhoto];
    
    // show confirmation dialog
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"Confirm";
    alert.message = @"Register your photo to Puzzuule？";
    [alert addButtonWithTitle:@"ok"];
    [alert addButtonWithTitle:@"cancel"];
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self dismissModalViewControllerAnimated:YES];
    
    NSLog(@"data size = %d", [photoData length]);
    if (buttonIndex == 0) {
        
        //NSString * aaa = [self postPhoto];
        //[self postPhoto:photoData];
        //[self doPost:originalImage];
    } else {
        [self showImagePicker];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    // イメージピッカーを隠す
    [self dismissModalViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
