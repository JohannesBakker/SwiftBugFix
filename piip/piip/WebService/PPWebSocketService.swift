//
//  PPWebSocketService.swift
//  piip
//
//  Created by jimmy on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation
import Starscream
import SwiftyJSON
import XCGLogger

class PPWebSocketService: WebSocketDelegate {
    
    typealias WebSocketRequestCompletionBlock = (success: Bool, response: NSData?) -> Void
    typealias WebSocketStatusCompletionBlock = (succes: Bool) -> Void
    
    static let sharedInstance = PPWebSocketService()
    
    private var logger: XCGLogger = XCGLogger.defaultInstance()
    private var socket: WebSocket!
    
    private var requestCompletionBlock: WebSocketRequestCompletionBlock?
    private var statusCompletionBlock: WebSocketStatusCompletionBlock?
    
    init() {
        self.socket = WebSocket(url: PPEnvironment.apiURL())
        self.socket.delegate = self
    }
    
    func connect(withCompletion completion: WebSocketStatusCompletionBlock? = nil) {
        logger.debug("socket connect request")
        
        self.statusCompletionBlock = completion
        self.socket.connect()
    }
    
    func disconnect() {
        logger.debug("socket disconnect requeset")
        
        self.socket.disconnect()
    }
    
    // MAKR: - Web socket delegate
    func websocketDidConnect(socket: WebSocket) {
        logger.debug("socket connected")
        
        // socket connected
        self.statusCompletionBlock?(succes: true)
        self.statusCompletionBlock = nil
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        logger.debug("socket disconnected \(error)")
        
        // socket disconnected
        self.statusCompletionBlock?(succes: false)
        self.requestCompletionBlock?(success: false, response: nil)
        
        self.resetCompletionBlock()
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        logger.debug("received data \(data)")
        
        self.requestCompletionBlock?(success: true, response: data)
        self.requestCompletionBlock = nil
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        logger.debug("received message \(text)")
        
        self.requestCompletionBlock?(success: true, response: text.toNSData())
        self.requestCompletionBlock = nil
    }
    
    // MARK: - Request & Response
    func createTextRequest(param: JSON, withCompletion completionHandler: WebSocketRequestCompletionBlock? ) {
        logger.debug("sequence number = \(param["seq"]), method = \(param["method"]), params = \(param["params"])")
        
        // make sure, we have socket connection
        if self.socket.isConnected == true {
            
            // send request
            let jsonString: String = param.rawString(NSUTF8StringEncoding, options: [])!
            logger.debug("\(jsonString)")
            self.socket.writeString(jsonString)
            
            // setup completion block
            self.requestCompletionBlock = completionHandler
        }
        else {
            completionHandler?(success: false, response: nil)
        }
    }

    func resetCompletionBlock() {
        
        self.requestCompletionBlock = nil
        self.statusCompletionBlock = nil
    }
}