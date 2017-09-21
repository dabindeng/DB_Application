//
//  RootViewController.m
//  UPayTestDemo
//
//  Created by epwk on 16/8/8.
//  Copyright © 2016年 Epwk. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"
#import "AFNetApiClient.h"
#import "SVProgressHUD.h"
#import "ImagePickerViewController.h"
#import "WKWebViewTestViewController.h"

@interface RootViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    
//    WebViewController *ctr = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
//    ctr.fileUrl = @"weixin://wxpay/bizpayurl?pr=CDLDnJz";
//    [self.navigationController pushViewController:ctr animated:YES];
    
    WKWebViewTestViewController *ctr = [[WKWebViewTestViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
    
    
}
- (IBAction)chargeAction:(id)sender {
    //&user_id=1512&amount=21&topup_type=1&fee_payer=1
//    [self requestChargeWithParams:@{@"amount":@"21",@"user_id":@"1512",@"topup_type":@"1",@"fee_payer":@"1"}];
//    [self localPhoto];
    
    WebViewController *ctr = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    ctr.fileUrl = @"http://www.youqiwu.com/youhuistorm.html?epi=123&utm_source=baidu&utm_medium=banner&utm_campaign=&utm_content=&utm_term=%E4%B8%BB%E7%AB%99%E5%9B%BE%E5%8C%85%E5%B9%BF%E5%91%8A";
    [self.navigationController pushViewController:ctr animated:YES];

}
- (IBAction)authAction:(id)sender {
    [self requestTaskListWithParams:nil];
}
- (IBAction)payAction:(id)sender {
    //amount=21&payee_user_id=1512&transfer_pay_type=1&topup_type=1&getUrl=1
    [self requestPayWithParams:@{@"amount":@"21",@"payee_user_id":@"1512",@"transfer_pay_type":@"0",@"topup_type":@"4"}];
}


- (IBAction)takeMoneyAction:(id)sender {
    //user_id=1512&amount=65&getUrl=1
    [self requestTakeMoneyWithParams:@{@"amount":@"65",@"user_id":@"1512",@"getUrl":@"1"}];
}

- (IBAction)authorizationAction:(id)sender {
    //user_id=1512&getUrl=1
    [self requestAuthorizationWithParams:@{@"user_id":@"1512",@"getUrl":@"1"}];
}

#pragma mark RequestDataAction  数据请求

-(void)requestTaskListWithParams:(NSDictionary *)params
{
    [SVProgressHUD show];
    [[AFNetApiClient ShareClient] requestAuthWithParams:params success:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [ctr addAction:cancelAction];
        [ctr addAction:okAction];
        [self presentViewController:ctr animated:YES completion:nil];
        
        
    } failure:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [ctr addAction:cancelAction];
        [ctr addAction:okAction];
        [self presentViewController:ctr animated:YES completion:nil];
        
    }];
    
}

#pragma mark RequestDataAction  数据请求

-(void)requestChargeWithParams:(NSDictionary *)params
{
    [SVProgressHUD show];
    [[AFNetApiClient ShareClient] requestChargeWithParams:params success:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        
        WebViewController *ctr = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        ctr.fileUrl = dataDict[@"url"];
        [self.navigationController pushViewController:ctr animated:YES];
        
        
        
    } failure:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [ctr addAction:cancelAction];
        [ctr addAction:okAction];
        [self presentViewController:ctr animated:YES completion:nil];
        
    }];
    
}

#pragma mark RequestDataAction  数据请求
-(void)requestPayWithParams:(NSDictionary *)params
{
    [SVProgressHUD show];
    [[AFNetApiClient ShareClient] requestPayWithParams:params success:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        
        WebViewController *ctr = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        ctr.fileUrl = dataDict[@"url"];
        [self.navigationController pushViewController:ctr animated:YES];
        
        
        
    } failure:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [ctr addAction:cancelAction];
        [ctr addAction:okAction];
        [self presentViewController:ctr animated:YES completion:nil];
        
    }];
    
}

#pragma mark RequestDataAction  数据请求
-(void)requestTakeMoneyWithParams:(NSDictionary *)params
{
    [SVProgressHUD show];
    [[AFNetApiClient ShareClient] requestTakeMoneyWithParams:params success:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        
        WebViewController *ctr = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        ctr.fileUrl = dataDict[@"url"];
        [self.navigationController pushViewController:ctr animated:YES];
        
        
        
    } failure:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [ctr addAction:cancelAction];
        [ctr addAction:okAction];
        [self presentViewController:ctr animated:YES completion:nil];
        
    }];
    
}

#pragma mark RequestDataAction  数据请求
-(void)requestAuthorizationWithParams:(NSDictionary *)params
{
    [SVProgressHUD show];
    [[AFNetApiClient ShareClient] requestAuthorizationWithParams:params success:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        
        WebViewController *ctr = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        ctr.fileUrl = dataDict[@"url"];
        [self.navigationController pushViewController:ctr animated:YES];
        
        
        
    } failure:^(id dataDict, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [ctr addAction:cancelAction];
        [ctr addAction:okAction];
        [self presentViewController:ctr animated:YES completion:nil];
        
    }];
    
}

-(void)localPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate      = self;
    picker.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    //[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:^(void){
        NSLog(@"Imageviewcontroller is presented");
    }];
    
    NSLog(@"-(void)localPhoto();");
}

- (void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图像可编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        NSLog(@"模拟器中无法打开照相机，请在真机中调试");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        //        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //生成唯一字符串
        NSString* uuid = [[NSUUID UUID] UUIDString];
        
        //文件名
        NSString* fileName = [NSString stringWithFormat:@"/%@.png", uuid];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为XXXXXXXX-XXXX-XXXX....XXXX.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:fileName] contents:data attributes:nil];
        
        
        //得到选择后沙盒中图片的完整路径
        NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@", DocumentsPath, fileName];
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
//        std::string strFilePath = [filePath UTF8String];
//        cocos2d::Director::getInstance()->getEventDispatcher()->dispatchCustomEvent("ImagePickerEvent", &strFilePath);
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [picker dismissModalViewControllerAnimated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
