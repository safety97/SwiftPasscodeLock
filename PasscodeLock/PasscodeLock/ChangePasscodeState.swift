//
//  ChangePasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

struct ChangePasscodeState: PasscodeLockStateType {
    
    let title: String
    let description: String
    let isCancellableAction = true
    var isTouchIDAllowed = false
    
    init() {
        
        title = localizedStringFor("PasscodeLockChangeTitle", comment: "Change passcode title")
        description = localizedStringFor("PasscodeLockChangeDescription", comment: "Change passcode description")
    }
    
    func accept(passcode: String, from lock: PasscodeLockType) {
        
        do {
            if try lock.repository.check(passcode: passcode) {
            
                let nextState = SetPasscodeState()
            
                lock.changeState(nextState)
            
            } else {
            
                lock.delegate?.passcodeLockDidFail(lock)
            }
        } catch {
            return
        }
    }
}
