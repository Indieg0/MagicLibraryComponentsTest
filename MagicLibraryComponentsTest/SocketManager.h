//
//  SockerManager.h
//  RotateTogether
//
//  Created by Indieg0 on 22.06.17.
//  Copyright © 2017 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFRWebSocket.h"

@interface SocketManager : NSObject <JFRWebSocketDelegate>
@property (strong, nonatomic) JFRWebSocket *socket;
@property (assign, nonatomic) BOOL isConnected;
@end
