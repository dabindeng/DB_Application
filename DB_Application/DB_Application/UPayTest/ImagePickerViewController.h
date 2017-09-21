//
//  ImagePickerViewController.h
//  GameCenter
//
//  Created by apple on 16/8/10.
//
//

#import <UIKit/UIKit.h>

@interface ImagePickerViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSString* filePath;
}


+(void)takePhotoStatic;


+(void)localPhotoStatic;


@end