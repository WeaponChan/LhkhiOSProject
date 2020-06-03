//
//  Macro_FileName.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/19.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef Macro_FileName_h
#define Macro_FileName_h

/*********************************************************************************/
/*               文件名                */
/*********************************************************************************/

//获取沙盒 temp
#define LhkhPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define LhkhPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define LhkhPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//Library/Caches 文件路径
#define LhkhFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])

#endif /* Macro_FileName_h */
