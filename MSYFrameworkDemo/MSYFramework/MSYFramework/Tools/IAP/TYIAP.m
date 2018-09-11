//
//  TYIAP.m
//  TYSDK
//
//  Created by iOS on 2016/12/19.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "TYIAP.h"
#import "GZNetwork.h"
#import "GZMd5.h"
#import "UIView+Toast.h"
#import "ChangeJsonOrString.h"
#import <StoreKit/StoreKit.h>
#import "TYProgressHUD.h"
#import "GetAppleIFA.h"
static NSString *Tmoney = NULL;
static NSString *Tcustominfo = NULL;
static NSString *TproductName = NULL;
static NSString *TproductID = NULL;
static NSString *TExt = NULL;
static NSString *TserverID = NULL;
static NSString *TserverName = NULL;
static NSString *Troleid = NULL;
static NSDictionary *TswitchDic = NULL;
static TYIAP *iap = NULL;
static NSString *orderid = NULL;
static NSString *moNey = NULL;
static NSString *serviceArea = NULL;
static MSYResponseBlock applePayBlcok = NULL;
@interface TYIAP() <SKPaymentTransactionObserver,SKProductsRequestDelegate>

@end



@implementation TYIAP


+(void)removeObser
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:iap];
}


+(void)startApplePay:(NSString *)money AndCustomInfo:(NSString *)customInfo AndProductName:(NSString *)productName AndProductID:(NSString *)productID AndExt:(NSString *)ext AndPayFinishCallback:(MSYResponseBlock)block
{
    iap = [[TYIAP alloc]init];
    Tmoney = money;
    Tcustominfo = customInfo;
    TproductName = productName;
    TproductID = productID;
    NSDictionary *extDic = [ChangeJsonOrString dictionaryWithJsonString:ext];
    TserverID = [extDic valueForKey:@"serverID"];
    Troleid = [extDic valueForKey:@"roleId"];
    TserverName = [extDic valueForKey:@"serverName"];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:iap];
    [iap applePayClick];
    
    
    applePayBlcok = block;
    
}

//苹果支付
- (void)applePayClick{
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,OrderURL];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@%@%@%@",APPID,TOKEN,UserID,TserverID,Troleid,Tmoney,TproductID]];
    
    
    NSString *body = [NSString stringWithFormat:@"appid=%@&token=%@&userid=%@&serverid=%@&servername=%@&roleid=%@&productid=%@&productname=%@&money=%@&way=%@&custominfo=%@&sign=%@&signtype=%@",APPID,TOKEN,UserID,TserverID,TserverName,Troleid,TproductID,TproductName,Tmoney,@"APP_PAY",Tcustominfo,sign,@"md5"];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    //MakeTA;
    [TYProgressHUD showMessage:@"正在创建订单，请稍等..."];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        if (dict != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [TYProgressHUD hide];
                
                
            });
            NSLog(@"苹果支付获取订单%@",dict);
            
            NSDictionary *result = dict[@"result"];
            NSNumber *code = result[@"code"];
            NSString *msg = result[@"msg"];
            if ([code isEqual:@(200)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [TYProgressHUD showMessage:@"订单创建成功，请稍等..."];
                });
                NSDictionary *orderinfo = result[@"orderinfo"];
                NSDictionary *payinfo = result[@"payinfo"];
                orderid = orderinfo[@"orderID"];
                
                moNey = orderinfo[@"money"];
                serviceArea = orderinfo[@"servername"];
                NSString *product_name = orderinfo[@"productname"];
                
                
                NSArray *product=[[NSArray alloc] initWithObjects:TproductID,nil];
                NSSet *nsset = [NSSet setWithArray:product];
                
                [self getProductInfo:nsset];
                
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //HideTA;
                    [TYProgressHUD hide];
                    
                    MakeToast(msg);
                    
                });
            }
            
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //HideTA;
                [TYProgressHUD hide];
                
                MakeToast(@"网络不给力");
            });
        }
    }];
    
}

#pragma mark 支付

