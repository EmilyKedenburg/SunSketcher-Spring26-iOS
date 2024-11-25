//
//  CameraView.swift
//  Sunsketcher
//
//  Created by Tameka Ferguson on 10/9/23.
//

/*
 This file deals with processing the images taken and outputting them.
 */

import SwiftUI
import AVFoundation


struct CameraView: UIViewControllerRepresentable {
    // Defines the type of UIViewController that will be created
    typealias UIViewControllerType = UIViewController
    
    // Camera service instance to handle camera operations
    let cameraService: CameraService
    
    // Closure to handle the result of photo processing
    let didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    // Creates the UIViewController for the camera
    func makeUIViewController(context: Context) -> UIViewController {
        // Start the camera service and set the coordinator as the delegate
        cameraService.start(delegate: context.coordinator) {err in
            if let err = err {
                didFinishProcessingPhoto(.failure(err)) // Handle any errors starting the camera service
                return
            }
        }
        
        // Create a new UIViewController to display the camera preview
        let viewController = UIViewController()
        viewController.view.backgroundColor = .black
        
        // Add the camera preview layer to the view controller's view
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        cameraService.previewLayer.frame = viewController.view.bounds // Set the frame of the preview layer
        return viewController
    }
    
    // Creates the Coordinator for managing communication between the UIViewController and SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinishProcessingPhoto: didFinishProcessingPhoto)
    }
    
    // Updates the UIViewController when the SwiftUI state changes (not used here)
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
    // Coordinator class to manage AVCapturePhotoCaptureDelegate methods
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        let parent: CameraView
        private var didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> () // Closure to handle photo processing results
        
        // Initializer for the Coordinator
        init(_ parent: CameraView, didFinishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> ()) {
            self.parent = parent
            self.didFinishProcessingPhoto = didFinishProcessingPhoto
        }
        
        // Delegate method called when photo processing finishes
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                didFinishProcessingPhoto(.failure(error)) // If there's an error, pass it back using the closure
                return
            }
            
            didFinishProcessingPhoto(.success(photo)) // If successful, pass the photo back using the closure
            
        }
        
    }
    
    
}
