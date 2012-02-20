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

- (IBAction)execUpload
{
    /**
     * path:
     * /Users/miyabetaiji/Library/Application Support/iPhone Simulator/5.0/Applications/F9E18381-D37D-4F7D-BA5E-706C8E2516BF/Documents/
     */
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), @"Boston_City_Flow.jpg"];
    [self uploadPhoto:path];
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
	// Do any additional setup after loading the view, typically from a nib.
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
