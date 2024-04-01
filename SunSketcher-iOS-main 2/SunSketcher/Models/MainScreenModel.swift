//
//  MainScreenModel.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/9/24.
//

import Foundation
import SwiftUI

class MainScreenModel: ObservableObject {
    @Published var isFinished: Bool = UserDefaults.standard.bool(forKey: "Finished tutorial")
    @Published var countdownDone: Bool = UserDefaults.standard.bool(forKey: "Coutdown at 0")
    
    func updateIsFinished() {
        isFinished = UserDefaults.standard.bool(forKey: "Finished tutorial")
    }
    
    func setFinished(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: "Finished tutorial")
        updateIsFinished()
    }
    
    func countdownDone(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: "Coutdownt at 0")
        countdownDone = UserDefaults.standard.bool(forKey: "Coutdown at 0")
    }
}
