//
//  ViewController.h
//  PuzzuuleClient
//
//  Created by 泰治 宮部 on 12/02/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIImagePickerControllerSourceType sourceType;
    UIImage* photoIimage;
    NSData* photoData;
}
- (IBAction)takePicture;
- (IBAction)selectSavedPhoto;
@end
