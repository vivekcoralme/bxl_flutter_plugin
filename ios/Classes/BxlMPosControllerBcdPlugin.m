//
//  BxlMPosControllerBcdPlugin.m
//  bxlflutterbgatelib
//
//  Created by OhDonggeon on 2023/11/02.
//

#import "BxlMPosControllerBcdPlugin.h"

@import frameworkMPosSDK;

static NSString* const PLATFORM_CHANNEL = @"com.bixolon.mposcontroller/bcd";

@interface BxlMPosControllerBcdPlugin()
@property MPosControllerBCD* bcd;
@end

@implementation BxlMPosControllerBcdPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName: PLATFORM_CHANNEL
                                     binaryMessenger:[registrar messenger]];
    
    BxlMPosControllerBcdPlugin* instance = [[BxlMPosControllerBcdPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (id)init {
    if ((self = [super init])) {
        self.bcd = [MPosControllerBCD new];
    }
    
    [MPosControllerBCD setEnableLog:YES saveFile:NO saveToHex:NO];
    
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    // Device APIs
    if ([@"openService" isEqualToString:call.method])
        return [self openService:call result: result];
    
    else if ([@"closeService" isEqualToString:call.method])
        return [self closeService:call result: result];
    
    else if ([@"selectInterface" isEqualToString:call.method])
        return [self selectInterface:call result: result];
    
    else if ([@"selectCommandMode" isEqualToString:call.method])
        return [self selectCommandMode:call result: result];
    
    else if ([@"setTransaction" isEqualToString:call.method])
        return [self setTransaction:call result: result];
    
    else if ([@"directIO" isEqualToString:call.method])
        return [self directIO:call result: result];
    
    else if ([@"isOpen" isEqualToString:call.method])
        return [self isOpen:call result: result];
    
    else if ([@"getDeviceId" isEqualToString:call.method])
        return [self getDeviceId:call result: result];
    
    else if ([@"setReadMode" isEqualToString:call.method])
        return [self setReadMode:call result: result];
    
    else if ([@"setKeepNetworkConnection" isEqualToString:call.method])
        return [self setKeepNetworkConnection:call result: result];
    
    else if ([@"isUsbPeripheralPrinter" isEqualToString:call.method])
        return [self isUsbPeripheralPrinter:call result:result];
    
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)openService:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* deviceId = arguments[@"device_id"] ? : @-1;
    NSNumber* timeout = arguments[@"time_out"] ? : @3;
    MPOS_RESULT nativeResult = [self.bcd openService:[deviceId integerValue] timeout:[timeout integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)closeService:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* timeout = arguments[@"time_out"] ? : @3;
    MPOS_RESULT nativeResult = [self.bcd closeService:[timeout integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)selectInterface:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* interfaceType = arguments[@"interface_type"] ? : @-1;
    NSString* address = arguments[@"address"] ? : @3;
    MPOS_RESULT nativeResult = [self.bcd selectInterface:[interfaceType integerValue] address:address];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)selectCommandMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* commandMode = arguments[@"command_mode"] ? : @-1;
    MPOS_RESULT nativeResult = [self.bcd selectCommandMode:[commandMode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setTransaction:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* transaction = arguments[@"transaction"] ? : @-1;
    MPOS_RESULT nativeResult = [self.bcd setTransaction:[transaction integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setReadMode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* mode = arguments[@"read_mode"] ? : @-1;
    MPOS_RESULT nativeResult = [self.bcd setReadMode:[mode integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)directIO:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSArray<NSNumber*>* data = arguments[@"data_array"] ? : @[];
    
    NSMutableData* dataToSend = [NSMutableData data];
    for(NSNumber* number in data){
        char byte = [number charValue];
        [dataToSend appendBytes: &byte length:1];
    }
    MPOS_RESULT nativeResult = [self.bcd directIO:dataToSend];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)isOpen:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.bcd isOpen] ? 1 : 0;
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)getDeviceId:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.bcd getDeviceId];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)setKeepNetworkConnection:(FlutterMethodCall*)call result:(FlutterResult)result {
    if (![self.bcd isOpen]) {
        NSDictionary* arguments = [call arguments];
        NSNumber* keep_connection = arguments[@"keep_connection"] ? : @0;
        [self.bcd setKeepNetworkConnection:[keep_connection integerValue]];
        result([NSNumber numberWithInteger: 0]);
    } else {
        result([NSNumber numberWithInteger: 1000]);
    }
}

- (void)isUsbPeripheralPrinter:(FlutterMethodCall*)call result:(FlutterResult)result {
    result([self.bcd isUSBPeripheralPrinter] ? @(YES) : @(NO));
}

// MARK: - MPosControllerBCD APIs

- (void)displayString:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"] ? : @"";
    NSNumber* characterset = arguments[@"character_set"] ? : @0;
    NSNumber* intCharacterset = arguments[@"international_character_set"] ? : @0;
    NSNumber* line = arguments[@"line"] ? : @0;
    MPOS_RESULT nativeResult = [self.bcd displayString:data
                                              codePage:[characterset integerValue]
                             internationalCharacterSet:[intCharacterset integerValue]
                                                  line:[line integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)clearScreen:(FlutterMethodCall*)call result:(FlutterResult)result {
    MPOS_RESULT nativeResult = [self.bcd clearScreen];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)storeImageFile:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* fileName = arguments[@"file_name"];
    NSNumber* width = arguments[@"width"] ? : @-1;
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    MPOS_RESULT nativeResult = [self.bcd storeImageFile:fileName
                                                  width:[width integerValue]
                                            imageNumber:[imageNumber integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)storeBase64Image:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSString* data = arguments[@"data"];
    NSNumber* width = arguments[@"width"] ? :@-1;
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    MPOS_RESULT nativeResult = [self.bcd storeBase64Image:data
                                                    width:[width integerValue]
                                              imageNumber:[imageNumber integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)displayImage:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    NSNumber* xPosition = arguments[@"x_pos"] ? : @0;
    NSNumber* yPosition = arguments[@"y_pos"] ? : @0;
    MPOS_RESULT nativeResult = [self.bcd displayImage:[imageNumber integerValue]
                                                 xPos:[xPosition integerValue]
                                                 yPos:[yPosition integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)clearImage:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* imageNumber = arguments[@"image_number"] ? : @-1;
    MPOS_RESULT nativeResult = [self.bcd clearImage:[imageNumber integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (void)showCursor:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = [call arguments];
    NSNumber* cursor = arguments[@"show_cursor"] ? : @0;
    MPOS_RESULT nativeResult = [self.bcd showCursor:[cursor integerValue]];
    result([NSNumber numberWithInteger:nativeResult]);
}

- (NSInteger)getDeviceId {
    return [self.bcd getDeviceId];
}

@end
