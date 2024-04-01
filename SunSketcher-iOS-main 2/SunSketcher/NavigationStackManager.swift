//
//  File.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/7/24.
//

import Foundation
import SwiftUI


class NavigationStackManager: ObservableObject {
    @Published var stack: [AnyView] = []
    
    func push(_ view: AnyView) {
        stack.append(view)
    }
    
    func popToRoot() {
        stack.removeSubrange(0..<stack.count)
    }
    
    
}
