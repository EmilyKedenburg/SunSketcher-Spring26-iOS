//
//  CustomCameraView.swift
//  Sunsketcher
//
//  Created by Tameka Ferguson on 10/10/23.
//

/*
 This file controls the view of the camera.
 */

import SwiftUI
import UIKit


struct CustomCameraView: View {
    
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    let prefs = UserDefaults.standard
    
    @State var isTimerCompleted = false
    
    var body: some View {
        ZStack {
            if !isTimerCompleted {
                CameraView(cameraService: cameraService) { result in
                    switch result {
                    case .success(let photo):
                        if let data = photo.fileDataRepresentation() {
                            
                            // Convert the captured photo to UIImage
                            if let image = UIImage(data: data) {
                                
                                // Save the photo with a custom name to the document directory
                                cameraService.saveImageToDocumentDirectory(image)
                                
                                // Save photo to photo library in the "SunSketcher" album
                                cameraService.savePhotoToLibrary(photo)
                                capturedImage = image
                                
                                // I use this so that when this is called and returns true, the view can change from the camera to
                                // the next view which woud be cropping. 
                                if cameraService.allPhotosCompleted() {
                                    isTimerCompleted = true
                                }
                            } else {
                                print("Error: Unable to convert photo to UIImage")
                            }
                        } else {
                            print("Error: no image data found")
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                }
            } else {
                NextView()
            }
            
        }.onAppear{
            UIApplication.shared.isIdleTimerDisabled = true
        }
    
    }
}

struct NextView: View {
    
    var body: some View {
        CroppingImages()
        //SharePhotos()
    }
    
}
