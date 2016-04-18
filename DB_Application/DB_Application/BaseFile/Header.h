//
//  Header.h
//  Epweike_Witkey
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 zengxusheng. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//#define NSLog(...)

static const CGFloat kPublicLeftMenuWidth = 265.0f;

enum kPostStatus{
    kPostStatusNone=0,
    kPostStatusBeging=1,
    kPostStatusEnded=2,
    kPostStatusError=3,
    kPostStatusReceiving=4
};

#define kEPContactTel    @"400-6999-467"


//判断是否是iPhone X
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//设备屏幕大小
#define DeviceBoundsSize    [[UIScreen mainScreen] bounds].size                         // 包含状态栏
#define DeviceSize          [[UIScreen mainScreen] applicationFrame].size               // 不包含状态栏
#define StatusBarSize       [[UIApplication sharedApplication] statusBarFrame].size     // 状态栏
#define SelfNavSize         (CGSize){DeviceBoundsSize.width,44}                         // 当前导航栏
#define SelfToolBarSize     (CGSize){DeviceBoundsSize.width,49}                         // 当前工具栏
#define VisibleScreenFrame  (CGRect){0,0,DeviceBoundsSize.width,DeviceBoundsSize.height - SelfNavSize.height - StatusBarSize.height}    //不包含状态栏和导航栏
#define NavigationH ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0?64:44)  //导航栏高度

#define ScreenWith DeviceBoundsSize.width  //屏幕宽度
#define ScreenHeight DeviceBoundsSize.height  //屏幕高度
#define ScreenWithRatio DeviceBoundsSize.width/320  //屏幕宽度比例

// 弹窗提示
#define EPShowSuccess(msg) [SVProgressHUD showSuccessWithStatus:msg maskType:SVProgressHUDMaskTypeClear]
#define EPShowError(error) [SVProgressHUD showInfoWithStatus:error maskType:SVProgressHUDMaskTypeClear]
#define EPShowLoading(msg) [SVProgressHUD showWithStatus:msg maskType:SVProgressHUDMaskTypeClear]
#define EPShowDismiss [SVProgressHUD dismiss];

//字体
#define systemFont(size)    [UIFont systemFontOfSize:size]
#define boldSystemFont(size) [UIFont boldSystemFontOfSize:size]

//5和6图片转换比例
#define IMAGECONVERTRATIO   640.00/750.00

// 普通按钮高度
#define kDefaultButtonsHeight   44.0

// 普通输入框高度
#define kTextFiledHight 44.0

//个人中心头像CELL
#define kHeadCellHeight 190

// 普通CELL高度
#define kCustomCellHeight   44.0

//CELL正标题字体大小
#define kTextFont systemFont(14)

//CELL副标题字体大小
#define kDetailTextFont systemFont(11)

//加载更多最大数
#define kMaxLoadMore    10

// 透明
#define CLEARCOLOR  [UIColor clearColor]


//表视图背景
#define kTableViewBgColor  [UIColor colorWithHexString:@"f5f5f5"]
//筛选栏背景
#define kScreenViewBgColor  [UIColor colorWithHexString:@"f7f7f7"]
//正标题文字颜色
#define kTextLabelColor  [UIColor colorWithHexString:@"323232"]
//副标题文字颜色
#define kDetailTextLabelColor  [UIColor colorWithHexString:@"cacaca"]
//标题文字颜色(比正标题稍微淡一点)
#define kTitleTextLabelColor  [UIColor colorWithHexString:@"7f7f7f"]
//金额文字颜色(红色)
#define kMoneyTextLabelColor  [UIColor colorWithHexString:@"f74d4d"]
//金额文字颜色（绿色）
#define kMoneyTextLabelGreenColor  [UIColor colorWithHexString:@"00c262"]
//分割线颜色
#define kSeparateLineColor  [UIColor colorWithHexString:@"e6e6e6"]

//APP红色基色
#define kAppDefaultRedColor [UIColor colorWithHexString:@"f74e4c"]
//导航栏背景颜色
#define kNavBarTintColor  [UIColor colorWithHexString:@"f8f8f8"]
//导航栏按钮标题颜色
#define kNavBarButtonTitleColor [UIColor colorWithHexString:@"323232"]
//导航栏文字颜色
#define kNavBarTitleColor [UIColor colorWithHexString:@"323232"]
//导航栏按钮标题字体
#define kNavBarButtonTitleFont systemFont(16)
//导航栏标题字体
#define kNavBarTitleFont systemFont(18)

// RGBA获取颜色
#define COLOR(R,G,B,A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define colorWithRGB(r, g, b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0])

// 根据时间格式和时间返回字符串
#define TIMESTR(format) [format stringFromDate:[NSDate date]]

// 失败的语音对象缓存
#define FailedVoiceListPath  [LIBRARY_Directory stringByAppendingString:@"/.FailedVoiceListPath"]

// 搜索历史
#define SearchHistoryList  [LIBRARY_Directory stringByAppendingString:@"/.SearchHistory"]

// 广告栏 缓存
#define HomeAdsList  [LIBRARY_Directory stringByAppendingString:@"/.HomeAdsList"]

// 特色服务
#define HomeService  [LIBRARY_Directory stringByAppendingString:@"/.HomeService"]

// 人才推荐 缓存
#define HomeTalentRecommendList  [LIBRARY_Directory stringByAppendingString:@"/.HomeTalentRecommendList"]

//新手 指南
#define NewGuideList  [LIBRARY_Directory stringByAppendingString:@"/.NewGuideList"]

