//
//  SockerManager.m
//  RotateTogether
//
//  Created by Indieg0 on 22.06.17.
//  Copyright © 2017 None. All rights reserved.
//

#import "SocketManager.h"


@implementation SocketManager

+ (instancetype)shared {
    static SocketManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SocketManager alloc] init];
    });
    return shared;
}

- (BOOL)isConnected {
    return self.socket.isConnected;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.socket = [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:@""] protocols:nil];
        self.socket.delegate = self;
    }
    return self;
}

- (void)dealloc {
    self.socket.delegate = nil;
}

#pragma mark - Helper Methods

- (void)connect {
    [self.socket connect];
}

- (void)disconnect {
    [self.socket disconnect];
}

- (void)sendMessage:(NSString*)message {
    [self.socket writeString:message];
}

- (void)sendData:(NSData*)data {
    [self.socket writeData:data];
}

#pragma mark - JFRWebSocketDelegate

- (void)websocketDidConnect:(JFRWebSocket*)socket {
    
}

- (void)websocketDidDisconnect:(JFRWebSocket*)socket error:(NSError*)error {
    
}

- (void)websocket:(JFRWebSocket*)socket didReceiveMessage:(NSString*)string {
    
}

- (void)websocket:(JFRWebSocket*)socket didReceiveData:(NSData*)data {
    
}

@end
