//
//  HTComposeViewController.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTComposeViewController.h"

//Manager
#import "HTServiceManager.h"

//Models
#import "HTNote.h"

@interface HTComposeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *uploadPlaceholderButton;
@property (weak, nonatomic) IBOutlet UIButton *publishNoteButton;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

//@property (nonatomic, strong) UIImage *imageToAttachToNote;
@end

@implementation HTComposeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)uploadPlaceholderButtonPressed:(id)sender {
    //Open camera, get image and set it to placeholder.
    [self showImagePickingOptions];
}

- (void)showImagePickingOptions {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;

    UIAlertController *pickerOptionsActionSheet = [UIAlertController alertControllerWithTitle:@"Pick image from:" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];

    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];

    [pickerOptionsActionSheet addAction:camera];
    [pickerOptionsActionSheet addAction:gallery];
    [pickerOptionsActionSheet addAction:cancel];

    [self presentViewController:pickerOptionsActionSheet animated:YES completion:nil];
}

#pragma mark - IBAction methods
- (IBAction)publishNoteButtonPressed:(id)sender {
    HTNote *note = [HTNote new];
    if (self.uploadPlaceholderButton.currentBackgroundImage) {
       UIImage *image = self.uploadPlaceholderButton.currentBackgroundImage;
        // Convert to JPEG with 50% quality
        NSData* data = UIImageJPEGRepresentation(image, 0.5f);
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
        note.image = imageFile;
    }
    note.text = self.inputTextView.text;
    [HTServiceManager postMessage:note forBeacon:self.beacon withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


#pragma mark - UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *pickedImage = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.uploadPlaceholderButton setBackgroundImage:pickedImage forState:UIControlStateNormal];

    //TODO:Make clearing the text selected state based maybe?
    [self.uploadPlaceholderButton setTitle:@"" forState:UIControlStateNormal];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
