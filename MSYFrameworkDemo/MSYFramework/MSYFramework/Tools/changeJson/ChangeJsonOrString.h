//
//  ChangeJsonOrString.h
//  TYSDK
//
//  Created by iOS on 16/10/18.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeJsonOrString : NSObject

+(NSString *)DataTOjsonString:(id)object;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
