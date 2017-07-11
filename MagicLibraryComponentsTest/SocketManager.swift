//
//  SocketManager.swift
//  RotateTogether
//
//  Created by Indieg0 on 22.06.17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import Starscream

class SocketManager: WebSocketDelegate {

    static let shared = SocketManager()
    var socket = WebSocket(url: URL.init(string: "")!)
    
    var isConnected: Bool {
        return socket.isConnected
    }
    
    private init() {
        socket.delegate = self
    }
    
    deinit {
        socket.delegate = nil
    }
    
    //MARK: - Helper Methods
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func sendMessage(_ message: String) {
        socket.write(string: message)
    }
    
    func sendData(_ data: Data) {
        socket.write(data: data)
    }
    
    //MARK: - WebSocketDelegate

    func websocketDidConnect(socket: WebSocket) {
        print("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocketDidDisconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("websocketDidReceiveMessage")
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("websocketDidReceiveData")
    }
    
}
