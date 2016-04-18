//
//  ViewController.m
//  DB_Application
//
//  Created by epwk on 16/3/3.
//  Copyright © 2016年 DBAPP. All rights reserved.
//

#import "ViewController.h"
#import "AFNetApiClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(3, globalQ, ^(size_t index) {//执行某个代码片段  3次
        
    });
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //耗时 操作
       dispatch_async(dispatch_get_main_queue(), ^{
          //更新UI
       });
    });
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       //监听 以上 三组 任务  完成后  回主线程  更新UI
    });
    
    
    
    
    dispatch_queue_t queue1 = dispatch_queue_create("**test.my.ok", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(queue1, ^{
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_barrier_async(queue1, ^{//dispatch_barrier_async在前面的任务执行结束后才执行   而且它后面的任务等它执行完后  才会执行
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_async(queue1, ^{
        [NSThread sleepForTimeInterval:1];
    });
    
    
    
    NSString *pathStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    
    NSMutableArray *ary = [[NSMutableArray alloc] initWithArray:@[@"3",@"4",@"1",@"5",@"7",@"8",@"6",@"2"]];
    for (int i = 0; i < ary.count; i++) {
        for (int j = i; j<ary.count; j++) {
            if ([ary[i] intValue] > [ary[j] intValue]) {
                [ary exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *file = [[NSFileManager alloc] init];
    if (![file fileExistsAtPath:[NSString stringWithFormat:@"%@/userData",path]]) {
        [file createDirectoryAtPath:path withIntermediateDirectories:false attributes:nil error:nil];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:0] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:10] forKey:@"pagesize"];
//    if (_talent_id) {
//        [params setObject:_talent_id forKey:@"shop_type"];
//    }
//    if (_integrity_id) {
//        [params setObject:_integrity_id forKey:@"integrity_ids"];
//    }
//    if (_indus_id) {
//        [params setObject:_indus_id forKey:@"indus_id"];
//    }
//    if (_order) {
//        [params setObject:_order forKey:@"order"];
//    }
    
    [self requestTaskListWithParams:params];

}

#pragma mark RequestDataAction  数据请求

-(void)requestTaskListWithParams:(NSDictionary *)params
{
    [[AFNetApiClient ShareClient] requestTaskListWithParams:params success:^(id dataDict, int status, NSString *msg) {
//        if (_isFromHomeView) {
//            _secCategoryView.hidden = NO;
//            _categoryBtn.superview.hidden = YES;
//        }else
//            _categoryBtn.superview.hidden = NO;
//        
//        NSArray *ary = dataDict;
//        if (_offset == 0) {
//            [_dataArray removeAllObjects];
//            [_dataArray addObjectsFromArray:ary];
//            
//            if (_dataArray.count == 0) {
//                [_loadCustomView showWithNoData];
//            }else
//            {
//                [_loadCustomView dismiss];
//            }
//            
//        }else
//        {
//            [_dataArray addObjectsFromArray:ary];
//        }
//        [_tableView reloadData];
//        
//        if (ary.count < kMaxLoadMore) {
//            //没有更多数据  隐藏加载更多的功能
//            self.tableView.footer.hidden = YES;
//        }else
//        {
//            self.tableView.footer.hidden = NO;
//        }
//        
//        
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
        
        
        
    } failure:^(id dataDict, int status, NSString *msg) {
//        if ([msg rangeOfString:@"-10086"].location != NSNotFound) {
//            
//            [SVProgressHUD dismiss];
//            [_loadCustomView dismiss];
//            return ;
//        }
//        _categoryBtn.superview.hidden = NO;
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
//        if (_offset > 0) {
//            _offset-=kMaxLoadMore;
//        }
//        if ([msg isEqualToString:@"RequestError"])
//            [_loadCustomView showWithError];
//        else
//        {
//            [_loadCustomView dismiss];
//            [SVProgressHUD showInfoWithStatus:msg maskType:SVProgressHUDMaskTypeBlack];
//        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