-(void)getProductInfo:(NSSet*)productIDS
{
    
    
    if ([SKPaymentQueue canMakePayments])
    {
        
        SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:productIDS];
        request.delegate = iap;
        [request start];
    }
    else
    {
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //        [window hideToastActivity];
        
        //        [window makeToast:@"失败，用户禁止应用内付费购买。" duration:2 position:CSToastPositionCenter];
        //        NSLog(@"失败，用户禁止应用内付费购买.");
        dispatch_async(dispatch_get_main_queue(), ^{
            //HideTA;
            [TYProgressHUD hide];
            if (applePayBlcok != NULL) {
                applePayBlcok(-1,@{@"失败":@"-1"});
            }
        });
        
        MakeToast(@"失败，用户禁止应用内付费购买。");
    }
}


-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
    NSArray<SKProduct *> *myProduct = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %lu", myProduct.count);
    if (myProduct.count == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [TYProgressHUD hide];
            if (applePayBlcok != NULL) {
                applePayBlcok(-1,@{@"失败":@"-1"});
            }
        });
        
        MakeToast(@"无法获取产品信息，购买失败。");
       
        return;
    }
    
    for(SKProduct *product in myProduct)
    {
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
        
        
        
        SKMutablePayment * payment = [SKMutablePayment paymentWithProduct:product];
        
        payment.applicationUsername = orderid;
        
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        NSLog(@"add payment");
        
        
        
    }
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    
    
    for (SKPaymentTransaction *transaction in transactions)
    {
        NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
        
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                
                NSLog(@"交易失败");
                
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                
                NSLog(@"已经购买过该商品");
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing://商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    // Your application should implement these two methods.
    NSData *receiptData;
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0){
        
        receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    }
    else
    {
        receiptData = transaction.transactionReceipt;
    }
    
    NSString* receipt = [receiptData base64EncodedStringWithOptions:0];
    
    
    
    receipt = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                    (CFStringRef)receipt,
                                                                                    NULL,
                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                    kCFStringEncodingUTF8));
    
    
    //NSLog(@"receipt src data = %@", receipt);
    
    NSString * productID = transaction.payment.productIdentifier;
    // 苹果订单
    NSString * appleOrderId = transaction.transactionIdentifier;
    
    //你们的订单
    NSString* myOrderId = transaction.payment.applicationUsername;
    
    // NSLog(@"productIdentifier = %@", productID);
    
    
    
    // NSLog(@"-------------receipt = %@", receipt);
    
    
    if ([productID length] > 0)
    {
        
        NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,JIAOYANURL];
        NSLog(@"%@",url);
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@%@",myOrderId,APPID,UserID,TOKEN,appleOrderId]];
        
        NSString *body = [NSString stringWithFormat:@"orderid=%@&appid=%@&token=%@&userid=%@&type=%@&receipt=%@&payorderid=%@&imei=%@&sign=%@&signtype=%@",orderid,APPID,TOKEN,UserID,@"ios",receipt,appleOrderId,IMEI,sign,@"md5"];
         NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                NSDictionary *result = [dict valueForKey:@"result"];
                NSString *msg = [result valueForKey:@"msg"];
                NSLog(@"%@",msg);
                NSString *code = [NSString stringWithFormat:@"%@",[result valueForKey:@"code"]];
                if ([code isEqualToString:@"200"]) {
                    
                    
                    NSLog(@"购买成功了！！！");
                    //[MobClickGameAnalytics pay:_money source:1 coin:_money * 10];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        //                        [window hideToastActivity];
                       
                        //                        [window makeToast:@"支付成功" duration:2 position:CSToastPositionCenter];
                        //HideTA;
                        [TYProgressHUD hide];
                        
                        if (applePayBlcok != NULL) {
                            applePayBlcok(200,result);
                        }
                        
                        MakeToast(@"支付成功");
                    });
                }else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (applePayBlcok != NULL) {
                            applePayBlcok(-1,result);
                        }
                        [TYProgressHUD hide];
                    
                        MakeToast(msg);
                    });
                }
                
            }
            
            
        }];
        
        
        
    }
    
    
    
    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"失败原因%@",transaction.error);
    
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
        [TYProgressHUD hide];
        
       
        if (applePayBlcok != NULL) {
            applePayBlcok(-101,@{@"失败":@"-101"});
        }
        MakeToast(@"失败");
        
        
    }
    else
    {
        
        [TYProgressHUD hide];
       
        if (applePayBlcok != NULL) {
            applePayBlcok(-102,@{@"用户取消交易":@"-102"});
        }
        MakeToast(@"失败");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    //[self completeTransaction:transaction];
    
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}



@end
