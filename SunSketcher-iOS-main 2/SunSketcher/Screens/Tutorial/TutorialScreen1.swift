//
//  TutorialScreen1.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/2/24.
//

import SwiftUI

struct TutorialScreen1: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var shouldRefreshView: Bool
    
    let prefs = UserDefaults.standard
    
    let txt = "In order to ensure smooth operation, please turn on the 'Do Not Disturb' feature on your phone. You can turn it off after your images have been taken, soon after the total eclipse ends."
    
    var body: some View {
        Text("Hello")
    }// body view
}

struct TutorialScreen1_Previews: PreviewProvider {
    
    static var previews: some View {
        TutorialScreen1(shouldRefreshView: .constant(false))
    }
}
