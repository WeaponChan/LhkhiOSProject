//
//  Macro_Font.h
//  Lhkh_Base
//
//  Created by Weapon on 2017/11/19.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef Macro_Font_h
#define Macro_Font_h

//默认字号
#define TitleFontSize          16 //主标题
#define SubTitleFontSize       14 //副标题
#define TipTitleFontSize       12 //提示标题

/*********************************************************************************/
/*               系统字体             */
/*********************************************************************************/

#define systemFontUltraLight(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightUltraLight];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-UltraLightP2" size:fontSize];\
    }\
    (font);\
})


#define systemFontThin(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-Thin" size:fontSize];\
    }\
    (font);\
})


#define systemFontLight(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-Light" size:fontSize];\
    }\
    (font);\
})


#define systemFontRegular(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-Regular" size:fontSize];\
    }\
    (font);\
})



#define systemFontMedium(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];\
    } else {\
        font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];\
    }\
    (font);\
})


#define systemFontSemibold(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-MediumP4" size:fontSize];\
    }\
    (font);\
})


#define systemFontBold(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-MediumP4" size:fontSize];\
    }\
    (font);\
})


#define systemFontHeavy(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightHeavy];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-Heavy" size:fontSize];\
    }\
    (font);\
})


#define systemFontBlack(fontSize)\
({ \
    UIFont *font = [[UIFont alloc] init];\
    if (@available(iOS 8.2, *)) {\
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightBlack];\
    } else {\
        font = [UIFont fontWithName:@".HelveticaNeueInterface-Heavy" size:fontSize];\
    }\
    (font);\
})



/*********************************************************************************/
/*               导入的字体             */
/*********************************************************************************/



#endif /* Macro_Font_h */
