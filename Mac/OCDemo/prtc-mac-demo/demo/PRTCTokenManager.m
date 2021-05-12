//
//  PRTCTokenManager.m
//  PRTCSDK
//
//  Created by tony on 2019/4/20.
//  Copyright © 2019年 PRTC. All rights reserved.
//  test

#import "PRTCTokenManager.h"
//#import "PRTCRequestManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation PRTCTokenManager


#pragma mark public
+ (NSString *)getTokenWithAppId:(NSString *)appID userID:(NSString *)userID roomID:(NSString *)roomID  andAppSecret:(NSString *)appSecret {
    NSString *header = [self getHeaderWithAppId:appID userID:userID roomID:roomID appSecret:appSecret];

    NSString *signature = [self getSignatureWithAppId:appID userID:userID roomID:roomID appSecret:appSecret random:[self getTimeAndRandom]];
    NSString *token = [NSString stringWithFormat:@"%@.%@",header,signature];
    return token;
}



#pragma mark private


#pragma mark-- >>>>以下获取token>>>
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

/**生成header Base64 编码*/
+ (NSString *)getHeaderWithAppId:(NSString *)appID userID:(NSString *)userID roomID:(NSString *)roomID appSecret:(NSString *)appSecret{
    NSDictionary *header = @{@"user_id": userID,
                             @"app_id": appID,
                             @"room_id": roomID};
    NSData *data = [NSJSONSerialization dataWithJSONObject:header options:NSJSONWritingPrettyPrinted error:nil];
    NSString *headerStr= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return headerStr;
}

/** 时间戳 随机32位无符号整型转16进制 */
+ (NSString *)getTimeAndRandom{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//时间戳
    NSDate *dateTwo = [NSDate date];//32位随机数
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[datenow timeIntervalSince1970]];
    NSString *timeSpTwo = [NSString stringWithFormat:@"%d", (int)[dateTwo timeIntervalSince1970]];
    timeSp = [timeSp substringWithRange:NSMakeRange(timeSp.length - 10, timeSp.length)];
    timeSpTwo = [timeSpTwo substringWithRange:NSMakeRange(timeSpTwo.length - 10, timeSpTwo.length)];
    
    //保证有8位
    NSString *randomHex = [self intToHex:timeSpTwo.intValue];
    NSString * tempStr = [NSString stringWithFormat:@"00000000%@",randomHex];
    randomHex = [tempStr substringFromIndex:randomHex.length];
    
    return [NSString stringWithFormat:@"%@%@",timeSp,randomHex];
}

+ (NSString *)intToHex:(int)intnumber
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=intnumber%16;
        intnumber=intnumber/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (intnumber == 0) {
            break;
        }
    }
    return str;
}

+ (NSString *)getSignatureWithAppId:(NSString *)appID userID:(NSString *)userID roomID:(NSString *)roomID appSecret:(NSString *)appSecret random:(NSString *)random{
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",userID,appID,random,roomID];
   NSString *signature = [self HmacSha1:appSecret data:str];
    signature = [NSString stringWithFormat:@"%@%@",signature,random];
    return signature;
}

/**
 *  对NSString进行处理
 *
 *  @param key  要加密key
 *  @param data 加密的data
 *
 *  @return 加密后的字符串
 */
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSString *hash;
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", cHMAC[i]];
    }
    hash = output;
    return hash;
}




@end
