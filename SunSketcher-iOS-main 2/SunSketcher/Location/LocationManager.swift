//
//  LocationManager.swift
//  Sunsketcher
//
//  Created by Tameka Ferguson on 9/6/23.
//


/*
 This file is done to retrieve the location of the user as well for requesting  permission to
 use the user's location. From this you can get the user's latitude, longitude, and altitude.
 */

import Foundation
import MapKit
import CoreLocation

@MainActor
class LocationManager: NSObject, ObservableObject, @preconcurrency CLLocationManagerDelegate {
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    
    static let shared = LocationManager()
    
    var timer: Timer?
    
    private var locationCallback: ((CLLocation) -> Void)?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // chooses how accurate you want the location to be
        locationManager.distanceFilter = kCLDistanceFilterNone // this is used to track all movements of the phone.
        //Note: that within the app the location is only saved in the database once so it doesn't keep changing.
        //The lat | lon keeps updating on the countdown screen but that does not alter what is recorded.
    }
    
    func requestLocationUpdate(callback: @escaping (CLLocation) -> Void) {
        locationCallback = callback
        locationManager.startUpdatingLocation()
    }
    

    func requestLocationPermission() {
        locationManager.requestAlwaysAuthorization()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            //print("Latitude:", lastLocation.coordinate.latitude)
            //print("Longitude:", lastLocation.coordinate.longitude)
            
            self.location = lastLocation
            
            self.region = MKCoordinateRegion(
                center: lastLocation.coordinate,
                latitudinalMeters: 5000,
                longitudinalMeters: 5000)
            
        }
    }
    
    /* relays authorization status
       & ensures the phone starts sending coordiantes only
       after permission is granted */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location permission granted")
            manager.startUpdatingLocation() // Remember to update Info.plist
            
        case .denied:
            print("Location permission denied")
                  
        case .restricted:
            print("Location restricted")
                  
        case .notDetermined:
            print ("Location permission not determined")
                  
        @unknown default:
            break
        }
    }
}

/*extension LocationManager: CLLocationManagerDelegate {
    
    Moved func locationManager to class
        
}*/