// 首页 最近访问
#define HomeRecent  [LIBRARY_Directory stringByAppendingString:@"/.HomeRecent"]

// 最近访问城市
#define HistoryCitys  [LIBRARY_Directory stringByAppendingString:@"/.HistoryCitys"]

// Caches路径
#define Caches_Directory   NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

// Document路径
#define Document_Directory   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

// Library路径
#define LIBRARY_Directory   NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]

// 缓存路径
#define CachesPath  [LIBRARY_Directory stringByAppendingString:@"/Caches/ImageCache/"]

// App数据路径
#define DATA_PATH   [LIBRARY_Directory stringByAppendingString:@"/AppData"]

// App图片数据路径
#define IMG_PATH   [DATA_PATH stringByAppendingString:@"/IMAGE/"]

// 某一张图片的路径
#define IMGPATH(imgName)    [IMG_PATH stringByAppendingString:imgName]

// 获取Image
#define GET_IMG(imgName)    [UIImage imageWithContentsOfFile:IMGPATH(imgName)]

// 删除Image
#define DEL_IMG(imgName)  [[NSFileManager defaultManager] removeItemAtPath:IMGPATH(imgName) error:nil]

// int转NSString
#define INT_STR(d)  [NSString stringWithFormat:@"%d",d]

#define PlaceholderImage   [UIImage imageNamed:@"morenbanner"]
#define PlaceholderHomeImage   [UIImage imageNamed:@"morenDefault"]
#define PlaceholderImageSquare   [UIImage imageNamed:@"PlaceholderImageSquare"]

// 连接字符串
#define APPENDSTR(a,b)  [a stringByAppendingString:b]

// NSIndexPath
#define IndexPath(row,section) [NSIndexPath indexPathForRow:row inSection:section]

#define IS_IOS6    [[UIDevice currentDevice].systemVersion floatValue] >= 6.0

#define IS_IOS7    [[UIDevice currentDevice].systemVersion floatValue] >= 7.0

#define IS_IOS8    [[UIDevice currentDevice].systemVersion floatValue] >= 8.0

#define IS_IOS9    [[UIDevice currentDevice].systemVersion floatValue] >= 9.0

#define RIGHT_ITEM_SIZE CGSizeMake(55,30)



#define Alert(Title, Message) [[[UIAlertView alloc] initWithTitle:Title message:Message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#define CATEGORY_DICT   [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CategoryList" ofType:@"plist"]]

#define EdgeInsets(top, left, bottom, right)    UIEdgeInsetsMake(top, left, bottom, right)



#define TabMsgNotification  @"TabNewMsgNotification"  //系统 站内信  私信  消息推送
#define RegisterSuccess    @"RegisterSuccess"
#define ReLoginNotification    @"ReLoginNotification"  //单点登录  重新登录通知
#define CollectNotification    @"CollectNotification"  //收藏通知
#define TalentCollectNotification    @"TalentCollectNotification"  //人才收藏通知
#define kEnterForegroundCountDownNotification  @"kEnterForegroundCountDownNotification"  //APP进入前台继续倒计时通知
#define kAppEnterBackgroundStopAudioPlay @"kAppEnterBackgroundStopAudioPlay"    //进入后台，语音播放停止

// 清空临时文件
#define CLEAN_TMP   NSFileManager *manager = [NSFileManager defaultManager];\
NSArray *files = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];\
for (NSString *f in files) {\
[manager removeItemAtPath:[NSTemporaryDirectory() stringByAppendingFormat:@"/%@",f] error:nil];\
}

// 头像修改通知
#define NotificationAvatarDidChange @"avatar_did_changed_notification_name"

// 登录成功通知
#define NotificationDidLogin        @"user_did_login_notification_name"

// 检查一个对象 是否是Null
#define CheckNull(obj)    ([obj isKindOfClass:[NSNull class]]? nil:obj)

// 字符串去除空格
#define DEL_SPACE(str)  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]


// 存放用户信息 账号、密码
#define UserInfoPath    [LIBRARY_Directory stringByAppendingString:@"/.UserInfo"]

//设备pToken
//#define Device_pToken    [LIBRARY_Directory stringByAppendingString:@"/.pToken"]

#define UserDefaults    [NSUserDefaults standardUserDefaults]

// 存放用户消息设置状态
#define UserPushMsgStatePath    [LIBRARY_Directory stringByAppendingString:@"/.PushMsg"]

// 用户信息 包括 用户名 等等~~
#define UserInfo        [UserDefaults objectForKey:kUserInfo]

// 用户搜索信息
#define UserSearchInfo        [UserDefaults objectForKey:SearchInfo]

// 存储招标任务金额区间
#define CashInfo        [UserDefaults objectForKey:kCashInfo]

// 判断是否是招标任务
#define CheckTender(modelid, taskType, cashCoverage) (modelid==4 && taskType<2 && cashCoverage>0)

#define AccessToken UserInfo[@"access_token"]

#define AliPayBack  @"AliPayBack"

//反馈问题的时候  添加系统版本号  设备  设备系统  雇主版本多传一个e字符
#define AppSourceInfo [NSString stringWithFormat:@"%@,%@,%@,%@,e",@"ios",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[SharePublicMethod getDeviceModelString],[[UIDevice currentDevice] systemVersion]]

// 头像尺寸
#define IconSize        CGSizeMake(100, 100)
#define AvatarPath      [LIBRARY_Directory stringByAppendingString:@"/avatar.png"]
//-----------------------------------------------------------------------------------------

#endif
