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

#define kAPIBASEURL @""

//extern NSString *ApiUrl;
//extern NSString *codeKey;

//人才大厅
#define kAPITalentList    @"/m.php?do=talent&view=list"


#endif /* API_Header_h */
