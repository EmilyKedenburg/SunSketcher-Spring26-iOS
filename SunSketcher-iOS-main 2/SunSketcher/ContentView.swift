//
//  ContentView.swift
//  Sunsketcher
//
//  Created by ADMIN on 8/25/23.
//

import SwiftUI
import AVFoundation
import Photos
import CoreLocation


struct ContentView: View {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        if viewModel.NoShareScreen {
            NoSharePhotosResponse()
        } else if viewModel.SharePhotosScreen {
            SharePhotos()
        } else if viewModel.YesShareScreen {
            YesSharePhotosResponse()
        } else if viewModel.AfterPhotosReceivedScreen {
            AfterPhotosReceived()
        }else {
            MainScreen(viewModel: MainScreenModel())
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager())
    }
}
