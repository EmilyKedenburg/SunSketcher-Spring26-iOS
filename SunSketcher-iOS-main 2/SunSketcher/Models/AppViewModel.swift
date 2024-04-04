//
//  AppViewModel.swift
//  Sunsketcher
//
//  Created by Tameka Ferguson on 2/23/24.
//

import SwiftUI


// Used to keep the app view on a specific screen even when the app is destroyed and reopened
class AppViewModel: ObservableObject {
    @AppStorage("NoShareScreen") var NoShareScreen = false
    @AppStorage("YesShareScreen") var YesShareScreen = false
    @AppStorage("SharePhotosScreen") var SharePhotosScreen = false
    @AppStorage("AfterPhotosReceivedScreen") var AfterPhotosReceivedScreen = false
}

