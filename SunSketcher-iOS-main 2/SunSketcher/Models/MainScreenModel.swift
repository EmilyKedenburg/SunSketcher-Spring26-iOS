//
//  MainScreenModel.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/9/24.
//

import Foundation
import SwiftUI

// This model is used to determine where the start button leads to whether the tutorial has already been viewed or not
// If the tutorial has not been viewed then once the start button is clicked then it takes the user to the SeeOrSkip Tutorial Screen.
// If the tutorial has been viewed it immediately takes the user to the LocationVerification view.

class MainScreenModel: ObservableObject {
    @Published var isFinished: Bool = UserDefaults.standard.bool(forKey: "Finished tutorial")
    @Published var countdownDone: Bool = UserDefaults.standard.bool(forKey: "Coutdown at 0")
    
    // If the tutorial was viewed update the user defaults value.
    func updateIsFinished() {
        isFinished = UserDefaults.standard.bool(forKey: "Finished tutorial")
    }
    
    // If the tutorial was viewed
    func setFinished(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: "Finished tutorial")
        updateIsFinished()
    }
    
    
    /*func countdownDone(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: "Coutdownt at 0")
        countdownDone = UserDefaults.standard.bool(forKey: "Coutdown at 0")
    }*/
}
