//
//  Macro_Image.h
//  Lhkh_Base
//
//  Created by Weapon on 2017/11/19.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef Macro_Image_h
#define Macro_Image_h

/*********************************************************************************/
/*               网络图片URL             */
/*********************************************************************************/

#define ImageURL(a)                    [NSURL URLWithString:a]

/*********************************************************************************/
/*               设置图片             */
/*********************************************************************************/

#define Image(a)                       [UIImage imageNamed:a]

/*********************************************************************************/
/*               常用占位图片             */
/*********************************************************************************/

#define Image_placeHolder              Image(@"placeHolder")
#define Image_placeBannerHolder        Image(@"placeHolder_banner")
#endif /* Macro_Image_h */
