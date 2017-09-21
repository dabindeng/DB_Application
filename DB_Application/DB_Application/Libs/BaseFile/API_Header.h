//
//  API_Header.h
//  DB_Application
//
//  Created by epwk on 16/4/18.
//  Copyright © 2016年 DBAPP. All rights reserved.
//

#ifndef API_Header_h
#define API_Header_h

/*
 *  API接口
 */

#warning mark server url 域名地址

//#define kAPIBASEURL  ((AppDelegate *)[UIApplication sharedApplication].delegate).apiUrl
//#define EncodeKey   ((AppDelegate *)[UIApplication sharedApplication].delegate).codeKey

#define kAPIBASEURL @"http://app2.api.epweike.net"

//extern NSString *ApiUrl;
//extern NSString *codeKey;

//人才大厅
#define kAPITalentList    @"/m.php?do=talent&view=list"

#define kAPIRegister   @"/m.php?do=merchatpay&view=register&getUrl=1&uid=1519430&mobile=18888888688"

#define kAPIAuth  @"/m.php?do=merchatpay&view=authen_name&user_id=1512&real_name=XXX&card_no=XXX&bank_card=6222023410001253000"

#define kAPICharge @"/m.php?do=merchatpay&view=recharge&getUrl=1"

#define kAPIPay @"/m.php?do=merchatpay&view=pay&getUrl=1"

#define kAPITakeMoney @"/m.php?do=merchatpay&view=withdraw"

#define kAPIAuthorization @"/m.php?do=merchatpay&view=accredit"


#endif /* API_Header_h */
