//
//  BackgroundTaskHandler.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 3/11/24.
//

import Foundation
import UIKit

class BackgroundTask {
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    init(handler: @escaping (BackgroundTask) -> Void) {
        let application = UIApplication.shared
        backgroundTask = application.beginBackgroundTask { [weak self] in
            self?.setTaskCompleted(success: false)
        }
        handler(self)
    }
    
    func setTaskCompleted(success: Bool) {
        let application = UIApplication.shared
        if backgroundTask != .invalid {
            application.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
            
            if success {
                print("Background task completed successfully")
            } else {
                print("Background task failed or cancelled")
            }
        }
    }
    
    func cancel() {
        setTaskCompleted(success: false)
    }
}

